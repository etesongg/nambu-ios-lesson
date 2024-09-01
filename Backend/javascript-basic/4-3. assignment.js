let num = 0;
console.log(num);
num++;
console.log(num);
num--;
console.log(num);

// num++ 필요한 작업 후 값을 증가(후치)
// ++num 값을 증가후 필요한 작업수행(전치)
num = 1;
console.log(num++); // 1
num = 1;
console.log(++num); // 2

let num1 = num++;
console.log(num1); // 2
console.log(num); // 3
