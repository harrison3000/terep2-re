//@ts-check

import {readFile, writeFile} from "node:fs/promises";

export function preclassifier(command){
    if(command.match(/^[a-z]\w+:$/i)){
        return "FUNC_LABEL";
    }
    if(command.match(/^\.\w+:$/i)){
        return "LOCAL_LABEL";
    }
    var clc = command.split(" ",2)[0].toLowerCase();

    switch(clc){
        case "":     return "EMPTY";
        case "ret":  return "RETURN";
        case "jmp":  return "UNCOND_JUMP";
        case "jcxz": return "JCXZ";
        case "dw":   return "DW";
        case "call": return "CALL";
    }

    return "something";
}

var inte = 0;
export function debugIntermediaries(array){
    const j = array.map(JSON.stringify).join("\n");
    writeFile(`/tmp/yaasm2c_${inte}.jsonl`, j);
    inte++
}

/**
 * does the same thing as strings.Cut does in Go
 * 
 * @param {string} str 
 * @param {string} sep 
 */
export function splitabom(str, sep){
    var i = str.indexOf(sep);
    if(i < 0){
        return [str, undefined];
    }
    var a = str.slice(0,i);
    var b = str.slice(i+1);
    return [a,b];
}

export function classifyRegs(r){
    var val = r.toUpperCase();
    function toString(){
        return "cpu->" + val;
    }

    if(val.match(/^[CDEFG]S$/)){
        return {tipo: "REG", tipo2: "SEGMENT", val, toString};
    }
    if(val.match(/^E[ABCD]X$/) || val.match(/^E[SD]I$/) || val === "EBP"){
        return {tipo: "REG", tipo2: "GPR32", val, toString};
    }
    if(val.match(/^[ABCD]X$/) || val.match(/^[SD]I$/) || val === "BP"){
        return {tipo: "REG", tipo2: "GPR16", val, toString};
    }
    if(val.match(/^[ABCD][HL]$/)){
        return {tipo: "REG", tipo2: "GPR8", val, toString};
    }

    return false;
}

export function classifyMem(m){
    const mt = m.match(/^(d?word|byte) (([DEFG]S)\:)?\[(.+)\]$/)
    if(!mt){
        return false;
    }
    
    return {tipo: "MEM", tipo2:mt[1], miolo: mt[4], seg: mt[3], toString:mem2string};
}

export function classifyLit(l){
    function toString(){
        return l;
    }

    return {tipo: "LIT", val: l, toString};
}


function mem2string(){
    var miolomole = this.miolo.replaceAll(/(SI|DI|BX)/g, "cpu->$1");
    var s = this.tipo2.toUpperCase();

    if(this.seg){
        return  `SMEM_${s}(cpu->${this.seg},${miolomole})`;
    }
    return  `MEM_${s}(${miolomole})`;
}