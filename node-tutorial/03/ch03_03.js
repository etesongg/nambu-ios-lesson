const fs = require("fs");
console.log(fs);

// fs.readFile("/etc/passwd", "utf-8", (err, data) => {
//   if (err) {
//     console.log("error", err);
//   }
//   console.log(data);
// });

const data = fs.readFileSync("hello.txt", "utf-8"); // 현재 작업 중인 디렉토리 폴더 안에 있어야 함
console.log(data);
