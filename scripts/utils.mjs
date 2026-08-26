export const cmp_sig_map = {
    "JG":  ">",
    "JGE": ">=",
    "JL":  "<",
    "JLE": "<=",
};

export const cmp_unsig_map = {
    "JZ":  "==",
    "JNZ": "!=",
    "JC":  "<",
    "JNC": ">=",
    "JBE": "<=",
    "JA":  ">",
}

/**
 *
 * @param {string} val
 */
export function tamanhador(val){
    var st = val.slice(0, 6);
    if(st === "cpu->E" || st === "MEM_DW"){
        return "int32_t";
    }
    if(st === "MEM_BY" || /[LH]$/.test(val)){
        return "int8_t";
    }
    return "int16_t";
}
