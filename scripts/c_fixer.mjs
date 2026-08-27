import {readFile, writeFile} from "node:fs/promises";
import { cmp_sig_map, cmp_unsig_map, tamanhador } from "./utils.mjs";

const f = (await readFile("raw_c.cpp")).toString();

const superRegex = /(?<whole_inst>INST_(?<opcodeA>[A-Z]{2,5})\((?<things>.*)\)(;[^\n]*)?)\n\s*JUMP«(?<opcodeB>.+)»/g;

const stats = {};
var total = 0;

//FIXME sometimes a single test can set the flags for 2 jumps! it happens for example in function FUN_1000_0d2a

let cnt = 0;

const fixed = f.replaceAll(superRegex, function(...args){
    const {opcodeA, opcodeB, things, whole_inst} = args.at(-1);
    const [operandA, operandB] = things.split(",").map(x => x.trim());

    const stk = `${opcodeA}_${opcodeB}_${(operandA === operandB)}`;

    if(opcodeA == "CMP" && opcodeB in cmp_unsig_map){
        let op = cmp_unsig_map[opcodeB];
        return `if (${operandA} ${op} ${operandB})`;
    }

    if(opcodeA == "CMP" && opcodeB in cmp_sig_map){
        let op = cmp_sig_map[opcodeB];
        let opb = `SIGNED(${operandB})`;
        const opB_is_value = /^(0x[a-fA-F,0-9]+)|([0-9]+)$/.test(operandB);
        if(opB_is_value){
            let t = tamanhador(operandA);
            opb = `(${t})(${operandB})`;
        }

        return `if (SIGNED(${operandA}) ${op} ${opb})`;
    }

    if(stk === "TEST_JZ_false"){
        return `if (!(${operandA} & ${operandB}))`
    }

    if(stk === "TEST_JNZ_false"){
        return `if (${operandA} & ${operandB})`
    }

    if(opcodeA == "TEST" && operandA === operandB){
        //an AND of a register with itself doesnt change the value, its the same as a test
        //for all intents and purposes
        switch(opcodeB){
            case "JZ":  return `if (${operandA} == 0)`;
            case "JNZ": return `if (${operandA} != 0)`;
            case "JS": 
            case "JL":
                return `if (SIGNED(${operandA}) <  0)`;
            case "JNS":
            case "JGE":
                return `if (SIGNED(${operandA}) >= 0)`;
        }
    }

    if(["DEC", "SUB", "ADD", "AND", "TEST", "CMP"].includes(opcodeA)){
        let vname = "jTmp_" + (cnt++).toString(32)
        let wl = `auto ${vname} = ` + whole_inst + "\n   ";

        switch(opcodeB){
            case "JZ":  return wl + `if (${vname} == 0)`;
            case "JNZ": return wl + `if (${vname} != 0)`;
            case "JS":  return wl + `if (SIGNED(${vname}) <  0)`;
            case "JNS": return wl + `if (SIGNED(${vname}) >= 0)`;
        }
    }
    
    stats[stk] = stats[stk] ? stats[stk] + 1 : 1;
    total++;

    return args[0];
}).replaceAll(/JUMPTABLE((.*\n)+?).+FIMJUMPTABLE/g, function(a, b){

    const u = [""];
    u.push("   switch(cpu->BX){")

    const lbs = Array.from(b.matchAll(/VAL_DW«(.+)»/g)).map((v, i) => `      case ${i*2}: goto ${v[1]};`);
    u.push(...lbs);

    u.push("      default: __builtin_trap();");
    u.push("   }");
    u.push("");

    return u.join("\n");
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

