let num1 = 5;
let num2 = 3;
let num3 = 2;

console.log(`
    ${-num1}
    ${num1 + num2}
    ${num1 - num2}
    ${num1 * num2}
    ${num1 / num2}
    ${num1 % num2}
    `)

console.log(`
    비교, 논리연산자 실습
    ${num1 > num2 && num2 > num3}
    ${num1 == num2 && num1 > num2}
    ${num1 == num2 || num1 > num2}
    ${num1 - num2 > num2 - num3 && num2 == 0}
    ${num1 + num2 > num3 || num3 > 0}
    `)