//@ts-check

import { readFile, writeFile } from 'node:fs/promises';

/** @type {string} */
const codigos = await readFile("reasm/maincode.asm","utf8");

const fixed = codigos
    .replaceAll("call far ","call ")
    .replaceAll(/^ +(STOS|LODS|MOVS[BWD]|XLAT)/gm, "    CALL  F_WRAP_$1")
    .replaceAll(/^ +REP ST/gm, "CALL F_WRAP_REP_ST")
    .replaceAll(/^ +(LOOP|JCXZ)  /gm, "    L_$1")
    .replaceAll("[CS:BX +", "[CS:EBX * 2 +")
    .replace("AND BX, 15", "AND EBX, 15")
    .replace("AND BX, 63", "AND EBX, 63")
    .replaceAll(/dw( +)\./g,"dd$1.")
    .replaceAll("ADD         SP,0x2", "ADD         ESP,0x2")
    .replace("nova_linha", "nova_linha - data_start")
    ;

//TODO also remove mov segment register


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
    if(seg){
        return "SEGMENTED";
    }
    if(mem.match(/^0x[0-9a-f]+$/i)){
        return "SIMPLES";
    }
    if(mem.match(/^[a-z]\w{2,}$/i)){
        return "VAR";
    }
    if(mem.match(/^[a-z]\w{2,} \+ \d+$/i)){
        return "VAR + NUM";
    }
    if(mem.startsWith("BX + CSD")){
        return "BX + VAR";
    }


    return "UNK";
}

for(let i = 0; i < linhas.length; i++){
    const memRegex = /(dword|word|byte)? *(([D-G]S)\:)?\[(..+?)\]/g;
    const linha = linhas[i];

    const rgx = Array.from(linha.replace(/;.+$/, "").matchAll(memRegex));    

    const rgrs = rgx.find(function(r){
        const c = classifica(r);
        return !c.startsWith("VAR");
    });

    if(!rgrs){
        //simple and var will be correctly handled by nasm, no need to do anything
        continue;
    }

    if(deveIgnorar(linha)){
        continue;
    }

    let uu="";
    let sub = `${rgrs[1]} [EBP]`;
    let classe = classifica(rgrs);

    if(classe === "SIMPLES"){
        linhas[i] = linha.replace(`[${rgrs[4]}]`, "[data_start + " + rgrs[4] + "]");
        continue;
    }

    if(classe === "SEGMENTED"){
        uu = `mk_addr_seg EBP, seg_${rgrs[3]}, [${rgrs[4]}]`;
    }else if (classe === "BX + VAR"){
        uu = "movsx ebp, BX";
        sub = rgrs[0].replace("BX", "EBP");
    }else{
        uu = `mk_addr     EBP, [${rgrs[4]}]`;
    }

    linhas[i] = linha.replace(rgrs[0], sub);
    linhas.splice(i,0,"    " + uu);
    i++;
}


await writeFile("reasm32/maincode32.asm", linhas.join("\n"));

/**
 * 
 * @param {string} l 
 * @returns {boolean}
 */
function deveIgnorar(l){
    if(l.includes("CS:EBX")){
        //the jump tables
        return true;
    }
    if(l.match(/^ +LEA/)){
        return true;
    }
    return false;
}