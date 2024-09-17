//
//  CustomPickerView.swift
//  AlarmSwiftUI
//
//  Created by Valeh Ismayilov on 14.09.24.
//

import SwiftUI

struct CustomPickerView: View {
   @Binding var selectedIndex: Int
   var items: [String] = []

   var itemHeight: CGFloat = 60
   var menuHeightMultiplier: CGFloat = 3

   let repeatMultiplier = 20

   let initialRepetition = 10

   var body: some View {
	  let itemsCountAbove = Double(Int((menuHeightMultiplier - 1) / 2))

	  ScrollViewReader { scrollViewProxy in
		 ScrollView(.vertical) {
			LazyVStack(spacing: 0) {
			   ForEach(0 ..< items.count * repeatMultiplier, id: \.self) { index in
				  let realIndex = index % items.count
				  let category = items[realIndex]

				  Text("\(category)")
					 .font(realIndex == selectedIndex % items.count ? .custom("OpenSans-SemiBold", size: 24) : .custom("OpenSans-Medium", size: 24))
					 .frame(width: 100)
					 .background(
						RoundedRectangle(cornerRadius: 28)
						   .fill(realIndex == selectedIndex % items.count ? Color.background : Color.clear)
						   .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
						   .shadow(color: Color.white.opacity(1), radius: 5, x: -5, y: -5)
						   .frame(width: 70)
					 )
					 .foregroundColor(realIndex == selectedIndex % items.count ? .black : .textColor2)
					 .id(index)
					 .frame(height: itemHeight)
			   }
			}
			.scrollTargetLayout()
			.padding(.vertical, itemHeight * itemsCountAbove)
		 }
		 .onAppear {
			let targetIndex = initialRepetition * items.count
			selectedIndex = targetIndex % items.count
			scrollViewProxy.scrollTo(targetIndex, anchor: .center)
		 }
		 .scrollPosition(id: Binding(
			get: {
			   selectedIndex as Int?
			},
			set: { newIndex in
			   if let newIndex = newIndex {
				  let itemCount = items.count
				  selectedIndex = (newIndex + itemCount) % itemCount
			   }
			}
		 ), anchor: .center)
		 .frame(height: itemHeight * (itemsCountAbove * 2 + 1))
		 .padding(.vertical, (Int(menuHeightMultiplier) % 2 == 0) ? itemHeight * 0.5 : 0)
		 .scrollTargetBehavior(.viewAligned)
		 .scrollIndicators(.hidden)
	  }
   }
}
