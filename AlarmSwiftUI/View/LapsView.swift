//
//  LapsView.swift
//  AlarmSwiftUI
//
//  Created by Valeh Ismayilov on 12.09.24.
//

import SwiftUI

struct LapsView: View {
   var lapNumber:Int
   var time:String

   var body: some View {
		 HStack {
			Text("Lap \(lapNumber)")
			   .font(.custom("OpenSans-Medium", size: 28))
			   .foregroundColor(.textColor1)
			Spacer()
			Text("\(time)")
			   .font(.custom("OpenSans-Medium", size: 28))
			   .foregroundColor(.textColor1)
		 }
		 .padding(.horizontal)
		 .padding(.vertical,2)

   }

}

#Preview {
   return LapsView(lapNumber: 2, time: "time")
}
