//
//  AlarmSetupView.swift
//  AlarmSwiftUI
//
//  Created by Valeh Ismayilov on 13.09.24.
//

import SwiftUI

struct AlarmSetupView: View {
   @State private var selectedHour = 0
   @State private var selectedMinute = 0

   var hours: [String] = Array(0...23).map { String(format: "%02d", $0) }
   var minutes: [String] = Array(0...59).map { String(format: "%02d", $0) }


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
			   .padding(.horizontal,2)

			CustomPickerView(selectedIndex: $selectedMinute, items: minutes)
			   .frame(width: 100, height: 150)
		 }//H
		 .padding(.vertical,25)

		 WeekView()
			.padding(.vertical)

		 Spacer()

		 Button(action: {

		 }, label: {
			ZStack {
			   TimeCapsule()
				  .frame(width: 120,height: 60)
			   Text("Save")
				  .font(.custom("OpenSans-Medium", size: 28))
				  .foregroundStyle(.black)
			}//Z
		 })//Button
		 .padding(.vertical,20)


	  }//V
	  .padding()
   }
}

#Preview {
    AlarmSetupView()
}
