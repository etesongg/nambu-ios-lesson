const http = require("http");

http
  .createServer((req, res) => {
    res.statusCode = 200;
    res.setHeader("Content-Type", "text/plain");
    const arr = [...Array(10).keys()];
    const arr2 = arr.map((x) => {
      return "hello world" + (x + 1);
    });
    const content = arr2.join("\n");
    console.log(content);
    res.write(content);
    res.end();
  })
  .listen(4500);
