const express = require("express");
const fs = require("fs");

const app = express();
const port = 3000;

app.get("/list", (req, res) => {
  // 라우터 만들기
  list(req, res);
});

// http://localhost:3000/view/2
app.get("/view/:id", (req, res) => {
  const { id } = req.params;

  const data = fs.readFileSync("test.json", "utf-8");
  const result = JSON.parse(data);
  const posts = result["result"];
  let post = {};

  posts.forEach((item) => {
    if (item.id == id) {
      post = item;
    }
  });
  res.json(post);
});

const list = (req, res) => {
  const data = fs.readFileSync("test.json", "utf-8");
  const result = JSON.parse(data);
  res.json(result); // res.json()은 js 객체를 json 형식으로 바꿔줌 그래서 stringify 안해줘도 됨
};

app.listen(port, () => {
  console.log(`listening on port ${port}`);
});
