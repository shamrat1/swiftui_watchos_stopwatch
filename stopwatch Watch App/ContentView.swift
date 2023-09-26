//
//  ContentView.swift
//  stopwatch Watch App
//
//  Created by Marsa Technologies on 25/9/23.
//

import SwiftUI

struct ContentView: View {
    @State private var startTime: Date?
     @State private var accumulatedTime: TimeInterval = 0
     @State private var isRunning = false
     @State private var timer: Timer?
    @State private var stopWatchTimes : [String] = [];
    var body: some View {
        NavigationView{
            VStack(alignment: .center) {
                HStack{
                    CircularIconButton()
                    Spacer()
                        Button(action: {
                            reset()
                        }){
                            Image(systemName: "stop.fill")
                                .foregroundColor(isRunning ? .red : .green)
                                .background(.gray)    .clipShape(Circle())
                                
                                .animation(.easeInOut(duration: 1).repeatForever())
                        }.clipShape(Circle()).frame(width: 40,height: 40)
                        .opacity(isRunning ? 1 : 0)
                }
                
                Spacer()
                if(isRunning){
                    Text(formattedElapsedTime).font(.custom("Roboto", size: 50)).bold()
                        .onTapGesture {
                            saveTimeSnapshot()
                        }
                }else{
                    Button(action: {
                        startStop()
                            }) {
                                Image(systemName: "play.circle")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .padding(12)
                                    .background(.gray) .clipShape(Circle())
                            }                                    .clipShape(Circle())

                }
                Spacer()
                if(!stopWatchTimes.isEmpty){
                    List {
                                ForEach(stopWatchTimes, id: \.self) { stringItem in
                                    Text(stringItem)
                                }
                    }.listStyle(.carousel)
                }
            }
        }
        
    }
    
    func saveTimeSnapshot(){
        stopWatchTimes.append(formattedElapsedTime)
    }
    
    var formattedElapsedTime: String {
            let totalElapsed = accumulatedTime + (isRunning ? Date().timeIntervalSince(startTime ?? Date()) : 0)
            let minutes = Int(totalElapsed) / 60
            let seconds = Int(totalElapsed) % 60
            let milliseconds = Int((totalElapsed.truncatingRemainder(dividingBy: 1)) * 100)
        return String(format: "%02d:%02d", minutes, seconds)
//            return String(format: "%02d:%02d.%02d", minutes, seconds, milliseconds)
        }

        func startStop() {
            if isRunning {
                timer?.invalidate()
            } else {
                startTime = Date()
                stopWatchTimes = []
                timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                    self.accumulatedTime += 0.01
                }
            }
            isRunning.toggle()
        }

        func reset() {
            timer?.invalidate()
            startTime = nil
            accumulatedTime = 0
            isRunning = false
        }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct CircularIconButton: View {
    var body: some View {
        NavigationLink(destination: SettingView()) {
            Image(systemName: "gear.circle")
                .resizable()
                .scaledToFit()
                .foregroundColor(.white)
                .clipShape(Circle())
        }.clipShape(Circle()).frame(width: 40,height: 40)
    }
}
