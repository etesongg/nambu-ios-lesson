const express = require("express");
const fs = require("fs");

const app = express();
const PORT = 3000;

app.set("view engine", "ejs");
app.set("views", "./views");

app.get("/list", (req, res) => {
  const data = fs.readFileSync("test.json", "utf-8");
  const result = JSON.parse(data);

  res.render("list", { posts: result["result"] });
});

app.get("/view/:id", (req, res) => {
  const { id } = req.params;

  const data = fs.readFileSync("test.json", "utf-8");
  const result = JSON.parse(data);
  let post = {};
  const posts = result["result"];
  posts.forEach((item) => {
    if (item["id"] == id) {
      post = item;
    }
  });
  res.render("view", { post: post });
});

app.get("/create", (req, res) => {
  res.render("create");
});

app.get("/edit", (req, res) => {
  res.render("edit");
});

app.listen(PORT, () => {
  console.log(`게시판 서버를 시작합니다.`);
});
