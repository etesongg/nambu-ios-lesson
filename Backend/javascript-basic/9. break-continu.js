for (let i = 0; i < 10 ; i++) {
    if (i == 2) {
        break;
    }
    console.log(`${i} was executed`);
}

for (let i = 0; i < 10 ; i++) {
    if (i == 2) {
        continue; // 2면 빠져나와서 다음 실행
    }
    console.log(`${i} was executed`);
}