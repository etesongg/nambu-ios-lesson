const fs = require("fs");

const content = "안녕하세요 홍길동 입니다. \n반값습니다. 이길동입니다.";

// fs.writeFile("out.text", content, (err) => {});
fs.writeFileSync("out.sync.txt", content);
