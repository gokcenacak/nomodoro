//
//  TimerView.swift
//  nomodoro
//
//  Created by G on 2024-02-04.
//

import SwiftUI
import Combine

struct TimerView: View {
    @State var timer = Timer
        .publish(every: 1, on: .main, in: .common)
        .autoconnect()
    @Binding var counter: Int
    @State var timerDuration: Double
    @Binding var timerState: TimerViewModel.TimerState


    var body: some View {
        ZStack {           
              // Background for the progress bar
              Circle()
                .stroke(lineWidth: 20).opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                .foregroundColor(Color("lightOrange"))

              Circle()
                .trim(from: 0.0, to: progress())
                .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color("darkOrange"))               .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear, value: progress())
            }
            .onReceive(timer) { timer in
                if timerState == .active || timerState == .resumed {
                    if (self.counter > 0) {
                        counter -= 1
                    } else {
                        timerState = .reset
                        counter = 0
                    }
                }
            }.onChange(of: timerState) {
                switch timerState {
                case .active:
                    timer.upstream.connect().cancel()
                    timer = Timer
                        .publish(every: 1, on: .main, in: .common)
                        .autoconnect()
                case .paused:
                    timer.upstream.connect().cancel()
                case .resumed:
                    timer = Timer
                        .publish(every: 1, on: .main, in: .common)
                        .autoconnect()
                case .reset:
                    timerDuration = 0
                    counter = 0
                }
            }
    }
    
    func progress() -> CGFloat {
        if timerDuration == 0 {
            return 0
        } else {
            return CGFloat(counter) / CGFloat(timerDuration)
        }
    }
}

#Preview {
    TimerView(counter: .constant(0), timerDuration: 60, timerState: .constant(.reset)).padding().frame(width: 300, height: 300)
}
