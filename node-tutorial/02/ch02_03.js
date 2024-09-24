const http = require("http"); // 부르기

http
  .createServer((req, res) => {
    // 서버 만들기, 요청, 응답 객체를 줌
    res.statusCode = 200;
    res.setHeader("Content-Type", "text/plain");
    res.write("hi song");
    res.end();
  })
  .listen(4500);
