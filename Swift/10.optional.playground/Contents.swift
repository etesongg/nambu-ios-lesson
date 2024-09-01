var index:Int
//print(index) // nil 이기 때문에 에러남
index = 3
//print(index) // 3

var index1:Int = Int() // 0으로 초기화
var index2:Int = Int(3)
var index3 = 3
//var index4:Int = nil // swift는 변수나 객체를 nil로 정의할 수 없음, 에러남
var index5 = Int("3")
var index6 = Int("Swift")
//print(index5) // Optional(3)
//print(index6) // nil


//기존의 데이터형 뒤에 ?를 붙이면 옵셔널로 선언, 값 또는 nil을 저장할 수 있음
// optional로 싸져있는면 연산 못함 사용하고 싶으면 꺼내야 함
var optInt : Int?
//optInt = nil;print(optInt) // nil

var optInt1 : Int? = 1
//print(optInt1) // Optional(1)

var optStr : String? = "swift"
//print(optStr) // Optional("swift")

var optArr : [String]?
optArr = ["C", "JAVA", "오브젝티브-c", "SmallTalk"]
//print(optArr) // Optional(["C", "JAVA", "오브젝티브-c", "SmallTalk"])

var optDic : [String:Int]?
optDic = ["국어":94, "수학":88, "영어":96]
//print(optDic) // Optional(["수학": 88, "국어": 94, "영어": 96])
//바인딩해서 사용해야 함, 이때 닐체크가 이루어짐

// 옵셔널 사용, 기존 데이터형 뒤에 ?를 붙이면 옵셔널로 선언
// 옵셔널 형은 연산이 불가, 사용하려면 언래핑(옵셔널 바인딩) 후 사용가능
var temp1: Int? = 3
var temp2: Int? = 5
//temp1 + temp2 // 에러나서 실행 x
//temp1 + 30

// 강제 언래핑 방법
var optInt2 : Int? = 3
//print("옵셔널 자체의 값: \(optInt2)") // 옵셔널 자체의 값: Optional(3)
//print("!로 강제 언래핑한 값: \(optInt2!)") // !로 강제 언래핑한 값: 3
temp1! + temp2! // 에러 안남
var index7 = Int("123")!
//print(index7) // 123

// Optional형 forced Unwrapping
//딕셔너리에서 키로 가져오는 값들은 항상 옵셔널임, 그렇기 때문에 언래핑을 해서 사용해야함.
//키를 틀리면 값이 없어지기 때문에 언래핑을 통해 항상 검사 후 가져오도록 하기 위해 항상 옵셔널임.
var optStr1 :String? = "swift"
//print(optStr1) // Optional("swift")
//print(optStr1!) // swift
var capital5 = ["KR":"Seoul","EN":"London","FR":"Paris"]
//print(capital5["KR"]) // Optional("Seoul")
//print(capital5["KR"]!) // Seoul
//print(capital5["kr"]) // nil
var krCapital = capital5["KR"]!
//var krCapital1 = capital5["kr"]! // nil을 강제 언래핑 해서 에러발생

// 위처럼 nil을 강제 언래핑 해서 앱이 터지는 것을 방지하기 위해 binding을 사용
var temp3: Int? = 123
if temp3 != nil {
    print("변환된 값은 \(temp3!) 입니다.")
}else {
    print("값 변환에 실패했습니다.")
}
 
// swift에서는 언래핑을 위한 문법을 제공
// temp3가 nil 이 아니라면 언래핑을 해서 let val = true로 반환, 즉 if true 인것임, var는 밖에서는 사용 못하는 상수임 왜냐면 이 {}안에서만 nil이 아니라는 보장이 되기 때문에
// 이 경우 temp3에 nil이더라도 아무일도 일어나지 않음
if let val = temp3 {
    print("변환된 값은 \(val) 입니다.")
}

//guard를 사용하는 이유: 전체 값이 nil인지 아닌지 확인할때는 gurad let이 if 보다 더 유리하다
var idol : String? = "BTS"
if let val = idol {
    print("변환된 값은 \(val) 입니다.")
}

func optTest(idol:String?) {
    guard let val = idol else {
        print("idol은 nil 입니다.")
        return // nil인 경우 상위 코드 블록을 종료하는 함수가 반드시 필요 continue, break return, throw 등)
    }
    print(val)
}
optTest(idol: "aa")

// 옵셔널 자동 해제
let optInt3:Int? = 123
if(optInt3 != nil) {
    if(optInt3 == 123) {
        print("optInt3 === 123")
    }else {
        print("optInt3 != 123")
    }
}

let tempInt:Int? = 123
tempInt! == 123 // true 이처럼 비교연산자에서는 옵셔널 구분 안 함
tempInt == 123 // true
tempInt! == Optional(123) // true
tempInt == Optional(123) // true

// nil 결합 연산자 ??
var optAge:Int? = 30
print(optAge ?? 20) // 30 optAge에 값이 있으면 언래핑해서(Optional(30)->30) 값을 넣어주고 값이 없으면 ?? 뒤에 있는 값을 넣어줌

var optName:String? = "손흥민"
let name = optName ?? "황희찬"
print(name)
