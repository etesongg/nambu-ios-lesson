const axios = require("axios");
const { copyFileSync } = require("fs");
require("dotenv").config();
const readline = require("readline"); // added

const ENDPOINT = `${process.env.QNA_ENDPOINT}`;
const API_KEY = process.env.LANGUAGE_API_KEY;

const question = "I want to book a flight";
const body = {
  top: 3,
  question,
  confidenceScoreThreshold: 0.3, // 0.3 이상인 값만 출력
};

const headers = {
  "Ocp-Apim-Subscription-Key": API_KEY,
  "Content-Type": "application/json",
};

const option = {
  method: "POST",
  url: ENDPOINT,
  headers,
  data: body,
};

axios(option)
  .then((res) => {
    const answers = res.data.answers;
    answers.forEach((answer) => console.log(`Answer: ${answer.answer}\n`));
  })
  .catch((res) => {
    console.log(res);
  });

// const rl = readline.createInterface({
//   // added
//   input: process.stdin,
//   output: process.stdout,
// });

// async function askQuestion() {
//   rl.question("Ask a question: ", async (userInput) => {
//     // added
//     const Question = {
//       top: 3,
//       question: userInput,
//       confidenceScoreThreshold:0.3 // 0.3 이상인것만 나옴
//     };

//     try {
//       const response = await axios.post(ENDPOINT, Question, {
//         headers,
//       });
//       const answers = response.data.answers;
//       answers.forEach((answer) => {
//         console.log(`Answer: ${answer.answer} \n`);
//       });
//     } catch (e) {
//       console.log(e);
//     } finally {
//       // added
//       rl.close();
//     }
//   });
// }
// askQuestion();
