//@ts-check

import { readFile, open } from 'node:fs/promises';
import { findAddressesInASM, parseKnown } from './dtz_utils.mjs';

const dados = await readFile("memdumps/data.bin");
const discovered = findAddressesInASM("reasm/maincode.asm");
const known = parseKnown("reasm/known_vars.txt");


/** @type {('z'|'u'|'s'|'d'|'Z')[]} */
const catg = [...dados].map(function(v){
    if(v === 0){
        return "z"; //zero
    }
    return "u"; //unknown
});




//=========================================================================

let aldevars = known.concat(discovered);
for(let v of aldevars){
    //TODO pointer finder
    let a = v.addrNum;
    if(v.type === "string"){
        const e = dados.indexOf(0, a);
        const st = dados.toString("ascii", a, e);

        v.valor = `db "${st}", 0`;
        v.skip = st.length + 1;
        continue;
    }
    if(v.type === "ptr"){
        const val = dados.readUint16LE(a);
        const nn = aldevars.find(x => x.addrNum === val);
        if(nn){
            v.valor = "dw " + nn.name;
        }else{
            v.valor = `dw 0x${val.toString(16)} ; pointer to unknown var`;
        }

        v.skip = 2;
        continue;
    }
    if(v.type === "word"){
        const val = dados.readUint16LE(a);
        v.valor = val === 0 ? "resb 2" : "dw 0x" + val.toString(16) ;
        v.skip = 2;
        continue;
    }
    if(v.type === "dword"){
        const val = dados.readUint32LE(a);
        v.valor = val === 0 ? "resb 4" : "dd 0x" + val.toString(16) ;
        v.skip = 4;
        continue;
    }
    if(v.type === "byte"){
        v.valor = "db 0x" + dados[a].toString(16);
        v.skip = 1;
        continue;
    }

    v.skip = 1;
}

for(let v of aldevars){
    const a = v.addrNum
    catg.fill("d", a, a+v.skip);
}

const zeroruns = [];
for(let mt of catg.join("").matchAll(/z{3,}/g)){
    let r = {idx: mt.index, len: mt[0].length};
    zeroruns.push(r);
    catg.fill("Z",r.idx, r.idx+r.len)
}

const undefruns = [];
for(let mt of catg.join("").matchAll(/[zu]{1,32}/g)){
    undefruns.push({idx: mt.index, len: mt[0].length});
}

const out = await open("reasm/dataseg.asm", "w");
await out.write(";data segment at home:\n")

for(let i = 0; i < dados.length; ){
    aldevars = aldevars.filter(x => x.addrNum >= i); // this is so I can see the values vanishing when debugging, not a optimization
    const v = aldevars.find(x => x.addrNum === i);
    if(!v){
        let zr = zeroruns.find(x => x.idx === i);
        if(zr){
            await out.write("\n    resb " + zr.len + "\n");
            i += zr.len;
            continue;
        }

        let ur = undefruns.find(x => x.idx == i);
        let l = ur?.len ?? 1;
        let zp = [];
        for(let j = 0;j < l;j++){
            zp.push(`0x${dados[i].toString(16)}`);
            i++;
        }

        await out.write("\n    ;unknown data\n    db " + zp.join(", ") + "\n");
        continue
    }

    let sai = `
${v.name}:
    ${v.valor}
`;

    i += v.skip;    

    await out.write(sai);

}

await out.close();
