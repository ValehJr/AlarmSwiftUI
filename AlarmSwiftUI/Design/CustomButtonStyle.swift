//
//  CustomButtonStyle.swift
//  AlarmSwiftUI
//
//  Created by Valeh Ismayilov on 11.09.24.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
   var isSelected: Bool

   func makeBody(configuration: Configuration) -> some View {
	  ZStack {
		 if isSelected {
			Capsule()
			   .fill(LinearGradient(gradient: Gradient(colors: [Color.shadow.opacity(0.8), Color.white.opacity(1)]), startPoint: .topLeading, endPoint: .bottomTrailing))
			   .shadow(color: Color.white.opacity(1), radius: 0.1, x: 1, y: 1) // Inner shadow
			   .shadow(color: Color.shadow.opacity(1), radius: 1, x: -2, y: -2) // Outer shadow
			   .frame(minWidth: 78, maxWidth: 120)
			   .frame(height: 32)
		 }

		 configuration.label
			.font(isSelected ? .custom("OpenSans-Bold", size: 16) : .custom("OpenSans-SemiBold", size: 16))
			.foregroundColor(isSelected ? .textColor1 : .textColor2)
	  }
   }
}
