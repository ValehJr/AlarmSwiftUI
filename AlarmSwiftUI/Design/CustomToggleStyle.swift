//
//  CustomToggleStyle.swift
//  AlarmSwiftUI
//
//  Created by Valeh Ismayilov on 13.09.24.
//

import SwiftUI

struct CustomToggleStyle: ToggleStyle {
   func makeBody(configuration: Configuration) -> some View {
	  HStack {
		 configuration.label

		 ZStack {
			if configuration.isOn {
			   LinearGradient(gradient: Gradient(colors: [Color.gradientColor1, Color.gradientColor2]), startPoint: .top, endPoint: .bottom)
				  .clipShape(RoundedRectangle(cornerRadius: 30))
				  .frame(width: 70, height: 40)
				  .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 4)
			} else {
			   LinearGradient(gradient: Gradient(colors: [Color.shadow2, Color.background,Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
				  .clipShape(RoundedRectangle(cornerRadius: 30))
				  .frame(width: 70, height: 40)
				  .shadow(color: .white, radius: 1, x: -1, y: -1)
				  .shadow(color: .shadow, radius: 3, x: 3, y: 3)
				  .overlay(
					 RoundedRectangle(cornerRadius: 30)
						.stroke(Color.white.opacity(0.6), lineWidth: 1)
						.shadow(color: Color.white.opacity(0.8), radius: 1, x: -1, y: 0)
				  )
			}//else

			Circle()
			   .fill(Color.background.opacity(1))
			   .frame(width: 34, height: 34)
			   .offset(x: configuration.isOn ? 14 : -14)
			   .animation(.easeInOut(duration: 0.3), value: configuration.isOn)
			   .shadow(color: .black.opacity(0.1), radius: 5, x: 2, y: 2)
		 }//
		 .onTapGesture {
			configuration.isOn.toggle()
		 }
	  }//H
   }
}
