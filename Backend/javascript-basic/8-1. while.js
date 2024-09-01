// let age = 0;

// while (age < 5 ) {
//     console.log(`${age}살 입니다.`);
//     age += 1; // 없으면 무한루프
// }


let age = 0;
let num = 0;

while (age < 5 ) {
    while (num < 10) {
        console.log(`${age}살 입니다.`);
        num += 1;
    }
    num = 0; // 초기화해주지 않으면 0살입니다가 10번씩 출력 -> 1번만 돈다. 다음으로 안 넘어감
    age += 1;
}