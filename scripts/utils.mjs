export const map_comparisions = {
    "CMP_E":  (a, b) => `${a} == ${b}`,
    "CMP_NE": (a, b) => `${a} != ${b}`,

    "TEST_Z_IG" : (a) => `${a} == 0`,
    "TEST_NZ_IG": (a) => `${a} != 0`,

    "TEST_Z_DIF": (a, b) => `(${a} & ${b}) == 0`,
    "TEST_Z_ID" : (a, b) => `(${a} & ${b}) != 0`,
}

map_comparisions["CMP_Z"]  = map_comparisions["CMP_E"];
map_comparisions["CMP_NZ"] = map_comparisions["CMP_NE"];