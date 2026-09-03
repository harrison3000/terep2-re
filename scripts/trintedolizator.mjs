//@ts-check

import { readFile, writeFile } from 'node:fs/promises';

/** @type {string} */
const codigos = await readFile("reasm/maincode.asm","utf8");

const fixed = codigos
    .replaceAll("call far ","call ")
    .replaceAll(/^ +(STOS|LODS|MOVS|REP ST|XLAT)/gm, "    a16 $1")
    .replaceAll(/^ +(LOOP|JCXZ)  /gm, "    L_$1")
    .replaceAll("[CS:BX +", "[CS:EBX * 2 +")
    .replace("AND BX, 15", "AND EBX, 15")
    .replace("AND BX, 63", "AND EBX, 63")
    .replaceAll(/dw( +)\./g,"dd$1.")
    .replaceAll("ADD         SP,0x2", "ADD         ESP,0x2")
    ;




await writeFile("reasm32/maincode32.asm",fixed);
