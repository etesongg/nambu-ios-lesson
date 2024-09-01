// 구구단의 단을 입력받아 출력하는 함수 정의
function gogodan(num) {
    console.log(`${num} 단`);
    for (let i = 1; i < 10; i++) {
        console.log(`${num} * ${i} = ${i * num}`);
    }
    console.log("----------");
}

// gogodan(3);
// gogodan(9);

function grade(score) {
    let res = "";
    if (score >= 95) {
        res = "A";
    } else if (score >= 90) {
        res = "B";
    } else if (score >= 85) {
        res = "C";
    } else if (score >= 80) {
        res = "D";
    } else if (score >= 75) {
        res = "E";
    } else {
        res = "F";
    }
    console.log(`${score}점은 ${res}학점입니다.`)
}
// grade(98);
// grade(94);
// grade(76);

function sum1(num1, num2, ...nums) { // (nums) 으로 하면 안됨 0 나옴
    let res = num1 + num2;
    for (let i = 0; i < nums.length; i++) {
        res += nums[i];
    }
    return res;
}
// console.log(sum1(1,2,3,4));

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
// console.log(calc(3, 4, "-"));
// console.log(calc(3, 4, "+"));
// console.log(calc(3, 4, "*"));
// console.log(calc(3, 4, "/"));
// console.log(calc(3, 4, "//"));

// 함수 정의 실습
function plus(num1, num2) {
    return num1 + num2
}
function minus(num1, num2) {
    return num1 - num2
}
function multi(num1, num2) {
    return num1 * num2
}
function divide(num1, num2) {
    return num1 / num2
}

function calc2(num1, num2, callback) {
    return callback(num1, num2) // 여기에 return 이 없으면 undefined 나옴
}
// console.log(calc2(2,3, multi)) // 함수 이름을 넣어줘야 함
// console.log(calc2(2, 3, plus))
// console.log(calc2(2, 3, (n1, n2) => {return n1 + n2}))
// console.log(calc2(2, 3, (n1, n2) => n1 + n2))

const getLotto = () => {
    let lottoList = new Set();

    while (lottoList.size < 6) {
        const num = Math.floor(Math.random() * 46) + 1;
        lottoList.add(num);
        if (lottoList.size == 6) {
            break;
        }
    }
    const array = Array.from(lottoList) // [...lottoList] 가능
    return array.sort((a, b) => a - b) // 계산해서 음수면 앞 뒤 자리바꿈 , 내림차순 b - a
}
console.log(getLotto());

