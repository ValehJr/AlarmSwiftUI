//
//  ContentView.swift
//  AlarmSwiftUI
//
//  Created by Valeh Ismayilov on 11.09.24.
//

import SwiftUI
import SwiftData
import CoreData

struct ContentView: View {
   @State private var selectedScreen: Screen = .clock
   
    var body: some View {
	   VStack {
		  ScreenSelectionView(selectedScreen: $selectedScreen)
			 .padding(.bottom)
		  switch selectedScreen {
			 case .clock:
				ClockView()
				   .transition(.blurReplace)
				   .preferredColorScheme(.light)
			 case .alarm:
				AlarmView()
				   .transition(.blurReplace)
				   .preferredColorScheme(.light)
			 case .stopwatch:
				StopwatchView()
				   .modelContainer(for:  Lap.self)
				   .transition(.blurReplace)
				   .preferredColorScheme(.light)
		  }
		  Spacer()
	   }//V
	   .animation(.easeInOut(duration: 0.3), value: selectedScreen)
	   .padding(.top)

	}
}

#Preview {
    ContentView()
}
