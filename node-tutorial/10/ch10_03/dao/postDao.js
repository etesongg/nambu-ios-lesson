const models = require("../models"); // db

const postDao = {};

postDao.createPost = async (data) => {
  return await models.Post.create(data);
};

postDao.findPostById = async (id) => {
  return await models.Post.findByPk(id, {
    include: { model: models.User },
  });
};

postDao.findAllPost = async () => {
  return await models.Post.findAll({
    include: {
      model: models.User,
    },
  });
};

postDao.updatePost = async (id, data) => {
  return await models.Post.update(data, {
    // update 성공하면 "data": [1] 이라고 알려줌
    where: { id },
  });
};

postDao.deletePost = async (id) => {
  return await models.Post.destroy({
    where: { id },
  });
};

module.exports = postDao;
