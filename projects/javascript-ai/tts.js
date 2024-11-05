const axios = require("axios");
const fs = require("fs");
require("dotenv").config();

const ENDPOINT = `${process.env.SPEECH_ENDPOINT}/cognitiveservices/v1`;
const API_KEY = process.env.SPEECH_API_KEY;

const text = `
First of all, let me get something straight: This
is a JournAl, not a diary. I know what it
says on the cover, but when Mom went out to
buy this thing I sPecificAlly told her to
get one that didn’t say “diary” on it.`;

const ssml = `
<speak version="1.0" xmlns="http://www.w3.org/2001/10/synthesis" xml:lang="en-US">
    <voice name="en-US-AriaNeural">
        ${text}
    </voice>
</speak>`;

const headers = {
  "Ocp-Apim-Subscription-Key": API_KEY,
  "Content-Type": "application/ssml+xml",
  "X-Microsoft-OutputFormat": "riff-16khz-16bit-mono-pcm",
};

function tts() {
  axios
    .post(ENDPOINT, ssml, {
      headers,
      responseType: "arraybuffer",
    })
    .then((response) => {
      fs.writeFileSync("./output.wav", response.data);
      console.log("Audio file saved as output.wav");
    })
    .catch((e) => {
      console.error("Error:", e);
    });
}

tts();
