// 함수의 형(Type)
// 매개변수와 반환값의 타입에 따라서 형이 나뉟다.
// 형추론은 컴파일러가 함
func hello1() { // 매개변수와 반환값이 없으므로 ()->()형이다. ()->void라고 쓸 수 도 있다.
    print("Hello World")
}

let func1: ()->() = hello1 // hello1과 타입이 같으므로 hello1을 대입할 수 있다.
func1()

let func11 = hello1 // 타입은 정해주지 않았지만 형추정에 의해서 ()->() 형이다.
func11()

func hello2(name:String) { // 매개변수와 반환값이 없으므로 (String)->() 형이다. (String)->Void 라고 쓸수도 있다
    print("Hello \(name)")
}

let func2:(String)->() = hello2 // 타입은 (String)->() 이므로 같은 타입인 hello2을 대입할 수있다
func2("덕선")

let func22 = hello2 // func22의 타입은 정해주지 않았지만 형추정에 의해서 (String)-() 형이다
func22("덕선")

// 함수형 매개변수
func hello(human:String) {
    print("Hello \(human)")
}

func hello3(name:String, hfunc:(String)->()) {
    hfunc(name)
}

func bye(name:String) {
    print("Bye \(name)")
}

hello3(name:"홍길동", hfunc: hello)
hello3(name:"홍길동", hfunc: bye)

func hello4(name: String) {
    print("Hello \(name)")
}

func hello5() -> (String)->() {
    return hello
}

let hello6 = hello5()
hello6("홍길동")


