// const add = require("./ch03_01"); // 단일
// console.log(add(2, 3));

// const subtract = require("./ch03_01");
// console.log(subtract(5, 1));

// const calc = require("./ch03_01"); // 여러개
// console.log(calc.add(2, 3));
// console.log(calc.subtract(5, 1));

const calc = require("./ch03_01");
const nums = calc(2, 3);
console.log(nums.add());
console.log(nums.subtract());
