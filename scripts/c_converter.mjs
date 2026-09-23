//@ts-check

import {readFile, writeFile} from "node:fs/promises";
import { classifyRegs, classifyLit, classifyMem, debugIntermediaries, preclassifier, splitabom, doTheThingInst } from "./utils_converter.mjs";

/**
 * @type {string[]}
 */
const f = (await readFile("reasm/maincode.asm", "utf-8")).split("\n");

const normalized = f.map(function(l){
    const sp = splitabom(l, ";");
    const command = sp[0].replaceAll(/\s+/g," ").trim();    
    var classe = preclassifier(command);

    return {classe, command, comment: sp[1], original: l};
});

for(let i = normalized.length - 1; i > 0; i--){
    if(normalized[i].classe !== "FUNC_LABEL"){
        continue;
    }
    if(normalized[i].original === "f_init:"){
        break;
    }
    while(i > 0){
        i--;
        let ni = normalized[i];
        if(!ni.comment){
            normalized.splice(i+1,0,{classe: "F_END"});
            break;
        }
    }
}

debugIntermediaries(normalized);

const ops = normalized.map(function(l){
    if(l.classe !== "something"){
        return l;
    }

    let [opcode, operandss] = splitabom(l.command, " ");
    let operands = [];
    if(operandss){
        operands = splitabom(operandss, ",")
            .filter(x => x !== undefined)
            .map(function(v){
                v = v.trim();
                var r = classifyRegs(v);
                var m = classifyMem(v);
                var l = classifyLit(v);
                return r||m||l;
            })
            ;
    }
    opcode = opcode?.toUpperCase();

    return {...l, classe: "INST", operands, opcode};
});

ops.push({classe: "F_END"});

debugIntermediaries(ops);


const u = ops.map(function(a){
    const c = a.classe;
    if(c === "EMPTY"){
        if(a.comment === undefined){
            return "";
        }
        return a.original.replace(";", "//");
    }
    if(c === "FUNC_LABEL"){
        const f = a.command.slice(0,-1);
        return `void ${f}(cpu_ctx *cpu){    `;
    }
    if(c === "INST"){
        let v = doTheThingInst(a);
        if(a.comment){
            v += " //" + a.comment;
        }
        return "   " + v;
    }
    if(c === "CALL"){
        let f = a.command.split(" ").at(-1);
        let c = `   ${f}(cpu);`;
        if(a.comment){
            c += " //" + a.comment;
        }
        return c;
    }
    if(c === "LOCAL_LABEL"){
        let l = a.command.slice(1);
        return "   " + l;
    }
    if(c === "RETURN"){
        return "   return;";
    }
    if(c === "F_END"){
        return "}\n";
    }

    //debugger;
    return "ERRO" + JSON.stringify(a);
})

await writeFile("raw_c.cpp", u.join("\n"));

debugger;