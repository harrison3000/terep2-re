export function preclassifier(command){
    if(command.match(/^[a-z]\w+:$/i)){
        return "FUNC_LABEL";
    }
    if(command.match(/^\.\w+:$/i)){
        return "LOCAL_LABEL";
    }
    var clc = command.split(" ",2)[0].toLowerCase();

    switch(clc){
        case "":     return "EMPTY";
        case "ret":  return "RETURN";
        case "jmp":  return "UNCOND_JUMP";
        case "jcxz": return "JCXZ";
        case "dw":   return "DW";
        case "call": return "CALL";
    }

    return "something";
}