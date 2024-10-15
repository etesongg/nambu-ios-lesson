const express = require("express");
const Database = require("better-sqlite3");
const path = require("path");
const { graphqlHTTP } = require("express-graphql");
const { buildSchema } = require("graphql");

const db_name = path.join(__dirname, "post.db");
const db = new Database(db_name);
const app = express();
const PORT = 4000;
const create_sql = `
CREATE TABLE IF NOT EXISTS posts(
id INTEGER PRIMARY KEY AUTOINCREMENT,
title VARCHAR(255),
content TEXT,
author VARCHAR(100),
createdAt datetime DEFAULT current_timestamp,
count INTEGER DEFAULT 0);

CREATE TABLE IF NOT EXISTS comments (
id INTEGER PRIMARY KEY AUTOINCREMENT,
content TEXT NOT NULL,
postId INTEGER,
FOREIGN KEY(postId) REFERENCES posts(id)
);
`;
db.exec(create_sql);

// 스키마 지정
const schema = buildSchema(`
    type Post {
        id: ID!
        title: String!
        content: String
        author: String
        createdAt: String
    }

    input PostInput {
        title: String!
        content: String!
        author: String!
    }
    
    type Query {
        getPosts: [Post]
        getPost(id: ID!): Post
    }

    type Mutation {
        createPost(input: PostInput): Post
        updatePost(id: ID!, input: PostInput): Post
        deletePost(id: ID!): String
    }
`);

// 리졸버 지정
const root = {
  getPosts: () => {
    const stmt = db.prepare(`SELECT * FROM posts`);
    return stmt.all();
  },
  getPost: ({ id }) => {
    const stmt = db.prepare(`SELECT * FROM posts WHERE id = ?`);
    return stmt.get(id);
  },
  createPost: ({ input }) => {
    const stmt = db.prepare(
      `INSERT INTO posts (title, content, author) VALUES(?,?,?)`
    );
    const info = stmt.run(input.title, input.content, input.author);
    return { id: info.lastInsertRowid, ...input };
  },
  updatePost: ({ id, input }) => {
    const stmt = db.prepare(`UPDATE posts SET title=?, content=? WHERE id = ?`);
    const info = stmt.run(input.title, input.content, id);
    return { id: id, ...input };
  },
  deletePost: ({ id }) => {
    const stmt = db.prepare(`DELETE FROM posts WHERE id = ?`);
    const info = stmt.run(id);
    return `Posts[${id}] is deleted`;
  },
};

// {
// 	getPosts {
//     id:
//     title
//     content
//     author
//     createdAt
// 	}
// }

// {
// 	getPost(id: "4") {
//     id:
//     title
//     content
// 	}
// }

// mutation {
// 	createPost(input: {title: "haha", content: "haha", author: "haha"}) {
//       id
//       title
//       content
//     	author
//   }
// }

// mutation {
// 	updatePost(id: "1", input: {title: "haha", content: "haha", author: "haha"}) {
//       id
//       title
//       content
//   }
// }

// mutation {
// 	deletePost(id: "3")
// }
// mutation{} 안에 한번에 여러개 실행시킬 수 있음

// 스키마 리졸버 등록
// GraphQL 미들웨어 설정
app.use(
  "/graphql",
  graphqlHTTP({
    schema: schema,
    rootValue: root,
    graphiql: true, // // GraphiQL 인터페이스 활성화
  })
);
app.listen(PORT);
