struct Person {
    var name: String
    var age: Int
    var gender: String
    var height: Double
    func info() {
        print("이름 : \(name), 나이 : \(age), 성별 : \(gender), 키 : \(height)" )
    }
}
// 구조체의 생성자는 속성을 파악하여 자동생성, 프로퍼티 기본값을 가질때는 생략가능
//var person = Person(name: "song", age: 15, gender: "male", height: 177)
//print(person.name)
//print(person.gender)
//print(person.height)
//person.info()
// class는 참조값 전달(copy by value) 나머지는 벨류값 전달(copy by reference) 그래서 struct는 copy해서 값을 바꿔도 원본 값은 바뀌지 않음

// mutating 메서드(struct는 불변이기 때문에 자신의 값을 바꾸는 메서드 키워드)
struct Point {
    var x = 0.0; var y = 0.0
    mutating func moveBy(x deltaX:Double, y deltaY:Double){
        x += deltaX
        y += deltaY
    }
}
//var somePoint = Point(x: 1.0, y:1.0)
//somePoint.moveBy(x: 2.0, y: 2.0)
//print(somePoint.x, somePoint.y) // 3.0 3.0

struct Student {
    var grade: Int
    var num: Int
    var name:String
    mutating func promotion() {
        grade += 1
    }
    func info() {
        print("학년: \(grade), 번호: \(num), 이름: \(name)")
    }
}
var student1 = Student(grade: 2, num: 13, name: "song")
print(student1.grade)
student1.promotion()
student1.info()

var student2 = Student(grade: 3, num: 22, name: "min")
print(student2.grade)
student2.promotion()
student2.info()

var student3 = student2
student3.name = "lee"
student2.info() // 학년: 4, 번호: 22, 이름: min
student3.info() // 학년: 4, 번호: 22, 이름: lee
