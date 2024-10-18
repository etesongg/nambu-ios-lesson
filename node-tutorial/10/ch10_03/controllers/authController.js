const bcrypt = require("bcryptjs");
const userService = require("../services/userService");
const { generateAccessToken, generateRefreshToken } = require("../utils/token");

const authContoller = {};
const jwt = require("jsonwebtoken");
authContoller.refresh = (req, res) => {
  const { token } = req.body;
  if (!token) return res.sendStatus(401);
  jwt.verify(token, "refresh_secret", (err, user) => {
    // 가져온 token을 "refresh_secret"으로 통해 리프레시 토큰 생성
    if (err) return res.sendStatus(403); // Forbidden 인증에는 실패했지만, 요청 자체는 서버에 도달했음
    const accessToken = generateAccessToken(user);
    res.json({
      accessToken,
    });
  });
};

authContoller.login = async (req, res) => {
  const { email, password } = req.body;
  try {
    const user = await userService.findUserByEmail(email);
    if (!user) {
      return res.status(400).json({ message: "Invalid email or password" });
    }
    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ message: "Invalid email or password" });
    }
    const accessToken = generateAccessToken(user);
    const refreshToken = generateRefreshToken(user);
    res.json({
      accessToken,
      refreshToken,
    });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
};

authContoller.register = async (req, res) => {
  const { email, name, password } = req.body;
  const hashedPassword = await bcrypt.hash(password, 10);

  try {
    const user = await userService.createUser({
      email,
      name,
      password: hashedPassword,
    });
    res.status(201).json({ data: user });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
};

module.exports = authContoller;
