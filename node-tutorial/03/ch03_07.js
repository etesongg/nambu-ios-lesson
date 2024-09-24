const path = require("path");
const fs = require("fs");

// const newFilePath = path.join(__dirname, "folder", "file.txt"); // 파일 경로만 만들어줌
// console.log(newFilePath); // /Users/song/src/nambu-ios-lesson/node-tutorial/03/folder/file.txt

// newFilePath 에 파일을 생성하고, File.txt에 아무 문자열이나 넣기
// const patharr = newFilePath.split("/");
// const filename = patharr.pop();
// const dirname = patharr.join("/");
// console.log(filename, patharr.join('/'))

// fs.mkdirSync(dirname, { recursive: true });
// fs.writeFileSync(newFilePath, "test");

// fs.mkdirSync("folder", { recursive: true });
// const content = "test";
// fs.writeFileSync("folder/file.txt", content);

// path.parse()**는 단순히 구분자를 기준으로 경로를 나누는 것 외에도, 경로에서 파일명, 확장자, 디렉터리 등 유용한 정보를 자동으로 추출해줍니다.
// 예를 들어, path.parse(fpath)는 경로에서 파일 이름과 확장자를 구분해줍니다. (split()로는 확장자와 파일명을 따로 처리해야 함)
// 또한, 경로의 루트 디렉터리나 확장자를 손쉽게 다룰 수 있습니다.
const newFilePath = path.join(__dirname, "a3", "b3", "c3", "file.txt");
console.log(newFilePath, path.parse(newFilePath).dir);

const makeFile2 = (fpath, content) => {
  const filename = path.parse(fpath).base;
  if (filename) {
    const dirname = path.parse(fpath).dir;
    fs.mkdirSync(dirname, { recursive: true });
    fs.writeFileSync(fpath, content);
  }
};

makeFile2(newFilePath, "test2");
