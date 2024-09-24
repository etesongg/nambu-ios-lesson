let arr = [1, 2, 3];

arr.push(4, 5);
console.log(arr);

const arr2 = arr.map((x) => {
  return `hello ${x}`;
});
console.log(arr2);

const arr3 = arr.filter((x) => {
  // 값 거르기 리턴 조건에 맞는 값만
  return x % 2 == 0; // boolean
});
console.log(arr3);

arr.forEach((v, i) => {
  console.log(`arr5 => ${v} ${i}`);
});
