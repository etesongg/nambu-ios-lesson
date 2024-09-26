const express = require("express");
const { engine } = require("express-handlebars");

const app = express();
const PORT = 3000;

app.engine("handlebars", engine()); // 템플릿 엔진을 등록, 'engine()'은 handlebars 엔진을 생성하는 함수
app.set("view engine", "handlebars"); // 기본 템플릿 엔진을 'handlebars'로 설정
app.set("views", "./views"); // 이 경로에 있는 템플릿 파일을 사용하여 렌더링

app.get("/", (req, res) => {
  const data = {
    title: "첫번째 핸들바",
    message: "수염이 멋집니다.",
  };
  res.render("index", data);
});

app.listen(PORT, () => {
  console.log(`${PORT} 웹서버가 뜨고 있습니다.`);
});
