//@ts-check

import {readFile, writeFile} from "node:fs/promises";
import { map_comparisions } from "./utils.mjs";

/**
 * @type {string[]}
 */
const f = (await readFile("raw_c.cpp", "utf-8")).split("\n");

/**
 * @type {string}
 */
const u = f.map(function(z){
    if(z.match(/^ *(JUMP|SET)«/)){
        return "R";//flag receiver
    }
    if(z.match(/^ *(COMP)/)){
        return "G"; //flag generator
    }

    return "_";
}).join("");

const sem = Array.from(u.matchAll(/_R/g)).map(x => `${f[x.index]} | ${f[x.index+1]}, ${x.index}`).toSorted();
//console.log("Unhandled jumps: ", sem);



for(let jump of u.matchAll(/GR+/g)){
    const c = f[jump.index].match(/ +COMP«(.+),(.+),(.+)»/).map(x => x.trim());
    const [_tudo, tipo, op1, op2] = c;

    for(let i = 1; i < jump[0].length;i++){
        const idx = i + jump.index;
        const j = f[idx].match(/ + (JUMP|SET)«(.+),(.+)»/)?.map(x => x.trim());
        const [_tudo, jtipo, jop1, jop2] = j;
        let tipoz = [tipo, jop1].join("_");
        if(tipo === "TEST"){
            let ig = op1 === op2 ? "IG" : "DIF";
            tipoz += "_" + ig;
        }

        let oopz = tipoz;
        const cpz = map_comparisions[tipoz];
        if(typeof cpz === "function"){
            oopz = cpz(op1,op2);
        }

        let l = "!!!!!!!!!!!!!!"
        if(jtipo === "JUMP"){
            l = `   if(${oopz}) ${jop2}`;
        }else if(jtipo === "SET"){
            l = `   ${jop2} = (${oopz});`;
        }
        f[idx] = l;
    }

    f[jump.index] = "//old:" + _tudo ;
}

await writeFile("lifted/maincode.cpp", f.join("\n"));

debugger;