//
//  AlarmEditView.swift
//  AlarmSwiftUI
//
//  Created by Valeh Ismayilov on 19.09.24.
//

import SwiftUI

struct AlarmEditView: View {
   @EnvironmentObject var alarmStore: AlarmStore
   @State private var selectedHour = 0
   @State private var selectedMinute = 0
   @State private var selectedDays: [String] = []
   var alarmToEdit: Alarm?
   var alarmIndex: Int?
   var onSave: () -> Void

   var hours: [String] = Array(0...23).map { String(format: "%02d", $0) }
   var minutes: [String] = Array(0...59).map { String(format: "%02d", $0) }

   private func initializeValues() {
	  if let alarm = alarmToEdit {
		 print("Initializing values for alarm: \(alarm)")
		 if let hour = Int(alarm.time.split(separator: ":")[0]) {
			selectedHour = hour
		 }
		 if let minute = Int(alarm.time.split(separator: ":")[1]) {
			selectedMinute = minute
		 }
		 selectedDays = alarm.days
	  }
   }

   var body: some View {
	  VStack {
		 Text("Setup an alarm")
			.font(.custom("OpenSans-Bold", size: 36))
			.foregroundStyle(.textColor1)

		 HStack {
			CustomPickerView(selectedIndex: $selectedHour, items: hours)
			   .frame(width: 100, height: 150)

			Text(":")
			   .font(.custom("OpenSans-Medium", size: 28))
			   .padding(.horizontal, 2)

			CustomPickerView(selectedIndex: $selectedMinute, items: minutes)
			   .frame(width: 100, height: 150)
		 }
		 .padding(.vertical, 25)
		 .task {
			initializeValues()
		 }

		 WeekView(selectedDays: $selectedDays)
			.padding(.vertical)

		 Spacer()

		 Button(action: {
			let timeString = "\(hours[selectedHour]):\(minutes[selectedMinute])"
			let newAlarm = Alarm(time: timeString, days: selectedDays, isOn: true)

			if let index = alarmIndex {
			   alarmStore.editAlarm(newAlarm, at: index)
			}

			onSave()  // Trigger dismissal from the parent view
		 }, label: {
			ZStack {
			   TimeCapsule()
				  .frame(width: 120, height: 60)
			   Text("Save")
				  .font(.custom("OpenSans-Medium", size: 28))
				  .foregroundStyle(.black)
			}
		 })
		 .padding(.vertical, 20)
	  }
	  .padding()
   }
}


#Preview {
   AlarmEditView(onSave : {
	  print("Saved")
   })
	  .environmentObject(AlarmStore())
}
