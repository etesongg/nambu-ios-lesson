const numbers = [1, 2, 3, 4, 5];
console.log(numbers[0]); // 1

for(let i=0;i< numbers.length;i++){
    console.log(numbers[i]);
}

let array = new Array(2); // 숫자 하나는 size 지정, [ <2 empty items> ]
console.log(array);
console.log(array[0]); // undefined
array = new Array(1, 2, 3, 4, 5); // 숫자 여러개는 배열 값 지정
console.log(array);

// item 수정 삭제
numbers[3] = -4;
numbers[5] = 6;
console.log(numbers); // [ 1, 2, 3, -4, 5, 6 ]

delete numbers[1];
console.log(numbers) // [ 1, <1 empty item>, 3, -4, 5, 6 ]

// Array 활용
let bts1 = ["진", "슈가", "제이홉", "RM"];
console.log(bts1);
let bts2 = new Array("지민", "뷔", "정국");
console.log(bts2);

// indexOf 아이템의 인덱스 번호를 반환
// includes 아이템이 해당 배열에 포함되어 있는지 여부를 판단, true, false 반환
console.log(bts1.indexOf("슈가")); // 1
console.log(bts1.includes("RM")); // true
console.log(bts1.includes("지민")); // false

// 추가
bts1.push("차은우"); // 맨뒤에 추가, append  [ '진', '슈가', '제이홉', 'RM', '차은우' ]
console.log(bts1);
console.log(bts1.length);

bts1.unshift("이도현"); // 맨앞에 추가 [ '이도현', '진', '슈가', '제이홉', 'RM', '차은우' ]
console.log(bts1);

// 삭제
let first = bts1.shift(); // 첫번째 아이템 삭제, 후 반환
console.log(bts1);
console.log(first); // 이도현

let last = bts1.pop(); // 마지막 아이템 삭제, 후 반환
console.log(last); // 차은우
console.log(bts1); 

// 특정한 index에서 삭제 splice(index, count)
const deleted = bts1.splice(1, 1);
console.log(bts1); // [ '진', '제이홉', 'RM' ]
console.log(deleted);

// 특정한 index에서 추가 splice(index, 0, item, item,...)
bts1.splice(1, 0, "차은우", "이도현");
console.log(bts1); // [ '진', '차은우', '이도현', '제이홉', 'RM' ]

// slice 사용, 일부분으로 새로운 배열을 만듬(복사), 원본은 그대로
let bts3 = bts1.slice(0,2);
console.log(bts3); // [ '진', '차은우' ]
console.log(bts1); // [ '진', '차은우', '이도현', '제이홉', 'RM' ]

bts3 = bts1.slice(-1);
console.log(bts3); // [ 'RM' ]
bts3 = bts1.slice(-3);
console.log(bts3); // [ '이도현', '제이홉', 'RM' ]

// 배열 합치기 
console.log(bts1) // [ '진', '차은우', '이도현', '제이홉', 'RM' ]
console.log(bts2) // [ '지민', '뷔', '정국' ]
const bts = bts1.concat(bts2); // [ '진', '차은우', '이도현', '제이홉', 'RM', '지민', '뷔', '정국' ]
console.log(bts);

// 역순 배열
const rbts = bts.reverse();
console.log(rbts);

// 배열을 문자열로 합하기
let members = bts.join(", ");
console.log(members); // 정국, 뷔, 지민, RM, 제이홉, 이도현, 차은우, 진

