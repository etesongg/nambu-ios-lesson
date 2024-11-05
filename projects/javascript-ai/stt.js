const axios = require("axios");
const fs = require("fs");
require("dotenv").config();

const ENDPOINT = `${process.env.SST_ENDPOINT}speech/recognition/conversation/cognitiveservices/v1?language=en-US`;
const API_KEY = process.env.SPEECH_API_KEY;

const filePath = "./output.wav";

function convertSpeechToText() {
  const audioData = fs.readFileSync(filePath);
  axios
    .post(ENDPOINT, audioData, {
      headers: {
        "Ocp-Apim-Subscription-Key": API_KEY,
        "Content-Type": "audio/wav",
        "Transfer-Encoding": "chunked", // 내용이 길어도
      },
    })
    .then((res) => {
      console.log("sst res", res.data);
    })
    .catch((e) => console.log(e));
}
convertSpeechToText();
