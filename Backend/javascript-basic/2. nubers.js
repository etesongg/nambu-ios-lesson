let integer = 123;
let negative = -123;
let double = 1.23;
let binary = 0b10101010;
let octal = 0o157;
let hex = 0x7a3f;
let inf = 1/0;
let minf = -1/0;
let nan = 1/'hello';
let nan2 = 1/'123';

console.log(`
    ${integer}
    ${negative}
    ${double}
    ${binary}
    ${octal}
    ${hex}
    ${inf}
    ${minf}
    ${nan}
    ${nan2}`)