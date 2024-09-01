// Enumeration : 공통된 주제에 대해서 이미 정해놓은 입력 값만 선택해서 받고 싶을 때 사용하는 것
enum Direction {
    case north
    case south
    case east, west
}
var directionToHead = Direction.north //Direction. 을 하면 내가 선언한 것중에 골라서 사용할 수 있으므로 오타낼 일이 줄어드니 안정성도 향상됨
//print(directionToHead) // north
//
//directionToHead = .east
//
//var directionToHead1 = Direction.east
//var directionToHead2:Direction = .east // 동쪽입니다.

// 열거형을 사용하는 switch
switch directionToHead { // 위에 선언한 case 갯수에 따라서 switch문으로 만들어 준다면 default 없어도 됨
case .north : print("북쪽입니다.")
case .south : print("남쪽입니다.")
case .east : print("동쪽입니다.")
case .west : print("서쪽입니다.")
}

enum HTTPCode :Int {
    case OK = 200 // 원시값 지정, 200은 rowValue임
    case NOT_MODIFY = 304
    case INCORRECT_PAGE  = 404
    case SERVER_ERROR = 500
}
//print(HTTPCode.OK)
//print(HTTPCode.OK.rawValue)

enum Rank: Int {
    case one = 1
    case two, three, four, five // 각 2, 3, 4, 5 순서로 지정됨
}
//print(Rank.four.rawValue)

enum Direction1:Int {
    case north = 1
    case south
    case east, west
    var value: String {
        return "방향 코드는 \(self.rawValue)" // 연산 프로퍼티 get 만 있는 형식
    }
    func getDescription() -> String {
        switch self {
        case .north: return "북쪽이고 코드는 \(self.rawValue)"
        case .south: return "남쪽이고 코드는 \(self.rawValue)"
        case .east: return "동이고 코드는 \(self.rawValue)"
        case .west: return "서쪽이고 코드는 \(self.rawValue)"
    }
  }
}

//var direction = Direction1.north
//var dir:Direction1 = .south
//print(direction.value)
//print(direction.getDescription())

//타입이 안 맞는 경우
//상속받는게 아니고 기능을 추가해 확장을 함
extension Double {
    var km:Double { return self * 1000.0}
    var m : Double { return self}
    var cm : Double { return self/100.0}
    var mm:Double  {return self/1000.0}
    var description: String {
        return "\(self)km는 \(self.km)m, \(self)cm는\(self.cm)m, \(self)mm는\(self.mm)m입니다."
    }
}

//let distance1:Double = 11.0
//print(distance1.km)
//print(distance1.m)
//
//let distance = 42.0.km + 195.magnitude
//print("마라톤의 총 거리는 \(distance)m 입니다.")

// 클래스나 구조체 확장
extension Int {
    mutating func square() {
        self = self * self
    }
}
var value = 3
value.square()
print(value)
