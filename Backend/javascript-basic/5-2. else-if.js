const browser = "chrome";
let browserName;

if (browser == "ie") {
    browserName = "인터넷 익스플로러";
}else if(browser == "Safari") {
    browserName = "사파리";
}else if(browser == "chrome") {
    browserName = "크롬";
}else{
    browserName = "알려지지 않은 브라우저입니다.";
}

console.log(`현재 브라우저는 ${browserName}입니다.`);