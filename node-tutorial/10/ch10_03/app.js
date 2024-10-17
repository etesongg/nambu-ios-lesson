const express = require("express");
const postRoute = require("./routers/postRoute");
const models = require("./models");
const app = express();
const PORT = 3000;

app.use(express.json());
app.use("/posts", postRoute); // /posts 불리면 postRoute로 감
// app.use("/uses", usesRoute);
// app.use("/comments", commentsRoute);
// app.use("/products", productsRoute);

app.listen(PORT, () => {
  models.sequelize
    .sync({ force: false })
    .then(() => {
      console.log("db 연결 성공");
    })
    .catch((err) => {
      console.log(`db 연결 실패 : ${err}`);
      process.exit();
    });
});
