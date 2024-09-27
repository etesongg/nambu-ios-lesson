const express = require("express");
const fs = require("fs");
const moment = require("moment");

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
  let result = JSON.parse(data);
  let post = {};
  result["result"].forEach((item) => {
    if (item["id"] == id) {
      post = item;
      item.count = item.count + 1;
    }
  });
  fs.writeFileSync("test.json", JSON.stringify(result), "utf-8");
  res.render("view", { post: post });
});

app.get("/create", (req, res) => {
  res.render("create");
});

app.use(express.urlencoded({ extended: true }));

let maxId = 0;
const initId = () => {
  const result = fs.readFileSync("test.json", "utf-8");
  const data = JSON.parse(result);
  const idList = data["result"].map((item) => parseInt(item.id)); // id 목록만 담기
  maxId = Math.max(...idList); // 만약 데이터가 잘못돼서 갯수는 12개인데 마지막 id에 8이 저장되어 있다면 8 + 1 하면 중복이 생김 그래서 id를 다 받아서 max로 계산
};

const getId = () => {
  return ++maxId;
};

initId();

app.post("/create", (req, res) => {
  // console.log(`/create post body: ${JSON.stringify(req.body)}, ${maxId}`); // create post body: [object Object] 객체로 나오면 JSON.stringigy해줌
  const result = fs.readFileSync("test.json", "utf-8");
  let data = JSON.parse(result);

  const createdAt = moment().format("YYYY-MM-DD");

  const newPost = {
    id: getId(),
    title: req.body.title,
    content: req.body.content,
    writer: req.body.writer,
    createdAt: createdAt,
    count: 0,
  };
  data["result"].push(newPost);
  fs.writeFileSync("test.json", JSON.stringify(data), "utf-8");
  res.redirect("/list");
});

app.get("/edit/:id", (req, res) => {
  const { id } = req.params;

  const result = fs.readFileSync("test.json", "utf-8");
  const data = JSON.parse(result);
  let post = {};
  data["result"].forEach((item) => {
    if (item["id"] == id) {
      post = item;
    }
  });
  res.render("edit", { post: post });
});

app.post("/edit/:id", (req, res) => {
  const { id } = req.params;
  const result = fs.readFileSync("test.json", "utf-8");
  let data = JSON.parse(result);

  for (item of data["result"]) {
    if (item["id"] == id) {
      item["title"] = req.body.title;
      item["content"] = req.body.content;
      item["writer"] = req.body.writer;
    }
  }
  fs.writeFileSync("test.json", JSON.stringify(data), "utf-8");
  res.redirect(`/view/${id}`);
});

app.get("/remove/:id", (req, res) => {
  const { id } = req.params;
  const result = fs.readFileSync("test.json", "utf-8");
  let data = JSON.parse(result);

  let removed_idx = 0;
  data["result"].forEach((e, i) => {
    if (e["id"] == id) {
      removed_idx = i;
    }
  });
  data["result"].splice(removed_idx, 1);
  fs.writeFileSync("test.json", JSON.stringify(data), "utf-8");
  res.redirect("/list");
});

app.listen(PORT, () => {
  console.log(`게시판 서버를 시작합니다.`);
});
