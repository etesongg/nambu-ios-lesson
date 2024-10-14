const express = require("express");
let moment = require("moment");
const path = require("path");
const Database = require("better-sqlite3");
const { channel } = require("diagnostics_channel");
const { error } = require("console");

// database setting
const db_name = path.join(__dirname, "post.db");
const db = new Database(db_name); // 데이터베이스 생성

const app = express();
const PORT = 3000;
app.use(express.json()); // json 미들웨어 설정
const create_sql = `
CREATE TABLE IF NOT EXISTS posts(
id INTEGER PRIMARY KEY AUTOINCREMENT,
title VARCHAR(255),
content TEXT,
author VARCHAR(100),
createdAt datetime DEFAULT current_timestamp,
count INTEGER DEFAULT 0);

CREATE TABLE IF NOT EXISTS comments (
id INTEGER PRIMARY KEY AUTOINCREMENT,
content TEXT NOT NULL,
postId INTEGER,
FOREIGN KEY(postId) REFERENCES posts(id)
);
`;
db.exec(create_sql);

// 목록
app.get("/posts", (req, res) => {
  const page = req.query.page ? parseInt(req.query.page) : 1;
  const limit = 5;
  const offset = (page - 1) * limit; // page = 2 => offset = 5
  let sql = `
      SELECT id, title, author, createdAt, count
      FROM posts
      ORDER BY createdAt DESC limit ? offset ?`;
  const stmt = db.prepare(sql); // statement
  const rows = stmt.all(limit, offset); // err는 try-catch로 처리
  res.json({ item: rows });
});

// 게시글 상세
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
  // const stmt = db.prepaer(count_sql)
  // stmt.run(id)
  db.prepare(count_sql).run(id); // 위 코드를 메소드 체이닝(.으로 연결하는거)
  const post = db.prepare(sql).get(id);
  res.status(200).json({ item: post });
});

// 쓰기
app.post("/posts", (req, res) => {
  const { title, content, author } = req.body;
  let sql = `
      INSERT INTO posts(title, content, author) 
      VALUES (?,?,?)`;
  const stmt = db.prepare(sql);
  const result = stmt.run(title, content, author);
  console.log(`result: ${JSON.stringify(result)}`); // result: {"changes":1,"lastInsertRowid":22}
  res
    .status(201)
    .json({ id: result.lastInsertRowid, title: title, content: content });
});

// 수정
app.put("/posts/:id", (req, res) => {
  const { id } = req.params;
  const { title, content } = req.body;
  let sql = `
      UPDATE posts
      SET title = ?, content = ?
      WHERE id = ?`;
  try {
    const result = db.prepare(sql).run(title, content, id);
    console.log(`result: ${JSON.stringify(result)}`); // result: {"changes":1,"lastInsertRowid":0} changes는 업데이트된 행의 갯수
    if (result.changes) {
      res.status(200).json({ result: "success" });
    } else {
      // changes가 0일 경우, 바뀐 행이 없을 경우
      res.status(404).json({ error: "post is not found" });
    }
  } catch (e) {
    res.status(500).json({ error: e });
  }
});

// 삭제
app.delete("/posts/:id", (req, res) => {
  const { id } = req.params;
  let sql = `
      DELETE FROM posts 
      WHERE id = ?`;
  try {
    const result = db.prepare(sql).run(id);
    if (result.changes) {
      res.status(204).end();
      // res.status(202).json({result: "success"})
    } else {
      res.status(404).json({ error: "post not found" });
    }
  } catch {
    res.status(500).json({ error: e });
  }
});

// 댓글 추가
app.post("/posts/:id/comments", (req, res) => {
  const { content } = req.body;
  const postId = req.params.id;
  const stmt = db.prepare(`
        INSERT INTO comments(postId, content) 
        VALUES (?,?)`);
  const result = stmt.run(postId, content);
  res
    .status(201)
    .json({ id: result.lastInsertRowid, postId: postId, content: content });
});

// 특정 포스트의 댓글을 가져오고
app.get("/posts/:id/comments", (req, res) => {
  const postId = req.params.id;
  const comments = db
    .prepare(
      `
        SELECT * 
        FROM comments
        WHERE postId = ?`
    )
    .all(postId);
  res.json({ comments: comments });
});

// 댓글 수정
app.put("/comments/:id", (req, res) => {
  const commentId = req.params.id;
  const { content } = req.body;
  const stmt = db.prepare(`
      UPDATE comments
      SET content = ?
      WHERE id = ?`);
  const result = stmt.run(content, commentId);
  if (result.changes) {
    res.status(200).json({ result: "success" });
  } else {
    res.status(404).json({ error: "comment is not found" });
  }
});

// 댓글 삭제
app.delete("/comments/:id", (req, res) => {
  const commentId = req.params.id;
  const result = db
    .prepare(
      `
          DELETE FROM comments 
          WHERE id = ?`
    )
    .run(commentId);
  if (result.changes) {
    res.status(200).json({ result: "success" });
  } else {
    res.status(404).json({ error: "comment is not found" });
  }
});

app.listen(PORT);
