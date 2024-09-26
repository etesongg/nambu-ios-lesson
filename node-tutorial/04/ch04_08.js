const express = require("express");

const app = express();
const port = 3000;

app.get("/home", (req, res) => {
  res.send(`
        <h1>안녕하세요. h1</h1>
        <h2>안녕하세요. h2</h2>
        `);
});

app.listen(port, () => {
  console.log(`listening on port ${port}`);
});
