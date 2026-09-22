//@ts-check

import {readFile, writeFile} from "node:fs/promises";
import { classifyRegs, classifyLit, classifyMem, debugIntermediaries, preclassifier, splitabom } from "./utils_converter.mjs";

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

    return {...l, classe: "INST", operands, opcode};
});

debugIntermediaries(ops);


const u = ops.map(function(a){


    return "ERRO" + JSON.stringify(a);
})

await writeFile("raw_c.cpp", u.join("\n"));

debugger;