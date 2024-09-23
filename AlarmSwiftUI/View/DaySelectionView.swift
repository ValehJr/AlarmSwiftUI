//
//  DaySelectionView.swift
//  AlarmSwiftUI
//
//  Created by Valeh Ismayilov on 16.09.24.
//

import SwiftUI

struct DaySelectionView: View {
   var day: String
   @Binding var isSelected: Bool

    var body: some View {
	   Button(action: {
		  isSelected.toggle()
	   }, label: {
		  ZStack {
			 Circle()
				.stroke(.textColor1, lineWidth: 1.5)
				.fill(isSelected ? gradientColor : linearGradientC)
			 .frame(maxWidth: 35)

			 Text("\(day)")
				.font(.custom("OpenSans-SemiBold", size: 20))
				.foregroundStyle(isSelected ? .white : .textColor1)
		  }
	   })
    }
}

#Preview {
   @Previewable @State var isSelected = false
   return DaySelectionView(day:"M",isSelected:$isSelected)
}
