//@ts-check
import {readFile, writeFile} from "node:fs/promises";

/**
 * @type {string[]}
 */
const f = (await readFile("reasm/maincode.asm", "utf-8")).split("\n");


for(let pass=0; pass < 1000; pass++){
    for(let i =0;i<f.length-1;i++){
        const l1match = f[i].match(/^ *((DEC|INC) +(.+)|(SUB|ADD) +([^,]+),)/)

        const l2match = f[i+1].match(/^ *(JZ|JNZ|JS|JNS)/);
        
        if(l2match && l1match){
            let val = l1match[5] || l1match[3];
            val = val.trim();
            
            let st = `    CMP    ${val}, 0`;

            f.splice(i+1, 0, st);
            break;
        }
    }
}

await writeFile("reasm/maincode.asm", f.join("\n"));

