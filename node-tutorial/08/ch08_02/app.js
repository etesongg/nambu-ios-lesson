const express = require("express");
const path = require("path");
const models = require("./models");

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
