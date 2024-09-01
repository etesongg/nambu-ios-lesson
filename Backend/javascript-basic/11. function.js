function sayHello() { // 함수정의
    console.log("Hello");
}
// sayHello(); // 함수호출

function sayHello1(name) { // 매개변수
    console.log(`Hello ${name}`);
}
// sayHello1("World");
// sayHello1(1);

// 함수 정의-반환값
function sayHello2(name) {
    return `Hello ${name}`;
}
let greeting = sayHello2("RM");
// console.log(greeting);
// console.log(sayHello2("morning"));

function add(num1, num2) {
    return num1 + num2;
}
let result = add(4,5);
// console.log(result);

// 함수 정의-Rest 매개변수
function sum(...nums){ // (nums)로만 하면 리스트의 첫번째 숫자밖에 안 나옴
    console.log(nums); 
}
// sum(1, 2, 3, 4, 5); // [ 1, 2, 3, 4, 5 ]

function sum1(num1, num2, ...nums) {
    console.log(num1); // 1
    console.log(num2); // 2
    console.log(...nums); // (nums) [ 3, 4, 5 ], (...nums) 3 4 5 로 ...을 붙이면 스프레드
}
// sum1(1, 2, 3, 4, 5);

// 함수의 할당
const sayHello3 = sayHello; // 함수를 할당할때는 ()를 붙이지 않는다.
// sayHello3();
// sayHello();

function calc(num1, num2, op) {
    switch (op) {
        case "+":
            return num1 + num2; // break; 말고 바로 return 해주기
        case "-":
            return num1 - num2;         
        case "*":
            return num1 * num2;           
        case "/":
            return num1 / num2;   
        default: // switch문 만들때 defalt 넣어주기
            return "잘못된 연산자입니다."        
    }
}

// const calculator = calc;
// console.log(calculator(2, 4, "+"));

// 함수의 매개변수
function sayHi(name) {
    console.log(`Hi ${name}`)
}
function greet(name, callback) { // 콜백함수: 다른 함수의 파라미터로써 전달되는 함수를 말한다.
    console.log(name);
    callback(name); // sayHi(name)이나 sayHello1(name)이 불려지는거랑 같음
}
// greet("우영우", sayHi);
// greet("선생님", sayHello1)

// 다양한 함수 정의 방식
// 함수 선언문
function add1(n1, n2) {
    return n1 + n2
}
// console.log(add1(1, 2));

// 함수 표현식 
let add2 = function (n1, n2) {
    return n1 + n2
}
// console.log(add2(1, 2));

// 화살표 함수(익명 함수)
const add3 = (n1, n2) => {
    return n1 + n2
}
// console.log(add3(1, 2))

// 다양한 함수 정의 방식
const add4 = (n1, n2) => n1 + n2
// console.log(add3(3, 4));
// console.log(add4(3, 4));






