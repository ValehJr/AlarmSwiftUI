//
//  ContentView.swift
//  AlarmSwiftUI
//
//  Created by Valeh Ismayilov on 11.09.24.
//

import SwiftUI
import SwiftData

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
			 case .alarm:
				AlarmView()
				   .transition(.blurReplace)
			 case .stopwatch:
				StopwatchView()
				   .modelContainer(for: Lap.self, inMemory: true)
				   .transition(.blurReplace)
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
