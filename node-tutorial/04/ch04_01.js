const http = require("http");
const url = require("url");

http
  .createServer((req, res) => {
    const path = url.parse(req.url, true).pathname; // url 파라미터 처리
    console.log(path, req.url);
    if (path == "/hello") {
      res.end("<h1>hello</h1>");
    } else if (path == "/world") {
      res.end("<h1>world</h1>");
    } else if (path == "/") {
      res.end("first page");
    }
  })
  .listen(4500);
