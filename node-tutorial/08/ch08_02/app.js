const express = require("express");
const path = require("path");
const models = require("./models"); // models = db
const multer = require("multer");

const app = express();
const PORT = 3000;
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
// 위 미들웨어를 사용하면 header에 application/x-www-form-urlencoded 설정 (이때는 텍스트 형식만 보낼 수 있음)
// name=value&name2=value2
// Content-Type : multipart/form-data (이때는 imgae, file, 보내기 가능)
// 업로드 디렉토리 설정, 다운로드 디렉토리 설정
app.use("/downloads", express.static(path.join(__dirname, "public/uploads")));
// http://localhost:3000/download/test.text로 요청하면, 서버는 실제 파일 시스템의 public/uploads/test.text 파일을 제공

const upload_dir = `public/uploads`;
const storage = multer.diskStorage({
  destination: `./${upload_dir}`,
  filename: function (req, file, cb) {
    cb(
      null, // 콜백(에러부분 상관 안 한다?,
      path.parse(file.originalname).name +
        "-" +
        Date.now() +
        path.extname(file.originalname)
    );
  }, // test.png -> test-20241010.png
});

const upload = multer({ storage: storage });

app.post("/posts", upload.single("file"), async (req, res) => {
  // 파일 하나만 받겠다, 전송받을 필드네임 설정
  const { title, content, author } = req.body;
  let filename = req.file ? req.file.filename : null;
  filename = `/downloads/${filename}`; // downloads를 부르면 public/uploads로 감 여기로 가서 filename을 읽음??
  const post = await models.Post.create({
    title: title,
    content: content,
    author: author,
    filename: filename,
  });
  res.status(201).json(post);
});

app.get("/posts", async (req, res) => {
  const posts = await models.Post.findAll({
    include: [
      {
        model: models.Comment,
        require: true,
      },
    ],
  });

  // select * from posts
  res.json({ data: posts });
});

app.get("/posts/:id", async (req, res) => {
  const { id } = req.params;
  const post = await models.Post.findByPk(id); // 하나의 항목만 가져옴, findOne()에 where로 가져올 수도 있음
  if (post) {
    res.status(200).json({ data: post });
  } else {
    res.status(404).json({ result: "post not found" });
  }
});

app.put("/posts/:id", upload.single("file"), async (req, res) => {
  const { id } = req.params;
  const { title, content } = req.body;
  const post = await models.Post.findByPk(id);
  let filename = req.file ? req.file.filename : null;
  filename = `/downloads/${filename}`;
  if (post) {
    post.title = title;
    post.content = content;
    if (req.file) {
      post.filename = filename;
    }
    await post.save();
    res.status(200).json({ data: post });
  } else {
    res.status(404).json({ result: "not found post" });
  }
});

app.delete("/posts/:id", async (req, res) => {
  const { id } = req.params;
  const result = await models.Post.destroy({
    // 테이블 전체 지우기 destroyAll(), truncate()
    where: {
      id: id,
    },
  });
  console.log(`destroy result: ${result}`);
  if (result) {
    res.status(204).send();
  } else {
    res.status(404).json({ result: "not found post" });
  }
});

app.post("/posts/:id/comments", async (req, res) => {
  const postId = req.params.id;
  const { content } = req.body;
  const comment = await models.Comment.create({
    PostId: postId,
    content: content,
  });
  res.status(201).json({ data: comment });
});

app.get("/posts/:id/comments", async (req, res) => {
  const postId = req.params.id;
  const comments = await models.Comment.findAll({
    where: {
      PostId: postId,
    },
    include: [{ model: models.Post }],
  });
  res.status(200).json({ data: comments });
});

app.put("/comments/:id", async (req, res) => {
  const cmtId = req.params.id;
  const { content } = req.body;
  const comment = await models.Comment.findByPk(cmtId);
  if (comment) {
    comment.content = content;
    await comment.save();
    res.json({ data: comment });
  } else {
    res.status(404).json({ result: "comment is not found" });
  }
});

app.delete("/comments/:id", async (req, res) => {
  const cmtId = req.params.id;
  const result = await models.Comment.destroy({
    where: {
      id: cmtId,
    },
  });
  if (result) {
    res.status(204).send();
  } else {
    res.status(404).json({ result: "not found comment" });
  }
});

app.listen(PORT, () => {
  console.log(`server listening on ${PORT}`);
  models.sequelize
    .sync({ force: false })
    .then(() => {
      console.log(`db connected`);
    })
    .catch((err) => {
      console.log(`db error : ${err}`);
      process.exit();
    });
});
