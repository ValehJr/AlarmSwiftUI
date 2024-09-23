//
//  AlarmView.swift
//  AlarmSwiftUI
//
//  Created by Valeh Ismayilov on 12.09.24.
//

import SwiftUI

struct AlarmView: View {
   @StateObject var alarmStore = AlarmStore()
   @State var isCreatig: Bool = false
   @State var isEditingScreen: Bool = false
   @State private var isEditing: Bool = false
   @State private var selectedAlarm: Alarm?

   var body: some View {
	  ZStack {
		 VStack {
			HStack {
			   Spacer()
			   Button(action: {
				  isEditing.toggle()
			   }, label: {
				  Text(isEditing ? "Done" : "Edit")
					 .font(.custom("OpenSans-Medium", size: 16))
					 .foregroundStyle(.black)
			   })
			}
			.padding(.horizontal)

			ScrollView {
			   ForEach($alarmStore.alarms) { $alarm in
				  SingleAlarmView(isOn: $alarm.isOn, time: alarm.time, selectedDays: alarm.days, isEditing: isEditing, onDelete: {
					 if let index = alarmStore.alarms.firstIndex(where: { $0.id == alarm.id }) {
						alarmStore.deleteAlarm(at: index)
					 }
				  }, onEdit: {
					 selectedAlarm = alarm
					 print("Selected alarm: \(selectedAlarm?.time ?? "None")")
                  })
                  .onChange(of: alarm.isOn) {
                     alarmStore.toggleAlarm(alarm)
                     print("Alarm toggled: \(alarm.isOn)")
                  }
				  .onAppear{
					 print(alarm)
				  }
				  .padding()
			   }
			   .padding(.bottom, 60)
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.ignoresSafeArea(.all)
			Spacer()
		 }
		 .padding(.top)

		 VStack {
			Spacer()
			Button(action: {
			   isCreatig.toggle()
			}, label: {
			   AlarmPlusButton()
			})
		 }
	  }
	  .popover(isPresented: $isCreatig) {
		 AlarmSetupView(isShowing: $isCreatig)
			.environmentObject(alarmStore)
	  }
	  .sheet(item: $selectedAlarm) { alarm in
		 if let index = alarmStore.alarms.firstIndex(where: { $0.id == alarm.id }) {
			AlarmEditView(alarmToEdit: alarm, alarmIndex: index, onSave: {
			   selectedAlarm = nil
			})
			.environmentObject(alarmStore)
		 }
	  }
   }
}


#Preview {
    AlarmView()
	  .background(Color.background)
}

