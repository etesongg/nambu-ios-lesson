console.log("=========13");

let arr = [5, 23, "안녕", true, "홍길동", -9];
console.log(arr);
console.log(arr[2]);
console.log(arr[5]);

console.log("=========14");

let i = 2;
while (i < arr.length) {
  console.log(`${i} is ${arr[i]}`);
  i++;
}

console.log("=========15");

for (let i = 0; i < 4; i++) {
  console.log(`${i} is ${arr[i]}`);
}

console.log("=========16");

for (i in arr) {
  if (i > 0 && i < 5) {
    console.log(`${i} is ${arr[i]}`);
  }
}

console.log("=========17");

for (e of arr) {
  console.log(e);
}

console.log("=========18");

let output = "";

for (let i = 0; i < 10; i++) {
  for (let j = 0; j < 10 - i; j++) {
    output += " ";
  }
  for (let j = 0; j < i + 1; j++) {
    output += "*";
  }
  output += "\n";
}
console.log(output);

console.log("=========19");

for (i in arr) {
  // [5, 23, "안녕", true, "홍길동", -9]
  if (typeof arr[i] == "string") {
    break;
  }
  console.log(arr[i]);
}

console.log("=========20");

for (i in arr) {
  if (typeof arr[i] == "string") {
    continue;
  }
  console.log(`${i} => ${arr[i]}`);
}

console.log("=========21");

function add2(x, y) {
  return x + y;
}
console.log(add2(1, 2));

const add1 = function (x, y) {
  return x + y;
};
console.log(add1(1, 2));

const add3 = (x, y) => x + y;
console.log(add3(1, 2));

console.log("=========22");

function tentimes(callback) {
  for (let i = 0; i < 10; i++) {
    callback(i);
  }
}
tentimes(function (i) {
  console.log(`call function(${i})`);
});

console.log("=========23");

console.log(`parseInt("52"): ${parseInt("52")}`); // 52
console.log(`parseInt("3.14"): ${parseInt("3.14")}`); // 3
console.log(`parseInt("3.14"): ${parseFloat("3.14")}`); // 3.14

console.log("=========24");

// setTimeout(() => {
//   console.log(`1초 뒤에 호출`);
// }, 1000);

// setInterval(() => {
//   console.log(`1초 마다 실행`);
// }, 1000);

console.log("=========25");

let personInfo = {
  name: "홍길동",
  age: 25,
  address: "서울시 금천구 독산동",
  hobby: ["등산", "독서", "코딩"],
};
// console.log(personInfo["name"]);
// console.log(personInfo.age);
// console.log(personInfo.hobby);

for (let key in personInfo) {
  console.log(`${key}: ${personInfo[key]}`);
}

console.log(Object.keys(personInfo)); // [ 'name', 'age', 'address', 'hobby' ]

console.log("=========27");

let personInfo1 = {
  name: "홍길동",
  age: 25,
  address: "서울시 금천구 독산동",
  hobby: ["등산", "독서", "코딩"],
  addAge: function () {
    this.age = this.age + 1;
  },
  changeAddress: function (add) {
    this.address = add;
  },
  getAddress: function () {
    return this.address;
  },
  getAge: function () {
    return this.age;
  },
};
console.log(`before age : ${personInfo1.age}`);
personInfo1.addAge();
console.log(`after age : ${personInfo1.getAge()}`);

personInfo1.changeAddress("서울시 종로구 익선동");
console.log(`${personInfo1.address}`);

console.log(personInfo1.getAddress());
