// 클래스 정의
// 클래스를 사용하는 이유: 기본 데이터형을 통해 우리가 원하는 타입을 만들기 위해서
class Person {
    let name = "손흥민" // property(속성)은 데이터를 저장
    var age = 31 // 저장 프로퍼티(stored property)
}
//let person = Person() // 인스턴스 생성
//print(person.name, person.age)
//let age = person.age
//print(age)
//person.age = 30
//print(person.age)

//let person1 = Person() // 또 다른 Persong형의 인스턴스 생성
//print(person1.name, person1.age)

// 메서드는 특정 타입과 연관된 함수
// 메서드는 행위를 저장
class Vehicle {
    var speed = 0
    
    func speedUp() { // speedUp 이라는 메서드는 Vehicle인 탈것과 연관있는 함수?
        speed += 10
    }
    func speedDn() {
        speed -= 10
    }
    func speed2Mile() -> Double {
        return Double(speed)*0.6213
    }
}
//var someVehicle = Vehicle()
//someVehicle.speedUp()
//print(someVehicle.speed)
//var mile = someVehicle.speed2Mile()
//print(mile) // 6.212999999999999

// 클래서 정의-연산프로퍼티
class Vehicle2 {
    var speed = 0

    var mile: Double { // 연산 프로퍼티
        get { return Double(speed)*0.6213} // 속성값을 읽을때는 get이 동작
        set(newSpeed) { speed = Int(newSpeed*1.6)} // 속성값을 쓸때는 set이 동작, newValue라고 변수명 이미 있기 때문에 생략하면 newValue 사용가능 set { speed = newValue * 1.6 }
    }
    func speedUp() { speed += 10 }
    func speedDn() { speed -= 10 }
    func speed2Mile() -> Double { // 반환값이 있는 메서드
        return Double(speed)*0.6213
    }
}
//var someVehicle2 = Vehicle2()
//someVehicle2.speedUp()
//print(someVehicle2.speed2Mile())
//print(someVehicle2.mile)

// 읽기전용일때는 get만 구현(set 생략가능), 읽기전용일때는 get 생략가능, 단일 표현식일때 return 생략가능
class Vehicle3 {
    var speed = 0.0
    var mile: Double {
//        get { return speed * 0.6213 }
        speed * 0.6213
    }
    func speedUp() {speed += 10}
    func speedDn() {speed -= 10}
    func speed2Mile() -> Double {
        return Double(speed) * 0.6213
    }
}
//var someVehicle3 = Vehicle3()
//someVehicle3.speedUp()
//print(someVehicle3.speed2Mile())
//print(someVehicle3.mile)

// 프로퍼티 관찰자(Observer)
class Vehicle4 {
    var speed = 0.0 {
        willSet(newValue) {
            print("현재속도=\(speed), 새로운 속도=\(newValue)") // 값이 설정되기 전에
        }
        didSet(oldValue) {
            print("현재속도=\(speed), 이전 속도=\(oldValue)") // 값이 설정되고 나서
        }
    }
}
//var vehicle = Vehicle4()
//vehicle.speed = 100 // 현재속도=0.0, 새로운 속도=100.0 현재속도=100.0, 이전 속도=0.0
//vehicle.speed = 50 // 현재속도=100.0, 새로운 속도=50.0 현재속도=50.0, 이전 속도=100.0

// 클래스 정의 실습
// 정사각형을 관리하는 클래스를 정의하라.
// 가로,세로를 관리하는 저장 프로퍼티를 정의하라.
// 가로,세로를 이용해서 면적을 구하고 면적값을 설정하면 가로,세로를 변경하는 연산프로퍼티 정의하라.(sqrt()함수사용)
// 가로세로를 두배로 만들고 변경된 가로세로를 튜플로 반환하는 메쏘드를 정의하라
import Foundation
class Square {
    var width = 2.0
    var heigth = 3.0
    
    var area: Double {
        get { return width * heigth }
        set { width = sqrt(newValue); heigth = width }
    }
    func double() -> (Double, Double){
        width *= 2
        heigth *= 2
        return(width, heigth)
    }
}
//var square = Square()
//print(square.width, square.heigth) // 2.0 3.0 여기서는 get이 실행되는 것
//square.area = 25
//print(square.width, square.heigth) // 5.0 5.0 여기서 set이 실행되는 것
//print(square.double()) // (10.0, 10.0)
//print(square.width, square.heigth) // 10.0 10.0
//print(square.area) // 100.0

// 클래스 정의-생성자
// 처음에 인스턴스를 만들때 초기값을 넣어주기 위해 생성자를 사용함.
// 클래스에 생성자가 없으면 기본 생성자를 만들어줌
// init() { } 이게 기본 생성자 모양임
class Square1 {
    var width:Double; var height:Double
    var area:Double {
        get { return width * height }
        set { width = sqrt(newValue); height = width }
    }
    func duplicate()->(Double, Double) {
        width = width * 2
        height = height * 2
        return (width, height)
    }
    init (w: Double, h: Double) {
        width = w; height = h
    }
    init() { // var sq = Square1()를 사용하고 싶으면 이런 생성자를 만들어 주면 사용할 수 있음
        width = 10
        height = 10
    }
}
var square1 = Square1(w: 2, h: 2)
//print(square1.area) // 4.0
//square1.area = 100
//print(square1.width, square1.height) // 10.0 10.0
//print(square1.duplicate()) // (20.0, 20.0)
//print(square1.area) // 400.0

// self는 현재 클래스? 로 만들어진 인스턴스??
// 클래스에서 사용하는 프로퍼티와 init사용하는 변수명이 같아 init의 {}안에서 구분이 안되는 경우 self.를 붙여 현재 클래스에서 선언한 프로퍼티를 말한다. 즉, 이 클래스로 만들어질 인스턴스를 의미한다.

class Square2 {
    var width = 0.0; var height = 0.0;
    var area: Double {
        get { return width * height }
        set { width = sqrt(newValue); height = width }
    }
    func doplicate() -> (Double, Double) {
        width *= 2; height *= 2
        return (width, height)
    }
    init(width:Double, height:Double) {
        self.width = width;
        self.height = height;
        self.doplicate()
    }
}
var squ2 = Square2(width: 2, height: 2)
//print(squ2.area)
//squ2.area = 100
//print(squ2.width, squ2.height)








