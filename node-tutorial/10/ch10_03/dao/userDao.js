const models = require("../models");

const userDao = {};

// 회원가입
userDao.createUser = async (data) => {
  return await models.User.create(data);
};

// 로그인
userDao.findUserByEmail = async (email) => {
  return await models.User.findOne({
    where: { email },
  });
};

userDao.findAllUsers = async () => {
  return await models.User.findAll();
};

userDao.updateUser = async (id, data) => {
  return await models.User.update(data, {
    where: { id },
  });
};

module.exports = userDao;
