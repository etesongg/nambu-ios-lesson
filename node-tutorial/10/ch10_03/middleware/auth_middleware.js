const jwt = require("jsonwebtoken");

const authenticatieToken = (req, res, next) => {
  let token;
  if (req.headers.authorization) {
    token = req.headers.authorization.split(" ")[1];
    // Authorization: Bearer eyadkflkjg => eyadkflkjg
  }
  if (!token) {
    return res.sendStatus(401);
  }
  jwt.verify(token, "access_secret", (err, user) => {
    // token 에서 jwt.sign()에 secret 문자열부분에 넣은 값하고 같아야 함
    if (err) return res.sendStatus(401);
    req.user = user;
    next(); // 다음번 미들웨어가 없으면 이 미들웨어를 장착한 라우터 실행 됩니다.
  });
};

module.exports = { authenticatieToken };
