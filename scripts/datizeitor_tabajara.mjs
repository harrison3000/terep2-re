//@ts-check

import { readFile, writeFile } from 'node:fs/promises';

const dados = await readFile("memdumps/data.bin");
const usedAddresses = (await readFile("reasm/maincode.asm"))
    .toString("utf8")
    .split("\n")
    .map(function(s){
        if(!s.includes("[0x")){
            return null;
        }

        let x = /(q?word|byte) +\[0x([a-f0-9]{1,4})\]/.exec(s);
        if(x !== null){
            return {type : x[1], addr: x[2], addrNum: parseInt(x[2], 16), s};
        }
        //for some reason ghidra ommits the size for AX
        let y = /( E?A[XL],)?\[0x([a-f0-9]{1,4})\](,E?A[XL])?$/.exec(s);
        if(y !== null && (y[1] || y[3])){
            let siz = "word";
            if(y[0].includes("EAX")){
                siz = "dword";
            }else if(y[0].includes("AL")){
                siz = "byte";
            }
            return {type: siz, addr: y[2], addrNum: parseInt(y[2], 16), s};
        }

        return null;        
    })
    .filter(x => x !== null)
    .sort((a,b) => a.addrNum - b.addrNum)
    .filter(function(v, i, a){
        //remove dups
        if(i === 0){
            return true;
        }
        var ant = a[i-1];
        return v.addrNum !== ant.addrNum;
    })
    ;

/** @type {('z'|'u'|'s'|'d')[]} */
const catg = [...dados].map(function(v){
    if(v === 0){
        return "z"; //zero
    }
    return "u"; //unknown
});

function printloc(a){
    var aa = idx.toString(16);
    console.log(";%s at %s (%d)", a, aa, idx);
}

/** @type {Item[]} */
let coisas = [];

class Item {
    inicio = 0;
    len = 0;
    getval = function(){};
}

function emmitStrings(idx, num){    
    for(let i = 0; i < num; i++){
        let inicio = idx;
        let len = dados.subarray(idx).findIndex(x => x == 0);
        let sl = dados.toString("ascii", idx, idx + len);

        len++; //+1 because zero terminator
        idx += len;

        let it = new Item;
        it.inicio = inicio;
        it.len = len;
        it.getval = () => `db "${sl}", 0`;

        coisas.push(it);
        catg.fill("s", inicio, inicio + len);
    }
}

function findRun(ch, callback){
    var total = catg.length;
    var idx = 0;
    while(idx < total){
        if(catg[idx] != ch){
            idx++;
            continue;
        }

        let inicio = idx;
        let len = catg.slice(idx).findIndex(x => x != ch);
        if(len == -1){
            //chegou no final
            len = total - idx;
        }

        idx += len;

        let it = new Item;
        it.inicio = inicio;
        it.len = len;

        callback(it);
        coisas.push(it);
    }
}

function zeroRuns(){
    findRun("z",
        function(it){
            let len = it.len;
            it.getval = () => `resb ${len} ;unkown zeros`;
        }
    )
}

function unkRuns(){
    findRun("u", function(it){
        let d = dados.slice(it.inicio, it.inicio + it.len);
        var u = [];
        d.forEach(x => {
            u.push("0x" + x.toString(16));
        })

        it.getval = () => "db " + u.join(", ");
        //debugger;
    });
}

function processData(){
    const sizes = {
        dword: [4, "dd", "readUint32LE"],
        word: [2, "dw", "readUint16LE"],
        byte: [1, "db", "readUint8"],
    }

    for(let ad of usedAddresses){
        const [len, opcode, func] = sizes[ad.type];
        const adn = ad.addrNum;
        const adnl = adn + len;
        const theCat = catg.slice(adn, adnl).join("");
        if(/[^zu]/.test(theCat)){
            console.warn("address of already categorized data: " + ad.addr);
            continue
        }

        catg.fill("d", adn, adnl);
        let d = "";
        if(/^z+$/.test(theCat)){
            d = `resb ${len}`;
        }else{
            let u = dados.slice(adn, adnl);
            let v = u[func]().toString(16);          
            d = `${opcode} 0x${v}`;
        }

        let it = new Item;
        it.inicio = adn;
        it.len = len;
        it.getval = () => d;

        coisas.push(it);
    }
}

//=========================================================================

emmitStrings(0, 2);
emmitStrings(0x1a03, 7);
emmitStrings(0x5b01, 5);
emmitStrings(0x5b38, 5);

processData();

zeroRuns();
unkRuns();

const known = {
    "db10" : "v_image_segment",
    "6a" : "v_gravity",

    "1a4d" : "v_palette",

    "1a45" : "v_memblock_a",
    "1a47" : "v_memblock_b",
    "1a49" : "v_memblock_c",
    "1a4b" : "v_memblock_d",

    "5bba" : "v_num_loaded_cars",
};

coisas.sort((a,b) => a.inicio - b.inicio );

var st = [";data segment at home"];

coisas.forEach(x => {
    var a = x.inicio.toString(16);
    var  k = known[a];
    if(k){
        st.push(k + ":  ;current address: 0x" + a);
    }else{
        st.push(`dt_addr_${a}:`);
    }
    st.push("    " + x.getval());

    st.push("");
})

var uu = st.join("\n");
await writeFile("reasm/dataseg.asm", uu);