//
//  CirclesView.swift
//  AlarmSwiftUI
//
//  Created by Valeh Ismayilov on 12.09.24.
//

import SwiftUI

struct OuterCircle: View {
   var body: some View {
	  Circle()
		 .fill(LinearGradient(gradient: Gradient(colors: [Color.shadow.opacity(0.8), Color.white.opacity(1)]), startPoint: .topLeading, endPoint: .bottomTrailing))
		 .shadow(color: Color.black.opacity(0.2), radius: 5, x: 3, y: 3)
		 .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
   }
}

struct MiddleCircle: View {
   var body: some View {
	  Circle()
		 .fill(LinearGradient(gradient: Gradient(colors: [.backgroundColor2, .backgroundColor2, Color.shadow.opacity(0.8)]), startPoint: .topLeading, endPoint: .bottomTrailing))
		 .shadow(color: Color.black.opacity(0.2), radius: 5, x: 3, y: 3)
		 .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
		 .frame(maxWidth: 220, maxHeight: 220)
   }
}

struct InnerCircle: View {
   var body: some View {
	  Circle()
		 .fill(Color.backgroundColor2)
		 .frame(maxWidth: 130, maxHeight: 130)
   }
}

struct SmallCircle:View {
   var body: some View {
	  Circle()
		 .fill(Color.background)
		 .frame(maxWidth: 30,maxHeight: 30)
		 .shadow(color: Color.shadow.opacity(1), radius: 1, x: 0, y: 0)
		 .shadow(color: Color.black.opacity(0.1), radius: 2, x: 3, y: 3)
   }
}

struct GradientCircle:View {
   var body: some View {
	  Circle()
		 .fill(gradientColor)
		 .frame(maxWidth: 15,maxHeight: 15)
   }
}

struct MinuteTriangle: View {
   var body: some View {
	  Triangle()
		 .fill(LinearGradient(colors: [.gradientColor1,.gradientColor2], startPoint: .bottom, endPoint: .top))
		 .frame(width: 24,height: 87)
   }
}

struct HourTriangle:View {
   var body: some View {
	  Triangle()
		 .fill(LinearGradient(colors: [.gradientColor1,.gradientColor2], startPoint: .bottom, endPoint: .top))
		 .frame(width: 24,height: 63)
   }
}

struct SecondRectangle: View {
   var body: some View {
	  RoundedRectangle(cornerRadius: 28)
		 .fill(Color.gradientColor1)
		 .frame(width: 1.5,height: 90)
   }
}

struct TimeCapsule:View {
   var body: some View {
	  Capsule()
		 .fill(LinearGradient(gradient: Gradient(colors: [Color.shadow.opacity(0.8), Color.white.opacity(1)]), startPoint: .topLeading, endPoint: .bottomTrailing))
		 .shadow(color: Color.black.opacity(0.2), radius: 5, x: 3, y: 3)
		 .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
		 .frame(maxWidth: 200,maxHeight: 80)
   }
}

struct StopwatchCapsule:View {
   var body: some View {
	  Capsule()
		 .fill(Color.background)
		 .shadow(color: Color.black.opacity(0.2), radius: 5, x: 3, y: 3)
		 .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
		 .frame(maxWidth: 320, maxHeight: 60)
   }
}

struct AlarmRoundedRectangle:View {
   var body: some View {
	  RoundedRectangle(cornerRadius: 28)
		 .fill(Color.background)
		 .shadow(color: Color.black.opacity(0.2), radius: 10, x: 5, y: 5)
		 .shadow(color: Color.white.opacity(1), radius: 10, x: -5, y: -5)
		 .frame(maxWidth: 340,maxHeight: 120)
   }
}

struct AlarmPlusButton:View {
   var body: some View {
	  Image(systemName: "plus.circle.fill")
		 .resizable()
		 .scaledToFill()
		 .frame(width: 63,height: 63)
		 .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.gradientColor1,.gradientColor1.opacity(0.9),.gradientColor2]), startPoint: .topLeading, endPoint: .bottomTrailing))
		 .shadow(color: .shadow, radius: 2, x: 3, y: 3)
   }
}
struct WeekCapsule:View {
   var body: some View {
	  Capsule()
		 .fill(Color.background)
		 .shadow(color: Color.black.opacity(0.2), radius: 5, x: 3, y: 3)
		 .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
		 .frame(maxWidth: .infinity, maxHeight: 60)
   }
}
