// Map 선언과 초기화
// 키값은 중복 안 됨
const map = new Map([["nick", "슈가"], ["group", 'bts'], ["gender", "남"],]);
console.log(map); // Map(3) { 'nick' => '슈가', 'group' => 'bts', 'gender' => '남' }

// 사이즈 확인 
console.log(map.size); // 3

// 존재하는지 확인
console.log(map.has("name")); // false
console.log(map.has("group")); // true

// Map 활용
// 키에 해당하는 값 읽어오기
console.log(map.get("name")); // undefined, 에러나진 않음
console.log(map.get("group")); // bts

// 추가, 수정
map.set("nation", "korea"); // 키값이 없는 경우 추가
console.log(map);
map.set("group", "bts1"); // 키값이 있는 경우 수정
console.log(map);

// 삭제
map.delete("gender");
console.log(map);