console.log("=========1");

console.log("hello world");
console.log(`hello ${"world"}`);

console.log("=========2");

console.log(23 + 45);
console.log(23 - 45);
console.log(23 * 45);
console.log(10 / 5);
console.log(10 % 3);

console.log("안녕하세요");
console.log('안녕하세요 "홍길동"');
console.log("안녕하세요 \n홍길동입니다.");
console.log("안녕하세요 \t홍길동입니다."); // \t 탭
console.log("안녕하세요 \\홍길동입니다.");

console.log("안녕하세요" + "홍길동입니다.");
console.log(`52 + 45 = ${52 + 45}`);

console.log(52 > 52); // false
console.log(52 == 52); // true
console.log(52 != 52); // false

console.log(52 >= 52 && 52 > 52); // and
console.log(52 >= 52 || 52 > 52); // or

console.log("=========3");

let pi;
console.log(pi); // undefined
pi = 3.141592;
console.log(pi);

let pi2 = 3.141592;
console.log(pi2);

let radius = 12;
let area = pi * radius * radius;
let length = pi * 2 * radius;
console.log(`넓이: ${area}`);
console.log(`둘레: ${length}`);

console.log("=========4");

let output = "안녕하세요 ";
output += "홍길동 입니다.";
console.log(output);

let num = 0;
num++;
console.log(`num++: ${num}`);
num--;
console.log(`num--: ${num}`);

console.log("=========5");

console.log(typeof 10); // number
console.log(typeof "hello"); // string
console.log(typeof true); // boolean

console.log(typeof function () {}); // function
console.log(typeof {}); // object

let beta;
console.log(typeof beta); // undefined

console.log("=========6");

console.log(String(52));
console.log(typeof 52);
console.log(typeof String(52));

console.log(Number("45"));
console.log(Number("H")); // NaN
console.log(Number(true)); // 1

console.log(isNaN(Number("hello"))); // true

console.log(Boolean(0)); // false
console.log(Boolean(NaN)); // false
console.log(Boolean(1)); // true
console.log(Boolean("H")); // true
console.log(Boolean("")); // false

console.log(25 + 125);
console.log("25" + 125); // 25125
console.log("25" - 125); // -100

console.log("=========7");

console.log(`50 == "50" : ${50 == "50"}`);
console.log(`50 === "50" : ${50 === "50"}`);

console.log("=========8");

const test = "변경불가";
console.log(`before : ${test}`);
// test = "Hello";
// console.log(`after : ${test}`); // TypeError: Assignment to constant variable.

console.log("=========9");

let data = new Date();

if (data.getHours() < 12) {
  console.log(`오전입니다. ${data.getHours()}`);
} else if (data.getHours() >= 12) {
  console.log(`오후입니다. ${data.getHours()}`);
}

console.log("=========10");

let date = new Date();
let hours = date.getHours();

if (hours < 11) {
  console.log("아침 먹을 시간입니다.");
} else {
  if (hours < 15) {
    console.log("점심 먹을 시간입니다.");
  } else {
    console.log("저녁 먹을 시간 입니다.");
  }
}

console.log("=========11");

// let input = 12;

// switch (input % 2) {
//   case 0:
//     return console.log("짝수입니다.");
//   case 1:
//     return console.log("홀수입니다.");
//   default:
//     break;
// }

console.log("=========12");

let test1;

console.log(test1); // undefined
test1 = typeof test1 == "undefined" ? "initial" : test1;
console.log(test1); // initial
