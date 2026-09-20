import {readFile, writeFile} from "node:fs/promises";
import { preclassifier } from "./utils_converter.mjs";

/**
 * @type {string[]}
 */
const f = (await readFile("reasm/maincode.asm", "utf-8")).split("\n");

const normalized = f.map(function(l){
    const sp = l.split(";", 2);
    const command = sp[0].replaceAll(/\s+/g," ").trim();    
    var classe = preclassifier(command);    

    return {classe, command, comment: sp[1], original: l};
});

debugger;