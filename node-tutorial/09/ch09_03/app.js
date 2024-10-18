const express = require("express");
const mongoose = require("mongoose");
mongoose.connect("mongodb://localhost/mymongo"); // 연결, 뒤는 디비명

const db = mongoose.connection; // 가져오기
db.on("error", (err) => {
  console.error(`mongo connect error: ${err}`);
});
db.once("open", () => {
  console.log(`mongo connected successfully`);
});

const PostSchema = new mongoose.Schema({
  title: String,
  content: String,
  author: String,
  createdAt: { type: Date, default: Date.now },
  comments: [
    {
      comment: String,
      author: String,
      createdAt: { type: Date, default: Date.now },
    },
  ],
});

const Post = mongoose.model("Post", PostSchema);
const app = express();
app.use(express.json());

app.post("/posts", async (req, res) => {
  const { title, content, author } = req.body;
  try {
    const post = new Post({
      title,
      content,
      author,
    });
    await post.save();
    res.status(201).json({ data: post });
  } catch (e) {
    res.status(500).json({ error: e });
  }
});

app.get("/posts", async (req, res) => {
  try {
    const posts = await Post.find({});
    res.json({ data: posts });
  } catch (e) {
    res.status(500).json({ error: e });
  }
});

app.get("/posts/:id", async (req, res) => {
  const { id } = req.params;
  try {
    const post = await Post.findById(id);
    res.json({ data: post });
  } catch (e) {
    res.status(500).json({ error: e });
  }
});

app.put("/posts/:id", async (req, res) => {
  const { id } = req.params;
  const { title, content } = req.body;
  try {
    const post = await Post.findByIdAndUpdate(id, {
      title,
      content,
    });
    res.status(200).json({ data: post });
  } catch (e) {
    res.status(500).json({ error: e });
  }
});

app.delete("/posts/:id", async (req, res) => {
  const { id } = req.params;
  try {
    const post = await Post.findByIdAndDelete(id);
    res.status(200).json({ data: post });
  } catch (e) {
    res.status(500).json({ error: e });
  }
});

app.post("/posts/:id/comments", async (req, res) => {
  const { id } = req.params;
  const { comment, author } = req.body;
  try {
    const post = await Post.updateOne(
      {
        _id: id,
      },
      {
        $push: { comments: { comment, author } },
      }
    );
    res.status(200).json({ data: post });
  } catch (e) {
    res.status(500).json({ error: e });
  }
});

app.delete("/posts/:postId/comments/:cmtId", async (req, res) => {
  const { postId, cmtId } = req.params;
  try {
    const post = await Post.updateOne(
      { _id: postId },
      { $pull: { comments: { _id: cmtId } } }
    );
    res.status(200).json({ data: post });
  } catch (e) {
    res.status(500).json({ error: e });
  }
});

app.listen(3000);
