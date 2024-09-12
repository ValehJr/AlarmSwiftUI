//
//  TimeView.swift
//  AlarmSwiftUI
//
//  Created by Valeh Ismayilov on 12.09.24.
//

import SwiftUI

struct TimeView: View {
   @Binding var time:String
   @Binding var date: String
   var body: some View {
	  VStack(spacing:16) {
		 ZStack {
			TimeCapsule()
			Text(time)
			   .font(.custom("OpenSans-SemiBold", size: 45))
			   .foregroundStyle(.textColor1)
		 }

		 Text(date)
			.font(.custom("OpenSans-SemiBold", size: 16))
			.foregroundStyle(.textColor1)
	  }
   }
}

#Preview {
   @State var time = "15:30"
   @State var date = "Monday, 10 august"
   return TimeView(time: $time, date: $date)
}
