//@ts-check


import { readFile, writeFile } from 'node:fs/promises';

/** @type {string} */
const codigos = await readFile("reasm/maincode.asm","utf8");


/** @type {string[][]} */
const funcs = [];

/** @type {string[]} */
let atual = [];

for(let l of codigos.split("\n")){
    if(l.match(/^[fF]\w+:/)){
        funcs.push(atual);
        atual = [];
    }
    atual.push(l);
}
funcs.push(atual);
atual = [];

const renames = {};

function entrancia(func, mark){
    var f = funcs.find(x => x[0].startsWith(func));
    if(!f){
        console.log(`func "${func}" not found somehow`);
        return;
    }

    for(let l of f){
        const lm = l.match(/ *call +(\w+)+/i);
        if(!lm){
            continue;
        }
        const fn = lm[1];
        renames[fn] = renames[fn] || {};
        renames[fn][mark] = true;
        entrancia(fn, mark);
    }
}

entrancia("f_init", "INIT");
entrancia("FUN_timer_5680", "PHYSICS");


const subs = codigos.replaceAll(/FUN_1000_\w{4}/g,function(m){
    var mark = renames[m];
    if(!mark){
        return m;
    }
    var k = Object.keys(mark);
    if(k.length === 1){
        return m.replace("1000", k[0]);
    }
    if(k.length === 2){
        return m.replace("1000", "SHARED");
    }
})

await writeFile("reasm/renomeadas.asm", subs);

debugger;