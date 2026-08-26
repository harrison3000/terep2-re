import {readFile, writeFile} from "node:fs/promises";

const f = (await readFile("raw_c.cpp")).toString();

const superRegex = /INST_(?<opcodeA>[A-Z]{2,5})\((?<things>.*)\)(?<rest_of_line>;[^\n]*)?\n\s*JUMP«(?<opcodeB>.+)»/g;

const stats = {};
var total = 0;


const cmp_sig_map = {
    "JG":  ">",
    "JGE": ">=",
    "JL":  "<",
    "JLE": "<=",
};

const cmp_unsig_map = {
    "JZ":  "==",
    "JNZ": "!=",
    "JC":  "<",
    "JNC": ">=",
    "JBE": "<=",
    "JA":  ">",
}

//FIXME sometimes a single test can set the flags for 2 jumps! it happens for example in function FUN_1000_0d2a

const fixed = f.replaceAll(superRegex, function(...args){
    const {opcodeA, opcodeB, things, comment} = args.at(-1);
    const [operandA, operandB] = things.split(",").map(x => x.trim());

    const stk = `${opcodeA}_${opcodeB}_${(operandA === operandB)}`;

    const opB_is_value = /(0x[a-fA-F,0-9]+)|([0-9]+)/.test(operandB);

    if(opcodeA == "CMP" && opcodeB in cmp_unsig_map){
        let op = cmp_unsig_map[opcodeB];
        return `if (${operandA} ${op} ${operandB})`;
    }

    if(opcodeA == "CMP" && opcodeB in cmp_sig_map && !opB_is_value){
        let op = cmp_sig_map[opcodeB];
        return `if (SIGNED(${operandA}) ${op} SIGNED(${operandB}))`;
    }

    if(stk === "TEST_JZ_true"){
        return `if (${operandA} == 0)`
    }

    if(stk === "TEST_JZ_false"){
        return `if (!(${operandA} & ${operandB}))`
    }

    if(stk === "TEST_JNZ_false"){
        return `if (${operandA} & ${operandB})`
    }
    
    stats[stk] = stats[stk] ? stats[stk] + 1 : 1;
    total++;

    return args[0];
});


var falta = Object.entries(stats)
    .toSorted((a,b) => b[1] - a[1])
    .map(function([comb, qtd]){
        var [inst, jump, eq_operands] = comb.split("_");
        var percent = (qtd/total * 100).toFixed(1) + "%";
        return {inst, jump, eq_operands, qtd, percent};
    });
console.table(falta);
console.log("Total: ", total);

//TODO pegar quais operacoes precisam setar o last_res

await writeFile("lifted/maincode.cpp",fixed);

