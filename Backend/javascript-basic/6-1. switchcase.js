let browser1 = 'Chrome';
let browserName1;

switch (browser1) {
    case 'IE':
        browserName1 = '인터넷 익스플로러'
        break;
    case 'FF':
        browserName1 = '파이어폭스'
        break;
    case 'Chrome':
        browserName1 = '크롬'
        break;    
    case 'Opera':
        browserName1 = '오페라'
        break;
    case 'Safari':
        browserName1 = '사파리'
        break;
    default: 
        browserName1 = '알려지지 않은 브라우저입니다.'
        break;
}
console.log(`현재 브라우저는 ${browserName1}입니다.`);