let 학점 = 80

if(학점 >= 95){
    console.log("A");
}else if(학점 >= 90){
    console.log("B");
}else if(학점 >= 85){
    console.log("C");
}else if(학점 >= 80){
    console.log("D");
}else if(학점 >= 75){
    console.log("E");
}else{
    console.log("F");
}

const score = 87;

switch (true) {
    case score>=90:
        console.log("A");
        break;
    case score>=80:
        console.log("B");
        break;
    case score>=70:
        console.log("C");
        break;
    case score>=60:
        console.log("D");
        break;
    case score>=50:
        console.log("E");
        break;
    default:
        console.log("F");
        break;
}

// 이중 for문 구구단
for (let i = 2 ; i <= 9; i++) {
    console.log(`==${i}단==`)
    for (let j = 1; j <= 9; j++){
        console.log(`${i} x ${j} = ${i*j}`);
    }
    
}

// for, if, continue를 사용헤서 홀수만 뽑기
for (let i = 0; i <= 10; i++) {
    if (i % 2 == 0) {
        continue;
    }
    console.log(`홀수 ${i}`);
}

// list array의 item 중에 bts 멤버만 골라 배열을 만들고 하나의 문자열로 만들어서 출력하시오.
const list = ["슈가", "차은우", "박서준", "이도현", "제이홉", "주우재", "지민"];
const bts = ["진", "슈가", "제이홉", "RM", "지민", "뷔", "정국"];

let arr = []
// for (let i = 0; i < list.length; i++) {
//     for (let j = 0; j < bts.length; j++) {
//         if (list[i].includes(bts[j]) == true) {
//             arr.push(list[i]);
//         }
//     }
// }
// includes는 배열에서 값을 포함하는지 알려주는 메서드임
// 참인 경우만 ~~ 한다면 true는 참이기 때문에 == true를 사용하지 않아도 됨
// 답
for(let i=0; i<list.length;i++){
    const member = list[i];
    if(bts.includes(member)){
        arr.push(member)
    }
}

let result = arr.join(", ")
console.log(result)


// 로또 발생기 1~46 6개
let lotto = new Set();
while (lotto.size<6){ // 숫자를 뽑는 횟수를 알 수 없음(중복가능하기 때문에 그래서 길이로 판단) , lotto.length 사용 불가 size 사용, true 사용 가능
    let num  = Math.floor(Math.random() * 46) + 1; // Math.random() 범위 공식 작은수~큰수를 구하시오 : Math.random(큰수 - 작은수 + 1) + 작은수
    lotto.add(num);
    if(lotto.size >= 6){
        break;
    }
}
console.log(lotto);


