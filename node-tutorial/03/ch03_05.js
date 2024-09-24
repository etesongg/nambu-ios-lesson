// 디렉토리 만들기
const fs = require("fs");

const dirname = "naver/daum/google";
fs.mkdirSync(dirname, { recursive: true });

// fs.writeFileSync를 이용해서 naver/daum/google/out.txt 만들어보자
const content = "test";
fs.writeFileSync(dirname + "/out.txt", content);
