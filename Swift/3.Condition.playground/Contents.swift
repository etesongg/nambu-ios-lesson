let adult = 19
let age = 15

if age < adult {
    print("당신은 미성년자입니다.")
}else {
    print("당신은 성인입니다.")
}

//guard
//guard age > adult else {
//    print("당신은 미성년자네요.")
//}

let browser  = "Safari"
//let browserName: String
//
//if browser == "IE" {
//    browserName = "인터넷 익스플로러"
//}else if browser == "Safari" {
//    browserName = "사파리"
//}else if browser == "Chrome" {
//    browserName = "크롬"
//}else {
//    browserName = "알려지지 않은 브라우저"
//}
//print("브라우저 명은 \(browserName)입니다.")

let browserName = if browser == "IE" {
    "인터넷 익스플로러" // browserName = 에 직접 할당하기 때문에 중복되는 browserName = 생략
}else if browser == "Safari" {
    "사파리"
}else if browser == "Chrome" {
    "크롬"
}else {
    "알려지지 않은 브라우저"
}

print("브라우저 명은 \(browserName)입니다.")

// switch
let browser1 = "Chrome"
//let browserName1: String

//switch browser1 {
//  case "IF": browserName1 = "인터넷 익스플로러"
//  case "FF": browserName1 = "파이어 폭스"
//  case "Chrome": browserName1 = "크롬"
//  case "Opera": browserName1 = "오페라"
//  case "Safari": browserName1 = "사팔;"
//  default: browserName1 = "알려지지 않은 브라우저"
//}

let browserName1 = switch browser1 {
    case "IF": "인터넷 익스플로러"
    case "FF": "파이어 폭스"
    case "Chrome": "크롬"
    case "Opera": "오페라"
    case "Safari": "사팔;"
    default: "알려지지 않은 브라우저"
}

print("브라우저 명은 \(browserName1)입니다.")

// case 여러개 한번에 설정 가능
var value = 3
switch value {
    case 0: print("0 입니다.")
    case 1: print("1 입니다.")
    case 2, 3: print("2 또는 3입니다.")
    default: print("default 입니다.")
}

var age3 = 17
switch age3 {
    case 1...3: print("body")
    case 4..<20:print("Child")
    default: print("Adult")
}

// 변수가 boolean 값이라면 default 필요없음
var bool = true
switch bool {
    case true: print("true 입니다.")
    case false: print("false 입니다.")
}
