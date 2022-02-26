
import SwiftUI
import UserNotifications
import AVFoundation
import UserNotifications

let  defaultime: CGFloat = 10
let  linewidth: CGFloat = 30
let  radius: CGFloat = 70
var  player: AVAudioPlayer!


struct TimerView: View {
    @State private var isActive = false
    @State private var timeRemaining: CGFloat = 10
    @State private var rest: Bool = false
    //@StateObject var pause = RestingTime()

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        
    var body: some View {
        if(rest==false){
            VStack(spacing: 25){
                ZStack{
                    Circle()
                        .stroke(Color.gray.opacity(0.2), style: StrokeStyle(lineWidth: linewidth, lineCap: .round))
                    Circle()
                        .trim(from: 0, to: 1 - ((defaultime - timeRemaining) / defaultime))
                        .stroke(Color.green, style: StrokeStyle(lineWidth: linewidth, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                        .animation(.easeInOut)
                    Text("\(timeString(time: timeRemaining))")
                        .font(.largeTitle)
                }
                .frame(width: radius * 2, height: radius * 2)
                HStack(spacing:25){
                    Label("\(isActive ? "Pause" : "Play")", systemImage: "\(isActive ? "pause.fill" : "play.fill")")
                            .foregroundColor(isActive ? .red: .yellow)
                        .font(.title)
                        .onTapGesture(perform: {
                            isActive.toggle()
                        })
                        
                    Label("Restart", systemImage: "backward.fill")
                        .foregroundColor(.gray)
                        .font(.title)
                        .onTapGesture(perform: {
                            isActive = false
                            timeRemaining = defaultime
                        })
                }
                VStack{
                    Text("Leaving this screen will NOT pause the timer.")
                        .font(.title)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        
                    Text("So stay here, dont get distracted, and finish your work! 🤓")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .padding()
                }
                
            }.onReceive(timer, perform: { _ in
                guard isActive else { return }
                if timeRemaining > 0{
                    timeRemaining -= 1
                }
                else{
                    playSound()
                    isActive = false
                    //pause.changerest(rest: pause.rest)
                    rest = true
                    timeRemaining = defaultime
                }
            })
        }
        else if (rest == true){
            TimerViewFor5()
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
    

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            TimerView()
        }
    }
}

}

