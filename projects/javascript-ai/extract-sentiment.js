const axios = require("axios");
require("dotenv").config();

const ENDPOINT = `${process.env.LANGUAGE_ENDPOINT}/text/analytics/v3.1/sentiment`;
const API_KEY = process.env.LANGUAGE_API_KEY;

const textToAnalyze = {
  documents: [
    {
      id: "1",
      language: "ko",
      text: "오늘 하루 너무 즐거웠어요! 거리가 너무 예뻐요.",
    },
    {
      id: "2",
      language: "ko",
      text: "자동차가 지나갑니다.",
    },
    {
      id: "3",
      language: "ko",
      text: "오늘 하루 너무 슬퍼요!",
    },
    {
      id: "4",
      language: "en",
      text: "It's sunny day!",
    },
  ],
};

const headers = {
  "Ocp-Apim-Subscription-Key": API_KEY,
  "Content-Type": "application/json",
};

async function extractSentiment() {
  try {
    const response = await axios.post(ENDPOINT, textToAnalyze, {
      headers,
    });
    const documents = response.data.documents;
    documents.forEach((document) => {
      console.log(`${document.id} : ${document.sentiment}`);
    });
  } catch (e) {
    console.log(e);
  }
}
extractSentiment();
