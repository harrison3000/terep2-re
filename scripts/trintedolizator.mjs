//@ts-check

import { readFile, writeFile } from 'node:fs/promises';

/** @type {string} */
const codigos = await readFile("reasm/maincode.asm","utf8");

const fixed = codigos
    .replaceAll("call far ","call ")
    .replaceAll(/^ +(STOS|LODS|MOVS|REP ST|XLAT)/gm, "    a16 $1")
    .replaceAll(/^ +(LOOP|JCXZ)  /gm, "    L_$1")
    ;




await writeFile("reasm32/maincode32.asm",fixed);
