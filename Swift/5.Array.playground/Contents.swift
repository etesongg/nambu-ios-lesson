// Array 선언과 초기화
// Type Annotation
var bts = ["진", "슈가", "제이홉", "RM", "지민", "뷔", "정국"]
var bts1 = ["진","슈가","제이홉","RM","지민","뷔","정국"]
let bts2 = ["김석진","민윤기","정호석","김남준","박지민","김태형","전정국"]
var bts3:Array<String> = ["진","슈가","제이홉","RM","지민","뷔","정국"]
var bts4:[String] = ["진","슈가","제이홉","RM","지민","뷔","정국"] // 이걸 기본으로 사용
var bts5:Array<String> = Array<String>() // 빈배열 생성
bts5.append("슈가")
bts5.append("선우")
var bts6:[String] = [String]() // bts5와 같은 타입 축약으로 쓴것임, 축약으로 쓸때 <> -> []로 바뀜
var bts7 = [String]() // 타입형을 쓰지 않아도 추론으로 알아서 지정됨
var bts8:[String] = [] // 빈배열이기 때문에 타입형을 안 쓰면 에러남
var bts9 = Array(repeatElement(0, count:3)) // [0, 0, 0]
var bts10 = [String](repeatElement("없음", count:3)) // ["없음", "없음", "없음"]

var arr1: Array<Int> // 상수형 정수 배열
var arr2: Array<String> // 변수형 문자열 배열
var arr3: [Int] // 상수형 정수 배열
var arr4: [String] // 변수형 문자열 배열

let member = bts[0]
print("첫번째 멤버는 \(member)입니다.")
bts[3] = "RM"

for name in bts {
    print(name)
}

let length = bts.count
print(length)

for index in 0...length-1 {
    print("\(index+1)번째 멤버는 \(bts[index])입니다.")
}

bts.append("정국")
print(bts)
bts.insert("정국", at: 1)
print(bts)
bts.remove(at: 1)
bts.append(contentsOf: ["뷔", "정국"]) // 어레이 추가할때 사용 contentsOf
print(bts)
bts += ["김태형", "전정국"] // +로 어레이 추가 가능
print(bts)
let part = bts[0...2]
print(part)
bts[0...2] = ["김석진", "민윤기"] // 어레이 범위로 값 변경 가능, 요소 갯수 안 맞아도 상관 없음, 덮어쓰기로 보면 됨
print(bts)

// set
var set1: Set<String> = Set<String>()
var set2: Set<String> = []
var set3: Set<String> = ["진", "슈가", "제이홉", "RM", "지민" ]

// set에서는 형지정을 생략하면 Array로 인식된다.
print(set3)
var nums = [1, 2, 3]
print(nums)

for name in nums {
    print(name)
}

let result = set3.insert("진")
print(result) // (inserted: false, memberAfterInsert: "진") //같은값이있으면추가안됨
let result1 = set3.insert("뷔")
print(result1) // (inserted: true, memberAfterInsert: "뷔")
let result2 = set3.remove("뷔")
print(result2) // Optional("뷔")
let result3 = set3.remove("뷔")
print(result3) //nil -> null과 같음
