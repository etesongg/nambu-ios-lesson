const express = require("express");
const { graphqlHTTP } = require("express-graphql");
const { buildSchema } = require("graphql");

// GraphQL 스키마 정의
const schema = buildSchema(`
    type Query {
        hello: String
        welcome(name: String!): String
    }`);

// 리졸버
const root = {
  hello: () => {
    return "Hello GraphQL!";
  },
  welcome: ({ name }) => {
    return `Welcome ${name}`;
  },
};
// 입력
// {
//   hello
// 	welcome(name: "song")
// }
// 결과
// {
//   "data": {
//     "hello": "Hello GraphQL!",
//     "welcome": "Welcome song"
//   }
// }

const app = express();
app.use(
  "/graphql",
  graphqlHTTP({
    schema: schema,
    rootValue: root,
    graphiql: true,
  })
);

app.listen(4000);
