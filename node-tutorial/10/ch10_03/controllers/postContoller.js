const postService = require("../services/postService");
// const postDao = require('../dao/postDao') // 금지
// const models = require('../models') // 금지

const postContoller = {};
postContoller.createPost = async (req, res) => {
  // db 가져올때 에러 날 수 있기 때문에 try catch 사용
  try {
    // {"title": "a", "content": "b", "userId": 1} = req.body
    const post = await postService.createPost(req.body);
    res.status(201).json({ data: post });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
};

postContoller.findPostById = async (req, res) => {
  try {
    const post = await postService.findPostById(req.params.id);
    if (post) {
      res.status(200).json({ data: post });
    } else {
      res.status(404).json({ errpr: "Post not found" });
    }
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
};

postContoller.findAllPost = async (req, res) => {
  try {
    const posts = await postService.findAllPost();
    res.status(200).json({ data: posts });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
};

postContoller.updatePost = async (req, res) => {
  try {
    const post = await postService.updatePost(req.params.id, req.body);
    if (post) {
      // post 1 or 0 , postgrasql에서 update의 결과값은 성공하면 1이라고 뜸
      res.status(200).json({ message: "success" });
    } else {
      res.status(404).json({ message: "post not found" });
    }
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
};

postContoller.deletePost = async (req, res) => {
  try {
    const result = await postService.deletePost(req.params.id);
    if (result) {
      res.status(200).json({ message: "success" });
    } else {
      res.status(404).json({ message: "not found post" });
    }
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
};

module.exports = postContoller;
