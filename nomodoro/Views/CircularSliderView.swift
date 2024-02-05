//
//  CircularSliderView.swift
//  nomodoro
//
//  Created by G on 2024-02-04.
//

import SwiftUI

struct CircularSliderView: View {
    
    @Binding var timerState: TimerViewModel.TimerState
    @Binding var value: Double
        
    @State var rotationAngle = Angle(degrees: 0)
    @State var timer = Timer
        .publish(every: 1, on: .main, in: .common)
        .autoconnect()
    
    var minValue: Double
    var maxValue: Double
    @State var previousValue: Double = 0
    @State var previousAngle: Double = 0;
    
    private var progress: Double {
        return ((value - minValue) / (maxValue - minValue))
    }
    
    private func changeAngle(location: CGPoint) {
        // Create a Vector for the location (reversing the y-coordinate system on iOS)
        let vector = CGVector(dx: location.x, dy: -location.y)
        
        // Calculate the angle of the vector
        let angleRadians = atan2(vector.dx, vector.dy)
        var positiveAngle = angleRadians < 0.0 ? angleRadians + (2.0 * .pi) : angleRadians
        
        previousValue = value
        let newValue = (((positiveAngle / (2.0 * .pi)) * (maxValue - minValue)) + minValue).rounded()
        
        //TODO: There is a bug: you cannot set to 0 or 60
        if (abs(previousValue - newValue) >= maxValue / 2.0) {
            if (newValue < previousValue) {
                previousValue = maxValue
                print("we can set to 60")
            }
            value = previousValue
            positiveAngle = previousAngle
            previousAngle = positiveAngle
            rotationAngle = Angle(radians: positiveAngle)
        } else if newValue < 5*60 {
            value = 5*60
            // angleRadians = ((2.0 * .pi)*5.0)/(maxValue)
            // positiveAngle = angleRadians < 0.0 ? angleRadians + (2.0 * .pi) : angleRadians
            // previousAngle = positiveAngle
            rotationAngle = Angle(degrees: (360.0 / maxValue) *  5.0 * 60.0)
        }
        else {
            value = newValue
            previousAngle = positiveAngle
            rotationAngle = Angle(radians: positiveAngle)
            print(rotationAngle)
        }
        

    }
    
    var body: some View {
        GeometryReader { gr in
            let radius = (min(gr.size.width, gr.size.height) / 2.0) * 0.9
            VStack(spacing:0) {
                ZStack {
                    Circle()
                        .stroke(Color("lightOrange"),
                                style: StrokeStyle(lineWidth: 20))
                    
                    
                    Circle()
                        .trim(from: 0, to: progress)
                        .stroke(Color("darkOrange"),
                                style: StrokeStyle(lineWidth: 20, lineCap: .round)
                        )
                        .rotationEffect(Angle(degrees: -90))
                    
                    if timerState == .reset {
                        Circle()
                            .fill(Color.white)
                            .stroke(Color("darkOrange"),
                                    style: StrokeStyle(lineWidth: 5, lineCap: .round)
                            )
                            .frame(width: 40, height: 40)
                            .offset(y: -radius)
                            .rotationEffect(rotationAngle)
                            .gesture(
                                DragGesture(minimumDistance: 0.0)
                                    .onChanged() { dragValue in
                                        changeAngle(location: dragValue.location)
                                    }
                            )
                    } else {
                        Circle()
                            .fill(Color.white)
                            .stroke(Color("darkOrange"),
                                    style: StrokeStyle(lineWidth: 5, lineCap: .round)
                            )
                            .frame(width: 40, height: 40)
                            .offset(y: -radius)
                            .rotationEffect(Angle(degrees: 360 * progress))
                    }
                }
                .frame(width: radius * 2.0, height: radius * 2.0, alignment: .center)
                .padding(radius * 0.1)
                .onReceive(timer){ _ in
                    if timerState == .active || timerState == .resumed {
                        if (self.value > 0) {
                            value -= 1
                        } else {
                            value = 0
                            timerState = .reset
                        }
                    }
                }
                .onChange(of: timerState) {
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
                        value = 5 * 60
                        previousValue = 5 * 60
                        rotationAngle = Angle(degrees: (360.0 / maxValue) *  5.0 * 60.0)
                    }
                }
            }
            
            .onAppear {
                value = 5 * 60
                previousValue = 5 * 60
                self.rotationAngle = Angle(degrees: (360.0 / maxValue) *  5.0 * 60.0)
            }
        }
    }
}
