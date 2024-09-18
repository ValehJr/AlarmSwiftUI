//
//  SingleAlarmView.swift
//  AlarmSwiftUI
//
//  Created by Valeh Ismayilov on 13.09.24.
//

import SwiftUI

struct SingleAlarmView: View {
   @Binding var isOn:Bool
   @State var time:String = "6:30"
   @State var selectedDays:[String] = []
   @State var days:[String] = ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"]
   var isEditing: Bool = false
   var onDelete: (() -> Void)?

    var body: some View {
	   ZStack {
		  AlarmRoundedRectangle()
		  HStack {
			 VStack(alignment:.leading) {
				Text(time)
				   .font(.custom("OpenSans-SemiBold", size: 32))
				   .foregroundStyle(.textColor1)
				   .padding(.bottom,4)

				HStack(spacing:5) {
				   ForEach(days, id: \.self) { day in
					  Text(day)
						 .font(.custom("OpenSans-Bold", size: 12))
						 .foregroundColor(selectedDays.contains(day) ? .gradientColor1 : .textColor2)
				   }
				}

			 }//V

			 if isEditing {
				Button(action: {
				   onDelete?()
				}, label: {
				   Text("Delete")
					  .font(.custom("OpenSans-SemiBold", size: 18))
					  .foregroundStyle(.red)
				})
				.frame(width: 70)
			 } else {
				Toggle(isOn: $isOn) {
				}
				.toggleStyle(CustomToggleStyle())
				.padding(.leading,15)
			 }

		  }//H
		  .padding(.leading,0)
		  .padding(.vertical,10)
	   }//Z
	   .frame(maxWidth: 340)
	   .frame(height: 120)
    }
}

#Preview {
   @State var isOn = false
   return SingleAlarmView(isOn: $isOn)
}
