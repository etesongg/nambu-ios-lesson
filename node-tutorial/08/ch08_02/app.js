const express = require("express");
const path = require("path");
const models = require("./models"); // models = db

const app = express();
const PORT = 3000;
app.use(express.json());

app.post("/posts", async (req, res) => {
  const { title, content, author } = req.body;
  const post = await models.Post.create({
    title: title,
    content: content,
    author: author,
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

app.put("/posts/:id", async (req, res) => {
  const { id } = req.params;
  const { title, content } = req.body;
  const post = await models.Post.findByPk(id);
  if (post) {
    post.title = title;
    post.content = content;
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
