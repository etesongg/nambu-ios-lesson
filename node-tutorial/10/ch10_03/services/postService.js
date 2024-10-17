const postDao = require("../dao/postDao");
// const commentDao = require('../dao/commentDao')
// const productDao = require('../dao/productDao')

const postService = {};

postService.createPost = async (data) => {
  return await postDao.createPost(data);
};

postService.findPostById = async (id) => {
  return await postDao.findPostById(id);
};

postService.findAllPost = async () => {
  return await postDao.findAllPost();
};

postService.updatePost = async (id, data) => {
  return await postDao.updatePost(id, data);
};
postService.deletePost = async (id) => {
  return await postDao.deletePost(id);
};

module.exports = postService;
