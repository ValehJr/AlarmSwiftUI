//
//  WeekView.swift
//  AlarmSwiftUI
//
//  Created by Valeh Ismayilov on 16.09.24.
//

import SwiftUI

struct WeekView: View {
   @State private var selectedDays: [String] = []

   let daysOfWeek = ["M", "T", "W", "T", "F", "S", "S"]
   let fullDayNames = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

   var body: some View {
	  ZStack{
		 
		 WeekCapsule()

		 HStack(spacing: 15) {
			ForEach(0..<daysOfWeek.count, id: \.self) { index in
			   DaySelectionView(day: daysOfWeek[index], isSelected: Binding(
				  get: { selectedDays.contains(fullDayNames[index]) },
				  set: { isSelected in
					 if isSelected {
						selectedDays.append(fullDayNames[index])
					 } else {
						selectedDays.removeAll { $0 == fullDayNames[index] }
					 }
				  }
			   ))
			}
		 }//H
		 .padding()
	  }//Z
   }
}

#Preview {
   WeekView()
}
