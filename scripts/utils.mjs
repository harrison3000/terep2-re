const map_comparisions = {
    "CMP_E":  (a, b) => `${a} == ${b}`,
    "CMP_NE": (a, b) => `${a} != ${b}`,
    "CMP_C":  (a, b) => `${a} <  ${b}`,
    "CMP_NC": (a, b) => `${a} >= ${b}`,
    "CMP_BE": (a, b) => `${a} <= ${b}`,
    "CMP_A":  (a, b) => `${a} >  ${b}`,

    "CMP_G":  condicionadorSig.bind(null, ">"),
    "CMP_GE": condicionadorSig.bind(null, ">="),
    "CMP_L":  condicionadorSig.bind(null, "<"),
    "CMP_LE": condicionadorSig.bind(null, "<="),

    "CMP_NS": comps.bind(null, ">="),
    "CMP_S":  comps.bind(null, "<"),

    "TEST_Z_IG" : (a) => `${a} == 0`,
    "TEST_NZ_IG": (a) => `${a} != 0`,

    "TEST_Z_DIF":   (a, b) => `(${a} & ${b}) == 0`,
    "TEST_NZ_DIF" : (a, b) => `(${a} & ${b}) != 0`,

    "TEST_S":  (a, b) => siszzs(a,b) + " != 0",
    "TEST_NS": (a, b) => siszzs(a,b) + " == 0",

    "TEST_GE_IG": a => `SIGNED(${a}) >= 0`,

    "TEST_L_IG" : a => `SIGNED(${a}) < 0`,

    "TEST_P" :  (a, b) => `PARITY(${a} & ${b})`,
    "TEST_NP" : (a, b) => `PARITY(${a} & ${b}) == 0`,
}

map_comparisions["CMP_Z"]  = map_comparisions["CMP_E"];
map_comparisions["CMP_NZ"] = map_comparisions["CMP_NE"];

export function trataCondicao(tipocmp,tipojmp,op1,op2){
    const eq = op1 === op2;
    
    let tipoz = [tipocmp, tipojmp].join("_");
    let ig = eq ? "_IG" : "_DIF";

    let oopz = tipoz;
    const cpz = map_comparisions[tipoz+ig] || map_comparisions[tipoz];
    if(typeof cpz === "function"){
        return cpz(op1,op2);
    }

    if(tipocmp === "TEST"){
        return oopz+ig;    
    }
    return oopz;
}


function condicionadorSig (op, a, b){
    if(b.startsWith("0x") || b.match(/^-?[0-9]+$/)){
        let t = tamanhador(a);
        let unsig = parseInt(b);
        if(unsig >= t[1]/2){
            b = unsig - t[1];
        }
        return `SIGNED(${a}) ${op} ${b}`;
    }

    return `SIGNED(${a}) ${op} SIGNED(${b})`;
}

function comps(op, a, b){
    if(b === "0"){
        //TODO enter here for other ints?
        return `SIGNED(${a}) ${op} 0`;
    }
    return `SIGNED(${a}) ${op} SIGNED(${b})`;
}

function siszzs(a, b){
    var t = tamanhador(a);
    var uuu = "0x" + (t[1]/2).toString(16);
    if(uuu === b){
        return `(${a} & ${b})`;
    }
    if(a === b){
        return `(${a} & ${uuu})`;
    }

    return `(${a} & ${b} & ${uuu})`;
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
    if(st === "MEM_BY" || /cpu->[A-D][LH]$/.test(val)){
        return ["int8_t",0x100];
    }
    if(st === "MEM_WO" || /cpu->[A-D]X$/.test(val) ){
        return ["int16_t", 0x10000];
    }

    throw "unreq size";
}


/**
 *
 * @param {string[]} linhas
 */
export function mergetron(linhas, insta, instb){
    var regx = /INST_(?<ins>[A-Z]+)\((?<opr>.+)\);/;
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

        let a = linhas[u].match(regx).groups;
        let b = linhas[u+1].match(regx).groups;

        linhas[u] = `   MERGED_${a.ins}_${b.ins}(${a.opr}, ${b.opr});`;        
        linhas[u+1] = "//REMOVEME";
    }
}

export function replacetron(array, regex, f){
    for(let i = 0; i < array.length;i++){
        let m = array[i].match(regex);
        if(m){
            array[i] = f(m);
        }
    }
}