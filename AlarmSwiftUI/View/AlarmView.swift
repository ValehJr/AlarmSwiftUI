//
//  AlarmView.swift
//  AlarmSwiftUI
//
//  Created by Valeh Ismayilov on 12.09.24.
//

import SwiftUI

struct AlarmView: View {
   var body: some View {
	  ZStack {
		 VStack {
			ScrollView {
			   ForEach(0..<10) { _ in
				  SingleAlarmView()
					 .padding()
			   }
			   .padding(.bottom, 60)
			}
			.frame(maxWidth: .infinity,maxHeight: .infinity)
			.ignoresSafeArea(.all)
			Spacer()
		 } // VStack
		 .padding(.top)

		 VStack {
			Spacer()
			Button(action: {
			   // Your action here
			}, label: {
			   AlarmPlusButton()
			}) // Button
		 } // VStack for Button

	  } // ZStack

   }
}

#Preview {
    AlarmView()
	  .background(Color.background)
}
