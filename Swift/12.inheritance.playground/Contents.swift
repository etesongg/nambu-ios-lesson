class Vehicle2 {
    var speed = 0

    var mile: Double {
        get { return Double(speed)*0.6213}
        set(newSpeed) { speed = Int(newSpeed*1.6)}
    }
    func speedUp() { speed += 10 }
    func speedDn() { speed -= 10 }
    func speed2Mile() -> Double {
        return Double(speed)*0.6213
    }
}

// 상속, 실무에서는 관리하기 쉽게? 상속을 이용함
class Car: Vehicle2 { // 클래스 이름 뒤에 : 상속받을 클래스 명시
    var wheelCount:Int
    var seatCount:Int
    init(wheelCount:Int, seatCount:Int){
        self.wheelCount = wheelCount
        self.seatCount = seatCount
    }
}
var car = Car(wheelCount: 4, seatCount: 2)
car.speedUp() // 상속받았기 때문에 Car에 정의된 것이 아닌 Vehicle2에 정의된 speedUp()메서드를 부를 수 있다.
//print(car.speed)
//print(car.wheelCount, car.seatCount)
//print(car.mile)
car.mile = 60
//print(car.mile)

// 클래스 상속 실습
class Truck: Car {
    var loadage: Int = 0
    func load() { print("load") }
    func unLoad() { print("unLoad") }
}
var truck = Truck(wheelCount: 3, seatCount: 3)
//print(truck.seatCount, truck.wheelCount)
//print(truck.speed)
//truck.speedUp()
//print(truck.speed) 10
//truck.mile = 100
//print(truck.mile)

class Truck1: Car {
    var loadage: Int = 0
    func load() { print("load") }
    func unLoad() { print("unLoad") }
    override func speedUp() { // override 메서드 재정의
        speed += 5
    }
}
//var truck1 = Truck1(wheelCount: 2, seatCount: 2)
//print(truck1.seatCount, truck1.wheelCount)
//truck1.speedUp()
//print(truck1.speed) // 5

class SportsCar: Car {
    override func speedUp() {
        speed += 20
    }
}
//var sportscar = SportsCar(wheelCount: 2, seatCount: 2)
//sportscar.speedUp()
//print(sportscar.speed) // 20

// 생성자 재정의(부모 클래스의 초기화 메서드가 올바르게 호출되어야 함)
class Truck2: Car {
    var loadage: Int = 0
    func load() {print("load")}
    func unLoad() { print("unLoad")}
    override func speedUp() {
        speed += 5
    }
    init(loadage: Int, wheelCount: Int, seatCount: Int) {
        self.loadage = loadage
        super.init(wheelCount: wheelCount, seatCount: seatCount)
    }
}
var truck2 = Truck2(loadage: 1000, wheelCount: 10, seatCount: 10)
print(truck2.loadage, truck2.wheelCount, truck2.seatCount)
truck2.speedUp()
print(truck2.speed)


