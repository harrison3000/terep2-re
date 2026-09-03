//@ts-check

import { readFile, writeFile } from 'node:fs/promises';

/** @type {string} */
const codigos = await readFile("reasm/maincode.asm","utf8");

const fixed = codigos
    .replaceAll("call far ","call ")
    .replaceAll(/^ +(STOS|LODS|MOVS|REP ST|XLAT)/gm, "    a16 $1")
    .replaceAll(/^ +(LOOP|JCXZ)  /gm, "    L_$1")
    .replaceAll("[CS:BX +", "[CS:EBX * 2 +")
    .replace("AND BX, 15", "AND EBX, 15")
    .replace("AND BX, 63", "AND EBX, 63")
    .replaceAll(/dw( +)\./g,"dd$1.")
    .replaceAll("ADD         SP,0x2", "ADD         ESP,0x2")
    ;


const linhas = fixed.split("\n");

/**
 * 
 * @param {RegExpExecArray} rgrs 
 * @returns {string}
 */
function classifica(rgrs){
    const mem = rgrs[4].trim();
    const seg = rgrs[3];

    //TODO alertar sem tamamnho

    if(!seg){
        if(mem.match(/^0x[0-9a-f]+$/i)){
            return "SIMPLES";
        }
        if(mem.match(/^[a-z]\w+$/i)){
            return "VAR";
        }
    }else{
        return "SEGMENTED";
    }

    return "UNK";
}

for(let i = 0; i < linhas.length; i++){
    const memRegex = /(dword|word|byte)? *(([D-G]S)\:)?\[(..+?)\]/g;
    const linha = linhas[i];

    const rgx = Array.from(linha.matchAll(memRegex));
    if(rgx.length === 0){
        continue;
    }
    if(linha.includes("CS:BX")){
        //the jump tables
        continue;
    }

    const rgrs = rgx.find(function(r){
        const c = classifica(r);
        return !(c === "SIMPLES" || c === "VAR");
    });

    if(!rgrs){
        //simple and var will be correctly handled by nasm, no need to do anything
        continue;
    }

    let uu="    ";
    if(classifica(rgrs) === "SEGMENTED"){
        uu += `mk_addr_seg EBP, seg_${rgrs[3]}, [${rgrs[4]}]`;
    }else{
        uu += `mk_addr     EBP, [${rgrs[4]}]`;
    }

    linhas[i] = linha.replace(rgrs[0], `${rgrs[1]} [EBP]`);
    linhas.splice(i,0,uu);
    i++;
}


await writeFile("reasm32/maincode32.asm", linhas.join("\n"));
