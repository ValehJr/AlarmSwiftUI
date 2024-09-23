//
//  SingleAlarmView.swift
//  AlarmSwiftUI
//
//  Created by Valeh Ismayilov on 13.09.24.
//

import SwiftUI

struct SingleAlarmView: View {
   @Binding var isOn: Bool
   @State var time: String
   @State var selectedDays: [String]
   @State private var showSetupView = false
   var days: [String] = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
   var isEditing: Bool = true
   var onDelete: (() -> Void)?
   var onEdit: (() -> Void)? // New editing closure

   var body: some View {
	  ZStack {
		 AlarmRoundedRectangle()
		 HStack {
			VStack(alignment: .leading) {
			   Text(time)
				  .font(.custom("OpenSans-SemiBold", size: 32))
				  .foregroundStyle(.textColor1)
				  .padding(.bottom, 4)

			   HStack(spacing: 5) {
				  ForEach(days, id: \.self) { day in
					 Text(day)
						.font(.custom("OpenSans-Bold", size: 12))
						.foregroundColor(selectedDays.contains(day) ? .gradientColor1 : .textColor2)
				  }
			   }
			}
			.padding()

			if isEditing {
			   HStack {
				  Button(action: {
					 onDelete?()
				  }, label: {
					 Image(systemName: "minus.circle")
						.resizable()
						.scaledToFit()
						.frame(width: 45)
						.font(.custom("OpenSans-SemiBold", size: 7))
						.foregroundStyle(.red)
				  })
				  .frame(width: 70)

				  Button(action: {
					 onEdit?()
				  }, label: {
					 Image(systemName: "chevron.right")
						.resizable()
						.scaledToFit()
						.frame(width: 10)
						.font(.custom("OpenSans-SemiBold", size: 5))
						.foregroundStyle(.textColor2)
				  })
			   }
			} else {
			   Toggle(isOn: $isOn) {}
				  .toggleStyle(CustomToggleStyle())
				  .padding(.leading, 15)
			}
		 }
		 .padding(.leading, 0)
		 .padding(.vertical, 10)
	  }
	  .frame(maxWidth: 340)
	  .frame(height: 120)
   }
}


#Preview {
   @Previewable @State var isOn = false
   return SingleAlarmView(isOn: $isOn, time: "6:30", selectedDays: ["Mon"] )
}
