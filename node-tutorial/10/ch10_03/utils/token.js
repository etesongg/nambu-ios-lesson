const jwt = require("jsonwebtoken");

// 사용자 인증을 위한 용도
const generateAccessToken = (user) => {
  return jwt.sign(
    {
      id: user.id,
      email: user.email,
    },
    "access_secret", // secret 문자열 넣기,
    { expiresIn: "15m" } // {유효시간}
  );
};

// accesstoken을 발급 받기 위한 용도
const generateRefreshToken = (user) => {
  return jwt.sign(
    {
      id: user.id,
      email: user.email,
    },
    "refresh_secret",
    { expiresIn: "14d" }
  );
};

module.exports = { generateAccessToken, generateRefreshToken };
