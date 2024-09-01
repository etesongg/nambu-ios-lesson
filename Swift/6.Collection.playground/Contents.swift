// tuple 다양한 데이터 타입이 공존
// 수정 못함
let tupleValue = ("a", "b", 1, 2.5, true)
print(tupleValue.0)
tupleValue.1
tupleValue.3
tupleValue.4

let(a, b, c, d, e) = tupleValue
print(a)

// 다양한 데이터 타입이 공존하기 때문에 타입 지정도 여러개 지정
let tpl01 : (Int, Int) = (100, 100)
let tpl02 : (Int, String, Int) = (100, "a", 200)
let tpl03 : (Int, (String, String)) = (100, ("t", "y")) // 데이터 타입은 Int , String 딕셔너리
let tpl04 : (String) = ("sample string")
print(tpl01)

// Dictionary
var capital = ["KR":"Seoul","EN":"London","FR":"Paris"]
var capital1 :Dictionary<String,String>
capital1 = Dictionary<String,String>() // 선언까지만 된거 ["FR": "Paris", "KR": "Seoul", "EN": "London"]

var capital2 :Dictionary<String,String>
capital2 = Dictionary() // 추론으로 만들어줌 [:]

var capital3 : [String:String]
capital3 = [String:String]() // 단축 [:]

var capital4 : [String:String]
capital4 = [:]

var capital5 = ["KR":"Seoul","EN":"London","FR":"Paris"]
print(capital5["KR"])
capital5["EN"]
capital5["FR"]
capital5["KR"] = "Sejong"
capital5["JP"] = "Tokyo"
print(capital5)
capital5["JP"] = nil
print(capital5["FR"]) // Optional("Paris")
print(capital5)

var capitals = ["KR":"Seoul","EN":"London","FR":"Paris"]
print(capital.keys)
print(capital.values)
for(country, capital) in capitals {
    print("\(country)'s capital = \(capital)")
}

var tArray: Array<(String, Int)> = [("a", 1), ("b", 2)] //스트링 인트 듀플
print(tArray[1]) // ("b", 2)
let t1 = tArray[0]
t1.0 // a
t1.1 // 1

var tuple:([String], Int) = (["뷔", "RM"], 3) //스트링 어레이, 인트 튜플
tuple.0

var dic:[String: [String]] = ["name": ["뷔", "RM"]] //스트링,스트링 딕셔너리
print(dic["name"]) // Optional(["뷔", "RM"])

var dArray: [[String:String]] = [["a": "b", "c": "d"],["c": "d"]] //스트링스트링 딕셔너리
print(dArray[0]) // ["c": "d", "a": "b"]




