const express = require("express");
const app = express();
const PORT = 3000;

const sqlite3 = require("sqlite3");
const path = require("path");
const db_name = path.join(__dirname, "habbit.db");
const db = new sqlite3.Database(db_name);

app.use("view engine", "ejs");

app.listen(PORT, () => {
  console.log(`${PORT}에서 습관관리 사이트 웹서버 실행 중`);
});
