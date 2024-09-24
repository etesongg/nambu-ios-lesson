const { exec } = require("child_process");

// const cmd = 'ls'
const cmd = 'find . -name "*.js"'; // find . -name "*.txt" -exec rm -rf {} \; 텍스트 파일 지우기
exec(cmd, (err, stdout, stderr) => {
  if (err) {
    console.error(`error 발생: ${err}`);
    return;
  }
  console.log(`stdout: ${stdout}`);
});
