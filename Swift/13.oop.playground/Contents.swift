class Vehicle {
    var wheels:Int
    var seats:Int
    var engine:Int
    init(wheels: Int, seats: Int, engine: Int) {
        self.wheels = wheels
        self.seats = seats
        self.engine = engine
    }
    func drive() { print("Run") }
}
//var bike = Vehicle(wheels: 2, seats: 2, engine: 2)
//print(bike.wheels) // 2
//print(bike.seats)
//bike.wheels = 3
//print(bike.wheels)

//var car = Vehicle(wheels: 4, seats: 4, engine: 4)
//print(car.wheels)
//print(car.seats)
//car.drive()

//var copyBike = bike
//copyBike.wheels = 3
//print(copyBike.wheels) // 3
//print(bike.wheels) // 3
// 인스턴트는 별도로 저장되어 있음
// 참조카운트 자기를 가리키는 화살표

// 상속
class Car: Vehicle {
    init() {
        super.init(wheels: 4, seats: 5, engine: 4)
    }
    func shiftGear() {
        print("변속")
    }
}
//let car1 = Car() // 인스턴스가 바뀔 일이 없기때문에 let으로 쓴다.
//car1.wheels = 6
//print(car1.wheels)
//print(car1.seats)
//car1.drive()
//car1.shiftGear()

// 상속
class Sedan: Car {
    func loadPassenger() {
        print("Load Passenger")
    }
}

class Truck: Car {
    func loadCargo() {
        print("Load Cargo")
    }
}
//let sedan = Sedan()
//sedan.loadPassenger()
//sedan.shiftGear()
//sedan.drive()
//
//let truck = Truck()
//truck.loadCargo()
//truck.shiftGear()
//truck.drive()
