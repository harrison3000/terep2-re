import { readFileSync, writeFile } from 'node:fs';

/**
 * 
 * @param {string} arq File name
 * @returns {string[]}
 */
function file2lines(arq){
    const l = readFileSync(arq, "utf-8").split("\n");
    return l;
}


export function findAddressesInASM(filename){
    const l = file2lines(filename);
    const addrs = l.map(function(s){
        if(!s.includes("[0x")){
            return null;
        }

        let x = /(q?word|byte) +\[0x([a-f0-9]{1,4})\]/.exec(s);
        if(x !== null){
            return {type : x[1], addr: x[2], addrNum: parseInt(x[2], 16), s};
        }
        debugger; // should never get here
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
    }).map(function(u) {
        return {
            addr: u.addr,
            type: u.type,
            name: "dt_addr_" + u.addr,
            addrNum: u.addrNum,
            valor: "",
            skip: 0,
        };
    });

    return addrs;
}

export function parseKnown(filename){
    const l = file2lines(filename);

    const addrs = l.filter(x => {
        x = x.trim();
        if(x.startsWith(";")){
            return false;
        }
        return x !== "";
    }).map(s => {
        let vals = s.split(",").map(s => s.trim());
        return {
            addr: vals[0],
            type: vals[1],
            name: vals[2],
            addrNum: parseInt(vals[0], 16),
            valor: "",
            skip: 0,
        };
    })

    return addrs;
}