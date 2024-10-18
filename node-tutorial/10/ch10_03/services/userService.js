const userDao = require("../dao/userDao");

const userService = {};

userService.createUser = async (data) => {
  return await userDao.createUser(data);
};

userService.findUserByEmail = async (email) => {
  return await userDao.findUserByEmail(email);
};

module.exports = userService;
