const http = require("http");
const url = require("url");
const fs = require("fs");

http
  .createServer((req, res) => {
    const path = url.parse(req.url, true).pathname;
    res.setHeader("Content-Type", "application/json");

    // url을 통합해서 관리할 맵 객체를 넣는다. 라우팅
    if (path in urlMap) {
      urlMap[path](req, res);
    }
  })
  .listen(4500);

const home = (req, res) => {
  res.end("home");
};
const list = (req, res) => {
  const data = fs.readFileSync("test.json", "utf-8");
  const result = JSON.parse(data);
  const resStr = JSON.stringify(result);
  res.end(resStr);
};

const view = (req, res) => {
  const param = url.parse(req.url, true).query;
  //   console.log(param);
  const id = param.id;
  const data = fs.readFileSync("test.json", "utf-8");
  const result = JSON.parse(data);
  const posts = result["result"];
  //   console.log(posts);
  const post = posts.filter((item) => {
    console.log(item, item.id, id);
    return item.id == id;
  });
  console.log(post);
  const postStr = JSON.stringify(post);
  res.end(postStr);
};

// http://localhost:4500/write?title=haha&content=하하
const write = (req, res) => {
  // title, content
  const param = url.parse(req.url, true).query;
  const title = param.title;
  const content = param.content;

  const data = fs.readFileSync("test.json", "utf-8");
  const result = JSON.parse(data);
  const posts = result["result"];
  posts.push({
    id: posts.length + 1,
    title: title,
    content: content,
  });
  console.log(posts);
  const newData = {
    result: posts,
  };
  fs.writeFileSync("test.json", JSON.stringify(newData));
  res.end("");
};

// http://localhost:4500/edit?id=2&title=newTitle&content=newContent
const edit = (req, res) => {
  const param = url.parse(req.url, true).query;
  const { id, title, content } = param;

  const data = fs.readFileSync("test.json", "utf-8");
  const result = JSON.parse(data);
  const posts = result["result"];

  const newPosts = [];
  posts.forEach((item) => {
    if (item.id == id) {
      // 수정 로직
      item.title = title;
      item.content = content;
      newPosts.push(item);
    } else {
      newPosts.push(item);
    }
  });
  console.log(newPosts);
  const newData = {
    result: newPosts,
  };
  fs.writeFileSync("test.json", JSON.stringify(newData));
  res.end("");
};

// http://localhost:4500/remove?id=3
const remove = (req, res) => {
  const param = url.parse(req.url, true).query;
  const id = param.id;
  const data = fs.readFileSync("test.json", "utf-8");
  const result = JSON.parse(data);
  const posts = result["result"];
  const newPosts = posts.filter((item) => {
    return item.id != id;
  });
  const newData = {
    result: newPosts,
  };

  fs.writeFileSync("test.json", JSON.stringify(newData));
  res.end("");
};

const urlMap = {
  "/": home,
  "/list": list,
  "/view": view,
  "/write": write,
  "/edit": edit,
  "/remove": remove,
};
