for row in 1...5 {
    print("2 x \(row) = \(2*row)")
}

// 루프 상수의 생략
for _ in 1...5 {
    print("Hellow World!")
}

// 구구단
for i in 2...3 {
    print("-- \(i)단 --")
    for j in 1...9 {
        print("\(i) x \(j) = \(i*j)")
    }
}

var bts = ["진", "슈가", "제이홉", "RM", "지민", "뷔", "정국"]
for name in bts {
    print("hello, \(name)")
}

for name in bts[2...5] { // 2~5
    print("hello, \(name)")
}

var age = 0
while age < 5 {
    print("\(age)살 입니다.")
    age += 1
}

age = 0
var num = 0
while age < 5 {
    while num < 10 {
        print("\(age)살 입니다.")
        num += 1
    }
    num = 0
    age += 1
}

// repeat ~ while 구문
var n = 0
repeat {
    n = n + 1
    print("\(n)")
}
while n < 10

for row in 0...5 {
    if row == 2 {
        break
    }
    print("\(row) was executed!")
}

for row in 0...5 {
    if row == 2 { // 홀수만
        continue
    }
    print("\(row) was executed!")
}

// for, continue, % 사용해서 0~10 사이의 홀수 출력
for i in 0...10 {
    if i % 2 == 0 {
        continue
    }
    print("\(i)")
}
