// Closure 기본 표현 문법
func sayHello(name: String) {
    print("Hello \(name)")
}

let sayHello1 = {(name:String)->() in print("Hello \(name)")} // 보통 한줄로 씀, 반환형 생략가능, 매개변수 ()로 생략가능

func doSomething(name:String, handler:(String)->()){
    handler(name)
}
//doSomething(name: "song", handler: sayHello)
//doSomething(name: "song", handler: sayHello1)
//doSomething(name: "song", handler: {(name:String)->() in print("Hello \(name)")})
//doSomething(name: "song", handler: {name in print("Hello \(name)")}) // 형타입 추론가능하기 때문에 이렇게까지 생략가능

// 타입 추론에 의한 생략
let names = ["Chris","Alex","Ewa","Barry","Daniella"]
let sortedNames = names.sorted()
//print(sortedNames)
func backward(s1:String, s2:String) ->Bool {
    return s1 > s2
}
let reversed = names.sorted(by: backward(s1:s2:))
//print(reversed)

let reversed1 = names.sorted(by: {(s1:String, s2:String)->Bool in return s1 > s2})
//print(reversed1)

let reversed2 = names.sorted(by: {(s1, s2) in return s1 > s2}) // sorted(by:)의 형타입은 이미 정해져 있기때문에 생략가능
//print(reversed2)

let reversed3 = names.sorted(by: {s1, s2 in s1 > s2}) // 반환값이 하나면 return 생략, 이렇게 제일 많이 씀
//print(reversed3)

let reversed4 = names.sorted(by: {$0 > $1}) // ???
//print(reversed4)

let reversed5 = names.sorted(by: > ) //
let reversed6 = names.sorted(by: < ) // 내림차순으로 반환받으려면
//print(reversed5)
//print(reversed6)

// 후행 Closure
func printHello(name:String, handler:(String)->()){
    handler(name)
}
//printHello(name: "song", handler: { name1 in
//    print("Hello \(name1)")
//})
//printHello(name: "song"){ name in // 자동완성에서 엔터치면 후행 클로저 모양으로 변함
//    print("Hello \(name)")
//}
//printHello(name: "song") { n1 in
//    print("Hello \(n1)")
//}

func exec(handler:()->()) {
    handler()
}
//exec {
//    print("exec")
//}
//exec() {
//    print("exec")
//}

// Escaping Closure
func exec(handler:@escaping ()->())->(()->()){ //void void 타입을 받아서 void void 타입을 반환함
    return handler // 반환만 함
}
let func1 = exec{ // 이후는 handler 부분임, exec에서 반환값 handler를 가지고 있음, 그래서 밑에서 func1()로 실행시켜줘야함
    print("Hello")
}
func1()

// Capturing Values
func captureValue()->(()->()){
    var count = 3
    print("1.\(count)")
    let closure = { ()->() in // closure 이기때문에 captureValue()를 실행했을때 실행되지 않음
        count += 1
        print("2.\(count)")
    }
    return closure
}
let func11 = captureValue() // 3
func11() // 4, swift는 지역변수 count를 컴파일러가 별도로 보관해줌 그래서 값을 반환받을 수 있음

