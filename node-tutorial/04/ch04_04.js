const http = require("http");
const url = require("url");
const fs = require("fs");

const list = (req, res) => {
  const data = fs.readFileSync("test.json", "utf-8");
  const result = JSON.parse(data);
  console.log(result);
  const resStr = JSON.stringify(result);
  res.end(resStr);
};

const view = (req, res) => {};
const write = (req, res) => {};
const edit = (req, res) => {};
const remove = (req, res) => {};

http
  .createServer((req, res) => {
    const path = url.parse(req.url, true).pathname;
    res.setHeader("Content-Type", "application/json");

    if (path == "/list") {
      list(req, res);
    } else if (path == "/view") {
      view(req, res);
    } else if (path == "/write") {
      write(req, res);
    } else if (path == "/edit") {
      edit(req, res);
    } else if (path == "/remove") {
      remove(req, res);
    } else {
      res.end("");
    }
  })
  .listen(4500);
