//
//  SingleAlarmView.swift
//  AlarmSwiftUI
//
//  Created by Valeh Ismayilov on 13.09.24.
//

import SwiftUI

struct SingleAlarmView: View {
   @State var isOn = false
   @State var time:String = "6:30"
   @State var days:[String] = []
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

				Text("Mon,Tue,Wed,Thu,Fri,Sat,Sun")
				   .font(.custom("OpenSans-Bold", size: 12))
				   .foregroundStyle(.textColor2)
				   .padding(.horizontal,2)

				

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
   SingleAlarmView()
}
