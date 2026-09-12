//@ts-check

import {readFile, writeFile} from "node:fs/promises";
import { mergetron, replacetron, trataCondicao } from "./utils.mjs";

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

replacetron(f, /^ +REP«(.+)»/, (m) => `   while(cpu->CX){
      INST_${m[1]}();
      cpu->CX--;
   }`);
replacetron(f, /INST_ADD.+->SP/, () => "   DUMMY_POP_WORD();");

replacetron(f, /CVTSI2SS\(cpu->XMM([012]),/, (m) => `   float tmp_f${m[1]} = SIGNED(cpu->EAX);`);
replacetron(f, /CVTSS2SI/, (m) => 
`   tmp_f0 *= tmp_f0;
   tmp_f1 *= tmp_f1;
   tmp_f2 *= tmp_f2;

   float ressq = __builtin_sqrtf(tmp_f0 + tmp_f1 + tmp_f2);
   cpu->EAX = (int32_t)ressq;`);

replacetron(f, /XMM[0-3]/, () => "//REMOVEME");

for(let i =0; i < 2; i++){
    const ini = f.findIndex(s => s.includes("cpu->BX + ZZZZ"));
    const fim = f.findIndex(s => s.includes("LAB_RUIM:"));

    let x = 0;
    const miniarray = f.slice(ini, fim);

    replacetron(miniarray, /^ +VAL_DW«(.+)»/, function(m){
        var u = `     case ${x}: goto ${m[1]};`;
        x += 2;
        return u;
    });

    miniarray[0] = "";
    miniarray[1] = "   switch(cpu->BX){";
    miniarray[miniarray.length-2] = "      default: __builtin_trap();";
    miniarray[miniarray.length-1] = "   }";

    f.splice(ini-1, miniarray.length+3, ...miniarray);
}


mergetron(f, "ADD", "ADC");
mergetron(f, "SUB", "SBB");
mergetron(f, "SHL", "RCL");

const filtratada = f.filter(x => x !== "//REMOVEME");

await writeFile("lifted/maincode.cpp", filtratada.join("\n"));

debugger;