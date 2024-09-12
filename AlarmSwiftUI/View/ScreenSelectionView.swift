//
//  ScreenSelectionView.swift
//  AlarmSwiftUI
//
//  Created by Valeh Ismayilov on 11.09.24.
//

import SwiftUI

struct ScreenSelectionView: View {
   @State private var selectedButton: String? = "Clock"
   @Binding var selectedScreen: Screen

   var body: some View {
	  ZStack {
		 Capsule()
			.fill(Color.backgroundColor2)
			.shadow(color: Color.black.opacity(0.2), radius: 5, x: 3, y: 3)
			.shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)

		 HStack {
			Button(action: {
			   selectedButton = "Clock"
			   selectedScreen = .clock
			}) {
			   Text("Clock")
			}
			.buttonStyle(CustomButtonStyle(isSelected: selectedButton == "Clock"))
			.frame(width: 70, height: 22)

			Spacer()

			Button(action: {
			   selectedButton = "Alarm"
			   selectedScreen = .alarm
			}) {
			   Text("Alarm")
			}
			.buttonStyle(CustomButtonStyle(isSelected: selectedButton == "Alarm"))
			.frame(width: 70, height: 22)

			Spacer()

			Button(action: {
			   selectedButton = "Stopwatch"
			   selectedScreen = .stopwatch
			}) {
			   Text("Stopwatch")
			}
			.buttonStyle(CustomButtonStyle(isSelected: selectedButton == "Stopwatch"))
			.frame(width: 110, height: 22)
		 }//H
		 .padding(.horizontal)
	  }//Z
	  .frame(maxWidth: 330)
	  .frame(height: 48)
   }
}

#Preview {
   @State var screen = Screen.clock
   return ScreenSelectionView(selectedScreen: $screen)
}
