//
//  ClockView.swift
//  AlarmSwiftUI
//
//  Created by Valeh Ismayilov on 12.09.24.
//

import SwiftUI

struct ClockView: View {
   @State private var currentMinuteAngle: Double = 0
   @State private var currentHourAngle: Double = 0
   @State private var currentTime: String = ""
   @State private var currentDate: String = ""
   @State private var timer: Timer?


   var body: some View {
	  VStack {
		 ZStack {
			OuterCircle()
			MiddleCircle()
			InnerCircle()
			MinuteTriangle()
			   .rotationEffect(Angle.degrees(currentMinuteAngle),anchor: .bottom)
			   .offset(x:0,y:-43)
			HourTriangle()
			   .rotationEffect(Angle.degrees(currentHourAngle),anchor: .bottom)
			   .offset(x:0,y:-32)
			SmallCircle()
			GradientCircle()

			ForEach(0..<12) { i in
			   let angle = Angle.degrees(Double(i) / 12 * 360)
			   let pointX = cos(angle.radians) * 90
			   let pointY = sin(angle.radians) * 90

			   ClockPointView()
				  .offset(x: pointX, y: pointY)
			}

		 }
		 .frame(maxWidth: 320,maxHeight: 320)
		 .padding()
		 TimeView(time: $currentTime, date: $currentDate)
	  }
	  .onAppear {
		 updateClockAngles()
		 scheduleNextTimer()
	  }
	  .onDisappear {
		 stopTimer()
	  }
   }

   func updateClockAngles() {
	  let calendar = Calendar.current
	  let date = Date()

	  let hourAM = calendar.component(.hour, from: date) % 12
	  let minute = calendar.component(.minute, from: date)

	  currentTime = "\(Date.now.formatted(date: .omitted, time: .shortened))"

	  let formatter = DateFormatter()
	  formatter.dateFormat = "EEEE, d MMMM"
	  currentDate = formatter.string(from: Date())

	  currentHourAngle = Double(hourAM) / 12 * 360 + Double(minute) / 60 * 30
	  currentMinuteAngle = Double(minute) / 60 * 360
   }

   func scheduleNextTimer() {
	  let calendar = Calendar.current
	  let date = Date()

	  let seconds = calendar.component(.second, from: date)
	  let timeIntervalUntilNextMinute = Double(60 - seconds)

	  timer = Timer.scheduledTimer(withTimeInterval: timeIntervalUntilNextMinute, repeats: false) { _ in
		 updateClockAngles()
		 startRepeatingTimer()
	  }
   }

   func startRepeatingTimer() {
	  timer = Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true) { _ in
		 updateClockAngles()
	  }
   }

   func stopTimer() {
	  timer?.invalidate()
	  timer = nil
   }
}

#Preview {
   ClockView()
}
