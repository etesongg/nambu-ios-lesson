// 비동기 프로그래밍
function asyncTest(name, callback) {
    console.log("타이머 시작");
    setTimeout(() => {
        callback(name);
    }, 3000); // 3초 후에 데이터를 가져온다고 가정
}

function doOthering() {
    for(let i =0; i<300; i++){
        console.log(`${i}번째 처리`);
    }
}
const sayHello = (name) => {
    console.log(`Hello ${name}`)
}

// asyncTest("뷔", sayHello);
asyncTest("뷔", (name) => console.log(`Hello ${name}`))
doOthering();