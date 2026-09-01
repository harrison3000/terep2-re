import {readFile, writeFile} from "node:fs/promises";

const f = (await readFile("raw_c.cpp")).toString();

const fixed = f.replaceAll(/JUMP«(.+)»/g, function(_tudo, opcode){
    var jumpMap = {
        "JZ":  "cpu->ZF",
        "JNZ": "!cpu->ZF",
        "JC":  "cpu->CF",
        "JNC": "!cpu->CF",
        "JS":  "cpu->SF",
        "JNS": "!cpu->SF",
        "JP":  "cpu->PF",
        "JNP": "!cpu->PF",
        "JLE": " cpu->ZF || (cpu->SF != cpu->OF) /*JLE*/",
        "JG" : "!cpu->ZF && (cpu->SF == cpu->OF) /*JG*/",
        "JGE": "cpu->SF == cpu->OF /*JGE*/",
        "JL" : "cpu->SF != cpu->OF /*JL*/",
        "JBE": "cpu->CF || cpu->ZF /*JBE*/",
        "JA" : "!cpu->CF && !cpu->ZF /*JA*/",
    };

    var op = jumpMap[opcode];
    if(!op){
        throw "cant do dat";
    }

    return `if (${op})`;
}).replaceAll(/\/\/JUMPTABLE((.*\n)+?).+FIMJUMPTABLE/g, function(a, b){

    const u = [""];
    u.push("   switch(cpu->BX){")

    const lbs = Array.from(b.matchAll(/VAL_DW«(.+)»/g)).map((v, i) => `      case ${i*2}: goto ${v[1]};`);
    u.push(...lbs);

    u.push("      default: __builtin_trap();");
    u.push("   }");
    u.push("");

    return u.join("\n");
})
.replaceAll(/^ +MEM_DWORD\(0xe9(ec|f0|f4).+$/gm, `   float tmp_$1 = SIGNED(cpu->EAX);`)
.replaceAll(/INST_FINIT.+$/gm, function(){
    return `
   tmp_ec *= tmp_ec;
   tmp_f0 *= tmp_f0;
   tmp_f4 *= tmp_f4;


   float ressq = __builtin_sqrtf(tmp_ec + tmp_f0 + tmp_f4);
   cpu->EAX = (int32_t)ressq;
    `;


}).replaceAll(/   INST_F.+\n/g, "")
.replace("cpu->EAX = MEM_DWORD(0xe9e8);", "")
.replaceAll("INST_ADD(cpu->SP, 0x2);", "DUMMY_POP_WORD();")
.replaceAll(/goto (F.+);/g, "{$1(cpu); return;} //was tailcall") // needs more testing
.replaceAll(/REP«([A-Z]+)»/g, `while(cpu->CX){
    INST_$1();
    cpu->CX--;
   }`)
.replaceAll(`INST_SHL(cpu->AX, 0x1);
   INST_RCL(cpu->DX, 0x1);`, "SPECIAL_CASE_SHL_RCL();")
;


await writeFile("lifted/maincode.cpp",fixed);

