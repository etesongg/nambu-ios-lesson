const express = require("express");
let moment = require("moment");
const sqlite3 = require("sqlite3");
const path = require("path");

// database setting
const db_name = path.join(__dirname, "post.db");
const db = new sqlite3.Database(db_name);

const app = express();
const PORT = 3000;
app.use(express.json());
const create_sql = `
CREATE TABLE if not exists posts(
id INTEGER PRIMARY KEY AUTOINCREMENT,
title VARCHAR(255),
content TEXT,
author VARCHAR(100),
createdAt datetime DEFAULT current_timestamp,
count INTEGER DEFAULT 0);`;
db.serialize(() => {
  db.run(create_sql); // post.db 생성
});

// 1. GET / posts 게시글 목록
// curl http://localhost:3000/posts\?page\=3
app.get("/posts", (req, res) => {
  const page = req.query.page ? parseInt(req.query.page) : 1;
  const limit = 5;
  const offset = (page - 1) * limit; // page = 2 => offset = 5
  let sql = `
    SELECT id, title, author, createdAt, count
    FROM posts
    ORDER BY createdAt DESC limit ? offset ?`;

  db.all(sql, [limit, offset], (err, rows) => {
    if (err) {
      console.error(err.message);
      res.status(500).send(err.message);
    } else {
      let cnt_sql = `
            SELECT count(1) as count
            FROM posts`;
      db.get(cnt_sql, (err1, row) => {
        if (err1) {
          console.error(err1.message);
          res.status(500).send(err.message);
        } else {
          const total = row.count;
          const totalPages = Math.ceil(total / limit);
          res.json({ items: rows, currentPage: page, totalPages: totalPages });
        }
      });
    }
  });
});

// 2. GET / posts/1 게시글 상세
// curl http://localhost:3000/posts/2
app.get("/posts/:id", (req, res) => {
  const { id } = req.params;

  let sql = `
    SELECT id, title, content, author, createdAt, count 
    FROM posts 
    WHERE id = ?`;
  let count_sql = `
    UPDATE posts
    SET count = count+1 
    WHERE id = ?`;
  db.run(count_sql, [id], (err) => {
    if (err) {
      res.status(500).send(err.message);
    }
    db.get(sql, [id], (err1, row) => {
      if (err1) {
        res.status(500).send(err1.message);
      } else {
        res.json({ item: row });
      }
    });
  });
});

// 3. POST / posts 게시글 쓰기
// curl로 데이터 삽입하기
// curl -X POST -H "Content-Type: application/json" -d '{"title": "Test 1", "content": "Test Content1","author":"song"}' http://localhost:3000/posts
app.post("/posts", (req, res) => {
  const { title, content, author } = req.body;
  let sql = `
    INSERT INTO posts(title, content, author) 
    VALUES (?,?,?)`;
  db.run(sql, [title, content, author], function (err) {
    if (err) {
      res.status(500).send(err.message);
    }
    console.log(`row id : ${this.lastID}`);
    res.json({ result: "success", id: this.lastID }); // run()는 성공하게 되면 콜백할때 자동으로 lastID, changes 프로퍼티를 가져 this로 접근 가능
  });
});

// 4. PUT / posts/1 게시글 수정
// curl -X PUT -H "Content-Type: application/json" -d '{"title":"Vita500", "content":"Vita 500"}' http://localhost:3000/posts/2
app.put("/posts/:id", (req, res) => {
  const { id } = req.params;
  const { title, content } = req.body;
  let sql = `
    UPDATE posts
    SET title = ?, content = ?
    WHERE id = ?`;
  db.run(sql, [title, content, id], (err) => {
    if (err) {
      res.status(500).send(err.message);
    }
    res.json({ result: "success" });
  });
});

// 5. DELETE / posts/1 게시글 삭제
// curl -X DELETE http://localhost:3000/posts/2
app.delete("/posts/:id", (req, res) => {
  const { id } = req.params;
  let sql = `
    DELETE FROM posts 
    WHERE id = ?`;
  db.run(sql, [id], (err) => {
    if (err) {
      res.status(500).send(err.message);
    }
    res.json({ result: "success" });
  });
});

app.listen(PORT, () => {
  console.log(`server list listening on post ${PORT}`);
});
