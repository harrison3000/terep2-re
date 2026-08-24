import {readFile, writeFile} from "node:fs/promises";

const f = (await readFile("raw_c.cpp")).toString();

const superRegex = /INST_(?<opcodeA>[A-Z]{2,5})\((?<things>.+)\)(?<rest_of_line>;[^\n]*)?\n\s*JUMP«(?<opcodeB>.+)»/g;

const stats = {};
var total = 0;

const fixed = f.replaceAll(superRegex, function(...args){
    const {opcodeA, opcodeB, things, comment} = args.at(-1);
    const [operandA, operandB] = things.split(",").map(x => x.trim());

    const stk = `${opcodeA}_${opcodeB}_${(operandA === operandB)}`;

    if(stk === "CMP_JZ_false"){
        return `if (${operandA} == ${operandB})`
    }

    if(stk === "CMP_JNZ_false"){
        return `if (${operandA} != ${operandB})`
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
    
    if(!["JMP", "JCXZ"].includes(opcodeB)){
        stats[stk] = stats[stk] ? stats[stk] + 1 : 1;
        total++;
    }

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

await writeFile("lifted/maincode.cpp",fixed);