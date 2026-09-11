const map_comparisions = {
    "CMP_E":  (a, b) => `${a} == ${b}`,
    "CMP_NE": (a, b) => `${a} != ${b}`,
    "CMP_G":  condicionadorSig(">"),
    "CMP_GE": condicionadorSig(">="),
    "CMP_L":  condicionadorSig("<"),
    "CMP_LE": condicionadorSig("<="),

    "TEST_Z_IG" : (a) => `${a} == 0`,
    "TEST_NZ_IG": (a) => `${a} != 0`,

    "TEST_Z_DIF": (a, b) => `(${a} & ${b}) == 0`,
    "TEST_Z_ID" : (a, b) => `(${a} & ${b}) != 0`,
}

map_comparisions["CMP_Z"]  = map_comparisions["CMP_E"];
map_comparisions["CMP_NZ"] = map_comparisions["CMP_NE"];

export function trataCondicao(tipocmp,tipojmp,op1,op2){
    const eq = op1 === op2;
    
    let tipoz = [tipocmp, tipojmp].join("_");
    if(tipocmp === "TEST"){
        let ig = eq ? "IG" : "DIF";
        tipoz += "_" + ig;
    }

    let oopz = tipoz;
    const cpz = map_comparisions[tipoz];
    if(typeof cpz === "function"){
        return cpz(op1,op2);
    }

    return oopz;
}


function condicionadorSig(op){
    return function(a, b){
        if(b.startsWith("0x") || b.match(/^-?[0-9]+$/)){
            let t = tamanhador(a);
            let unsig = parseInt(b);
            if(unsig >= t[1]/2){
                b = unsig - t[1];
            }
            return `SIGNED(${a}) ${op} ${b}`;
        }

        return `SIGNED(${a}) ${op} SIGNED(${b})`;
    };
}

/**
 *
 * @param {string} val
 */
export function tamanhador(val){
    var st = val.slice(0, 6);
    if(st === "cpu->E" || st === "MEM_DW"){
        return ["int32_t",0x100000000];
    }
    if(st === "MEM_BY" || /[LH]$/.test(val)){
        return ["int8_t",0x100];
    }
    return ["int16_t", 0x10000];
    //TODO e quando for variavel?
}