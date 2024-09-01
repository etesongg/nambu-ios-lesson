protocol SampleProtocol {
    var name: String { get set }
    var description: String { get }
}

struct SampleProject: SampleProtocol {
    var name = "홍길동"
    var description: String {
        return "Name: \(self.name)"
    }
}

//let sp = SampleProject()
//print(type(of: sp))
//print(sp is SampleProject) // is 뒤에 나오는게 인스턴스인지 알려줌
//print(sp is SampleProtocol) // 둘다 true 나옴. 즉, sp는 SampleProject, SampleProtocol을 인스턴스로 가지고 있음

protocol Player {
    var playTime: Int { get set }
    func play()
    func pause()
    func next()
    func previous()
}

class AudioPlayer: Player {
    var playTime: Int = 10
    func play() {
        print("AudioPlayer play")
    }
    func pause() {
        print("AudioPlayer pause")
    }
    func next() {
        print("AudioPlayer next")
    }
    func previous() {
        print("AudioPlayer previous")
    }
}
class VidoePlayer: Player {
    var playTime: Int = 20
    func play() {
        print("VidoePlayer play")
    }
    func pause() {
        print("VidoePlayer pause")
    }
    func next() {
        print("VidoePlayer next")
    }
    func previous() {
        print("VidoePlayer previous")
    }
}

let audioP = AudioPlayer()
let videoP = VidoePlayer()
audioP.next()
videoP.next()
print(audioP is AudioPlayer)
print(audioP is Player)
print(videoP is VidoePlayer)
print(videoP is Player)

