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


/**
 *
 * @param {string} s
 * @returns {string}
 */
export function mergetron(s, insta, instb){
    var linhas = s.split("\n");
    var regx = /INST_(?<ins>[A-Z]+)\((?<opr>.+)\);/;
    var fez = false;
    while(1){
        let u = linhas.findIndex(function(v,i,a){
            if(!v.includes(insta)){
                return false;
            }
            if(a[i+1].includes(instb)){
                return true;
            }
            return false;
        });

        if(u < 0 ){
            break;
        }

        fez = true;

        let a = linhas[u].match(regx).groups;
        let b = linhas[u+1].match(regx).groups;

        linhas[u] = `   MERGED_${a.ins}_${b.ins}(${a.opr}, ${b.opr});`;        
        linhas[u+1] = "";
    }
    if(!fez){
        return s;
    }

    return linhas.join("\n");
}
