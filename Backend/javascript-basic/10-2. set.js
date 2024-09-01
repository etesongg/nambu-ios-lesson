// set 선언과 초기화
const set = new Set([1, 2, 3, 4, 5]); // Set(5) { 1, 2, 3, 4, 5 } 
console.log(set);

// 사이즈 확인
console.log(set.size); // 5

// item 추가
set.add(6);
console.log(set); // Set(6) { 1, 2, 3, 4, 5, 6 }
set.add(6);
console.log(set); // Set(6) { 1, 2, 3, 4, 5, 6 }

// 존재유무
console.log(set.has(3));
console.log(set.has(6));