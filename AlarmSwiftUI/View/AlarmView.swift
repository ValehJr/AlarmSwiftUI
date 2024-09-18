//
//  AlarmView.swift
//  AlarmSwiftUI
//
//  Created by Valeh Ismayilov on 12.09.24.
//

import SwiftUI

struct AlarmView: View {

   @StateObject var alarmStore = AlarmStore()
   @State var isShowing:Bool = false
   @State private var isEditing: Bool = false

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
			}//H
			.padding(.horizontal)
			ScrollView {
			   ForEach($alarmStore.alarms) { $alarm in
				  SingleAlarmView(isOn: $alarm.isOn, time: alarm.time, selectedDays: alarm.days ,isEditing: isEditing, onDelete: {
					 if let index = alarmStore.alarms.firstIndex(where: { $0.id == alarm.id }) {
						alarmStore.deleteAlarm(at: index)
					 }
				  })
				  .onChange(of: alarm.isOn) {
					 alarmStore.toggleAlarm(alarm)
				  }
				  .onAppear{
					 print(alarm)
				  }
				  .padding()
			   }
			   .padding(.bottom, 60)
			}//Scroll
			.frame(maxWidth: .infinity,maxHeight: .infinity)
			.ignoresSafeArea(.all)
			Spacer()
		 } // VStack
		 .padding(.top)

		 VStack {
			Spacer()
			Button(action: {
			   isShowing.toggle()
			}, label: {
			   AlarmPlusButton()
			}) // Button
		 }//V
	  } // Z
	  .popover(isPresented: $isShowing, content: {
		 AlarmSetupView(isShowing: $isShowing)
			.environmentObject(alarmStore)
	  })

   }
}

#Preview {
    AlarmView()
	  .background(Color.background)
}
