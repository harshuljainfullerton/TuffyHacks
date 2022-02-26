
import SwiftUI
import UserNotifications
import AVFoundation

let  defaultime5: CGFloat = 5
let  linewidth5: CGFloat = 30
let  radius5: CGFloat = 70
var  player5: AVAudioPlayer!

struct TimerViewFor5: View {
    @State private var isActive5 = false
    @State private var timeRemaining5: CGFloat = 5
    @State private var rest: Bool = true
    //@StateObject var pause = RestingTime()
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        if(rest == true){
            VStack(spacing: 25){
                ZStack{
                    Circle()
                        .stroke(Color.gray.opacity(0.2), style: StrokeStyle(lineWidth: linewidth5, lineCap: .round))
                    Circle()
                        .trim(from: 0, to: 1 - ((defaultime5 - timeRemaining5) / defaultime5))
                        .stroke(Color.green, style: StrokeStyle(lineWidth: linewidth5, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                        .animation(.easeInOut)
                    Text("\(timeString(time: timeRemaining5))")
                        .font(.largeTitle)
                }
                .frame(width: radius5 * 2, height: radius5 * 2)
                HStack(spacing:25){
                    Label("\(isActive5 ? "Pause" : "Play")", systemImage: "\(isActive5 ? "pause.fill" : "play.fill")")
                            .foregroundColor(isActive5 ? .red: .yellow)
                        .font(.title)
                        .onTapGesture(perform: {
                            isActive5.toggle()
                        })
                        
                    Label("Restart", systemImage: "backward.fill")
                        .foregroundColor(.gray)
                        .font(.title)
                        .onTapGesture(perform: {
                            isActive5 = false
                            timeRemaining5 = defaultime5
                        })
                }
                VStack{
                    Text("Good Work! Now go take a 5 minute break 🥳")
                        .font(.title)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        
                    Text("You will hear a ding once the 5 minute break period is up!")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                }
                
            }.onReceive(timer, perform: { _ in
                guard isActive5 else { return }
                if timeRemaining5 > 0{
                    timeRemaining5 -= 1
                }
                else{
                    playSound()
                    isActive5 = false
                    rest = false
                    //pause.changerest(rest: pause.rest)
                    timeRemaining5 = defaultime5
                }
            })
        }
        else if (rest == false){
            TimerView()
        }
    }
    func playSound(){
        let url = Bundle.main.url(forResource: "ding-sound-effect_2", withExtension: "mp3")
        guard url != nil else{
            return
        }
        do{
           player = try AVAudioPlayer(contentsOf: url!)
            player?.play()
        }catch{
            print("error")
        }
    }
    func timeString(time: CGFloat) -> String {
            let minutes = Int(time) / 60 % 60
            let seconds = Int(time) % 60
            return String(format:"%02i:%02i", minutes, seconds)
        }
    
}

struct TimerViewFor5_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            TimerViewFor5()
        }
    }
}



