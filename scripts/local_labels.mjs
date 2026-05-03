//@ts-check

import { readFile, writeFile } from 'node:fs/promises';

/** @type {string[]} */
const codigos = await readFile("reasm/maincode.asm","utf8").then(s => s.split("\n"));


/** @type {string[][]} */
const funcs = [];

/** @type {string[]} */
let atual = [];

for(let l of codigos){
    if(l.match(/^[fF]\w+:/)){
        funcs.push(atual);
        atual = [];
    }
    atual.push(l);
}
funcs.push(atual);

const melhoradas = funcs.map(function(linhas){
    var subs = {};

    let regexlab = /^(LAB_1000_[a-f0-9]{4}):/;

    linhas
        .map(s => s.match(regexlab))
        .filter(rm => rm !== null)
        .forEach(function(v,i){
            subs[v[1]] = `.LAB_LOC_${i+1}`;
        });

    const consub = linhas.map(function(s) {
        let sma = s.match(regexlab)
        if(sma){
            let v = sma[1];
            return subs[v] + ":";
        }

        return s.replace(/LAB_1000_[a-f0-9]{4}/g,function(a,...b){
            if(a in subs){
                return subs[a];
            }
            return a;
        })
    }).join("\n");
    
    return consub;
})


await writeFile("reasm/labels_locais.asm", melhoradas.join("\n"));

debugger;