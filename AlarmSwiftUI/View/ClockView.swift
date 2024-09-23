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
   @State private var currentSecondAngle: Double = 0
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

			SecondRectangle()
			   .rotationEffect(Angle.degrees(currentSecondAngle), anchor: .bottom)
			   .offset(x:0,y:-45)


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
		 startRepeatingTimer()
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
	  let second = calendar.component(.second, from: date)


	  currentTime = "\(Date.now.formatted(date: .omitted, time: .shortened))"

	  let formatter = DateFormatter()
	  formatter.dateFormat = "EEEE, d MMMM"
	  currentDate = formatter.string(from: Date())

	  currentHourAngle = Double(hourAM) / 12 * 360 + Double(minute) / 60 * 30
	  currentMinuteAngle = Double(minute) / 60 * 360
	  currentSecondAngle = Double(second) / 60 * 360
   }

   func startRepeatingTimer() {
	  timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
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
