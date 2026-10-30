//@ts-check

//
// Format:
//   0x01..0xFF  -> Direct copy
//   0x00 N      -> Zero run (N = 1..255)
//   0x00 0x00   -> End
import { readFile, writeFile } from "node:fs/promises";

const input = await readFile("memdumps/data.bin");

const out = [];
let i = 0;

while (i < input.length) {
  const b = input[i];
  if (b !== 0) {
    out.push(b);
    i++;
    continue;
  }
  let run = 0;
  while (i < input.length && input[i] === 0 && run < 255) {
    run++;
    i++;
  }
  out.push(0, run);
}

out.push(0,0);

const b = new Uint8Array(out);

await writeFile("memdumps/data_compact.bin", b);
console.log(`${input.length} bytes -> ${out.length} bytes`);