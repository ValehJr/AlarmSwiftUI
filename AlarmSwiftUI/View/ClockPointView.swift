//
//  ClockPointView.swift
//  AlarmSwiftUI
//
//  Created by Valeh Ismayilov on 12.09.24.
//

import SwiftUI

struct ClockPointView: View {
   var body: some View {
	  Circle()
		 .fill(Color.round.opacity(0.8))
		 .frame(width: 6, height: 6)
   }
}
#Preview {
    ClockPointView()
}
