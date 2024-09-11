//
//  ScreenSelectionView.swift
//  AlarmSwiftUI
//
//  Created by Valeh Ismayilov on 11.09.24.
//

import SwiftUI

struct ScreenSelectionView: View {
   @State private var selectedButton: String? = "Alarm"

    var body: some View {
	   ZStack {
		  Capsule()
			 .fill(Color.backgroundColor2)
			 .shadow(color: Color.black.opacity(0.2), radius: 5, x: 3, y: 3) // Inner shadow
			 .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)

		  HStack {
			 Button(action: {
				selectedButton = "Alarm"
			 }) {
				Text("Alarm")
			 }
			 .buttonStyle(CustomButtonStyle(isSelected: selectedButton == "Alarm"))
			 .frame(width: 70, height: 22)

			 // Timer Button
			 Spacer()
			 
			 Button(action: {
				selectedButton = "Timer"
			 }) {
				Text("Timer")
			 }
			 .buttonStyle(CustomButtonStyle(isSelected: selectedButton == "Timer"))
			 .frame(width: 70, height: 22)
		  }//H
		  .padding(.horizontal)
	   }//Z
	   .frame(width: 200,height: 48)
	}
}

#Preview {
    ScreenSelectionView()
}