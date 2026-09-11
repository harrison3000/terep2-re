export const map_comparisions = {
    "CMP_E":  (a, b) => `${a} == ${b}`,
    "CMP_NE": (a, b) => `${a} != ${b}`,
}

map_comparisions["CMP_Z"]  = map_comparisions["CMP_E"];
map_comparisions["CMP_NZ"] = map_comparisions["CMP_NE"];