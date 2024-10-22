import Foundation
struct Person: Codable {
    let name:String
    let age:Int
}

//  ata(8bit data로 만들어진) -> json
let person = Person(name: "RM", age: 25)
let json = try? JSONEncoder().encode(person)
if let json = json, let jsonStr = String(data: json, encoding: .utf8) {
    print(jsonStr)
}

// json -> data(8bit data로 만들어진)
let data = """
{
    "name": "정국",
    "age": 21
}
""".data(using: .utf8)! // data()는 옵셔널은 반환해서 언래핑을 해줘야 함

let person1 = try? JSONDecoder().decode(Person.self, from:data)
print(person1!)

