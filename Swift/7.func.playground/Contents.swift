func sayHello() {
    print("Hello Func!")
}
//sayHello()

func multipl() {
    for i in 2...9 {
        print("-- \(i) 단 --")
        for j in 1...9 {
            print("\(i) X \(j) = \(i*j)")
        }
    }
}
//multipl()

func sayHello1(name: String) {
    print("Hello \(name)")
}
//sayHello1(name: "우영우")

func multipl1(num: Int) {
    print("--\(num)단--")
    for i in 1...9 {
        print("\(num) X \(i) = \(i*num)")
    }
}
//multipl1(num:3)

// 반환값이 있는 함수(print로 안하는 이유는 이 함수의 리턴값을 다른 함수에 사용하려고 하기 때문, 그리고 -> 사용하면 ()못 사용하는 듯??)
func sayHello2() -> String {
    return "Hello func"
}
var returnValue = sayHello2()
//print(returnValue) // Hello func
//print(sayHello2()) // Hello func

func threeTiems() -> Int {
    return 3
}
var result = threeTiems()
//print(result)

// 매개변수와 반환값이 있는 함수
func sayHello3(name: String) -> String {
    return "Hello \(name)"
}
var returnValue1 = sayHello3(name: "RM")
//print(returnValue1)
//print(sayHello3(name: "정국"))

func threeTimes(val: Int) -> Int { // 오버로딩: 함수명 같아도 매개변수에 따라서 다른 함수라고 인식
    return val * 3
}
var result1 = threeTimes(val: 2)
//print(result1)

func sayHelloWithName(name:String, age:Int) -> String {
    return "\(name) is \(age) years old"
}
//print(sayHelloWithName(name: "Choi", age:13))

// 내부 매개변수, 외부 매개변수(인수라벨)
// 호출시에는 외부매개변수명을 사용하고 함수 정의시에는 내부매개변수 사용
func sayHello(exName name:String, exAge age:Int) -> String { // 외부 매개변수는 시맨틱하게 쓰고, 내부 매개변수는 간단하게 씀, 함수 호출 시 매개변수의 의미를 명확하게 전달하는 역할을 함, ex) func add(firstNumber a: Int, secondNumber b: Int)
    return "\(name) is \(age) years old"
}
//print(sayHello(exName: "Choi", exAge: 13))

// 인수라벨 생략, 함수호출시 매개변수를 생략하고 싶을때는 _ 를 사용한다.
func sayHelloWithName(_ name:String, age:Int) -> String {
    return "\(name) is \(age) years old"
}
//print(sayHelloWithName("Choi", age: 13))

func sayHello1(_ name:String, _ age:Int) -> String {
    return "\(name) is \(age) years old"
}
//print(sayHello1("Choi", 13))

// 매개변수 기본값을 설정해놓으면 매개변수가 없을때 기본값을 사용
func sayHello4(name: String = "슈가") {
    print("Hello \(name)")
}
//sayHello4(name: "지민")
//sayHello4()

func hello(name:String = "김석진", age:Int, nickName:String = "슈가") {
    print(name, age, nickName)
}
//hello(age: 13)
//hello(age:13, nickName: "song")
//hello(name: "song", age:13)

func calc(_ n1:Int,_ n2:Int,_ op:String) -> Int {
    switch op {
        case "+": return n1 + n2
        case "-": return n1 - n2
        case "*": return n1 * n2
        case "/": return n1 / n2
        default: return 0
    }
}
//print(calc(2, 3, "%"))

// 가변 인자값
func avg(scores:Int...) -> Double {
    var total = 0
    for score in scores {
        total += score
    }
    return Double(total/scores.count)
}
//print(avg(scores: 10,20,30,40,50))

// 튜플반환 함수
func swap(firstNumber n1:Int, secondNumber n2:Int) -> (Int, Int) {
    return (n2, n1)
}
let result2 = swap(firstNumber: 1, secondNumber: 2)
//print(result2)

let (first, second) = swap(firstNumber: 1, secondNumber: 2)
//print(first)
//print(second)

// 스코프 {} 코드블록 안에 있는 것만 사용할 수 있음
do {
    do {
        var ccnt = 3
        print(ccnt)
    }
//    print(ccnt)
}

do {
    var ccnt: Int = 0
    do {
        var ccnt = 3 // 이게 없다고 해도 밑에 ccnt는 결과 나옴 위와 다르게 내부에서는 외부 블록 참조 가능
        print(ccnt)
    }
    print(ccnt)
}

var count = 30
func foo() -> Int {
    return count
}

func foo(count1:Int)->Int { //매개변수는 코드블록 안에서 선언한거랑 같음 : 지역변수
    return count1
}
//print(count1) // 밖에서는 내부 변수 참조 불가능

var count2 = 3
func foo1(count2:Int)->Int{
    return count2 // 매개변수 count2:Int의 count2임
}
//print(foo1(count2:2))

func grade(_ score:Int) -> String {
//    switch score {
//    case 90...100: return "A"
//    case 80...89: return "B"
//    case 70...79: return "C"
//    default: return "F"
//    }
    if score >= 90 {
        return "A"
    }else if score >= 80 {
        return "B"
    }else {
        return "F"
    }
}
//print(grade(85))

// 피젯수와 젯수를 입력받아 몫과 나머지를 튜플로 반환
func divide(_ dividend:Int, _ divisor:Int) -> (Int, Int) {
    let quot = dividend/divisor
    let rema = dividend%divisor
    return (quot, rema)
}
//print(divide(15, 4))

// 로또 발생기
import Foundation
func getLotto() -> Array<Int> {
    var lottoList: Set<Int> = []
    while (lottoList.count < 6) {
        lottoList.insert(Int(arc4random()%45+1))
    }
    var res = lottoList.sorted() // 여기에서 자료형 set에서 array로 변함
    return res
}
print(getLotto())




