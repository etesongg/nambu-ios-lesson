const express = require("express");
const cookieParser = require("cookie-parser");
const expressSession = require("express-session");

const app = express();
const PORT = 3000;

app.use(cookieParser());
app.use(express.urlencoded({ extended: true }));
app.set("view engine", "ejs");
// app.use(express.static("public"));

app.use(
  expressSession({
    secret: "sample",
    resave: true,
    saveUninitialized: true,
  })
);

const users = [
  { name: "jeong", username: "admin", password: "admin1234" },
  { name: "song", username: "test", password: "test1234" },
];

app.get("/home", (req, res) => {
  if (req.session.user) {
    res.render("home");
  } else {
    res.redirect("/login");
  }
});

app.get("/login", (req, res) => {
  console.log(users);
  res.render("login");
});

app.post("/login", (req, res) => {
  const { username, password } = req.body;
  const isUser = users.filter((item) => {
    return item.username == username && item.password == password;
  });
  if (isUser.length > 0) {
    // 브라우저가 꺼지지 않는 이상 세션에 가지고 있음
    req.session.user = {
      username: username,
      authorized: true,
    };
    res.redirect("/home");
  } else {
    res.redirect("/login");
  }
});

app.get("/register", (req, res) => {
  res.render("register");
});

app.post("/register", (req, res) => {
  const { name, username, password } = req.body;
  const isUser = users.filter((x) => {
    return x.username == username && x.password == password;
  });
  if (isUser.length > 0) {
    // 이미 회원 존재
    res.status(401).send("이미 존재하는 아이디 입니다.");
  } else {
    users.push({ name, username, password });
    res.redirect("/login");
  }
});

app.get("/logout", (req, res) => {
  if (req.session.user) {
    req.session.user = null;
  }
  res.redirect("/login");
});

app.listen(PORT, () => {
  console.log(`${PORT}에서 웹서버 실행 중...`);
});
