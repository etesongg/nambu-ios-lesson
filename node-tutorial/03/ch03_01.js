// const add = (a, b) => a + b;
// function subtract(a, b) {
//   return a - b;
// }

// module.exports = subtract; // 단일
// console.log(module);

// module.exports.subtract = subtract;
// module.exports.add = add;

module.exports = function (a, b) {
  return {
    add() {
      return a + b;
    },
    subtract() {
      return a - b;
    },
  };
};
