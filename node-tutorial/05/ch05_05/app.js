const express = require("express");
const fs = require("fs");
const moment = require("moment");
const sqllite3 = require("sqlite3");
const path = require("path");
const { create } = require("domain");

const db_name = path.join(__dirname, "post.db");
const db = new sqllite3.Database(db_name);

const app = express();
const PORT = 3000;

app.set("view engine", "ejs");
app.set("views", "./views");

const create_sql = `
  create table if not exists posts (
    id integer primary key autoincrement,
    title varchar(255),
    content text,
    author varchar(100),
    createdAt varchar(100),
    count integer default 0
  )
`;

db.serialize(() => {
  db.run(create_sql);
});

app.get("/list", (req, res) => {
  let page = req.query.page ? parseInt(req.query.page) : 1;
  const limit = 5;
  const offset = (page - 1) * limit;

  let sql = `select id, title, content, author, createdAt, count from posts order by 1 desc limit ? offset ?`;
  db.all(sql, [limit, offset], (err, rows) => {
    if (err) {
      res.status(500).send("Internal Server Error");
    } else {
      // console.log(JSON.stringify(rows)); // 배열 안에 객체 형태
      // res.render("list", { posts: rows });
      db.get(`select count(1) as count from posts`, (err, row) => {
        if (err) {
          res.status(500).send("Internal Server Error");
        } else {
          const total = row.count;
          const totalPage = Math.ceil(total / limit);
          res.render("list", {
            posts: rows,
            currentPage: page,
            totalPage: totalPage,
          });
        }
      });
    }
  });
});

app.get("/view/:id", (req, res) => {
  const { id } = req.params;
  let sql = `select id, title, content, author, createdAt, count from posts where id = ${id}`;
  let countSql = `update posts set count = count + 1 where id = ${id}`;
  db.run(countSql);

  db.all(sql, [], (err, rows) => {
    if (err) {
      res.status(500).send("Internal Server Error");
    } else {
      const post = rows[0];
      res.render("view", { post: post });
    }
  });
});

app.get("/create", (req, res) => {
  res.render("create");
});

app.use(express.urlencoded({ extended: true }));

app.post("/create", (req, res) => {
  const createdAt = moment().format("YYYY-MM-DD");
  const { title, content, author } = req.body;
  let sql = `insert into posts(title, content, author, createdAt) values('${title}','${content}','${author}','${createdAt}')`;
  db.run(sql, [], (err) => {
    if (err) {
      res.status(500).send("Internal Server Error");
    } else {
      res.redirect("/list");
    }
  });
});

app.get("/edit/:id", (req, res) => {
  const { id } = req.params;
  let sql = `select id, title, content, author 
  from posts 
  where id =${id}`;

  db.all(sql, [], (err, rows) => {
    if (err) {
      res.status(500).send("Internal Server Error");
    } else {
      const post = rows[0];
      res.render("edit", { post: post });
    }
  });
});

app.post("/edit/:id", (req, res) => {
  const { id } = req.params;
  let sql = `update posts 
  set title='${req.body.title}', content='${req.body.content}', author='${req.body.author}' 
  where id=${id}`;

  db.run(sql, (err) => {
    if (err) {
      res.status(500).send("Internal Server Error");
    } else {
      res.redirect(`/view/${id}`);
    }
  });
});

app.get("/remove/:id", (req, res) => {
  const { id } = req.params;
  let sql = `delete from posts where id = ${id}`;
  db.run(sql, (err) => {
    if (err) {
      res.status(500).send("Internal Server Error");
    } else {
      res.redirect("/list");
    }
  });
});

app.listen(PORT, () => {
  console.log(`게시판 서버를 시작합니다.`);
});
