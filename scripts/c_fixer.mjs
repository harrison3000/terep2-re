//@ts-check

import {readFile, writeFile} from "node:fs/promises";
import { mergetron, trataCondicao } from "./utils.mjs";

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

for(let unjump of u.matchAll(/_R/g)){
    const idx = unjump.index + 1
    const j = f[idx].match(/ + JUMP«(.+),(.+)»/)?.map(x => x.trim());
    if(j[1] !== "C"){
        console.log("not JC, not touching that!");
        continue;
    }

    f[idx] = "   if(CHECK_CFLAG()) " + j[2];
}



for(let jump of u.matchAll(/GR+/g)){
    const c = f[jump.index].match(/ +COMP«(.+),(.+),(.+)»/).map(x => x.trim());
    const [_tudo, tipo, op1, op2] = c;

    for(let i = 1; i < jump[0].length;i++){
        const idx = i + jump.index;
        const j = f[idx].match(/ + (JUMP|SET)«(.+),(.+)»/)?.map(x => x.trim());
        const [_tudo, jtipo, jop1, jop2] = j;
        
        const oopz = trataCondicao(tipo, jop1, op1, op2);

        let l = "!!!!!!!!!!!!!!"
        if(jtipo === "JUMP"){
            l = `   if(${oopz}) ${jop2}`;
        }else if(jtipo === "SET"){
            l = `   ${jop2} = (${oopz});`;
        }
        f[idx] = l;
    }

    f[jump.index] = "//REMOVEME";
}

mergetron(f, "ADD", "ADC");
mergetron(f, "SUB", "SBB");
mergetron(f, "SHL", "RCL");

const filtratada = f.filter(x => x !== "//REMOVEME");

await writeFile("lifted/maincode.cpp", filtratada.join("\n"));

debugger;