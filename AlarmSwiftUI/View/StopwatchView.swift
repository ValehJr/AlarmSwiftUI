//
//  StopwatchView.swift
//  AlarmSwiftUI
//
//  Created by Valeh Ismayilov on 12.09.24.
//

import SwiftUI
import SwiftData

struct StopwatchView: View {

   @State var viewModel = StopwatchViewModel()
   @Environment(\.modelContext) private var context

   var body: some View {
	  VStack {
		 ZStack {
			StopwatchCapsule()

			Text(viewModel.timeString(from: viewModel.elapsedTime))
			   .font(.custom("OpenSans-SemiBold", size: 42))
			   .foregroundColor(.textColor1)
		 }//Z
		 .padding(.vertical)

		 if !viewModel.isRunning && !viewModel.isPaused {
			Button(action: {
			   viewModel.start()
			}, label: {
			   ZStack {
				  Capsule()
					 .fill(.start)

				  Text("Start")
					 .font(.custom("OpenSans-Medium", size: 28))
					 .foregroundStyle(.white)

			   }//Z
			   .frame(maxWidth: 320, maxHeight: 50)
			})//Button
		 } else if viewModel.isRunning {
			// Show Lap and Stop buttons
			HStack {
			   Button(action: {
				  viewModel.lap(context: context)
			   }, label: {
				  ZStack {
					 Capsule()
						.fill(.lap)

					 Text("Lap")
						.font(.custom("OpenSans-Medium", size: 28))
						.foregroundStyle(.black)

				  }//Z
			   })//Button
			   .frame(maxWidth: 150)

			   Spacer()

			   Button(action: {
				  viewModel.stop()
			   }, label: {
				  ZStack {
					 Capsule()
						.fill(.stop)

					 Text("Stop")
						.font(.custom("OpenSans-Medium", size: 28))
						.foregroundStyle(.white)

				  }//Z
			   })//Button
			   .frame(maxWidth: 150)
			}//H
			.frame(maxWidth: 320, maxHeight: 50)
		 } else if viewModel.isPaused {
			HStack {
			   Button(action: {
				  viewModel.reset()
			   }, label: {
				  ZStack {
					 Capsule()
						.fill(.lap)

					 Text("Reset")
						.font(.custom("OpenSans-Medium", size: 28))
						.foregroundStyle(.black)

				  }//Z
			   })//Button
			   .frame(maxWidth: 150)

			   Spacer()

			   Button(action: {
				  viewModel.resume()
			   }, label: {
				  ZStack {
					 Capsule()
						.fill(.start)

					 Text("Resume")
						.font(.custom("OpenSans-Medium", size: 28))
						.foregroundStyle(.white)

				  }//Z
			   })//Button
			   .frame(maxWidth: 150)
			}//H
			.frame(maxWidth: 320, maxHeight: 50)
		 }//elseif
		 ScrollView {
			ForEach(viewModel.laps, id: \.id) { lap in
			   LapsView(lapNumber: lap.lapNumber, time: viewModel.timeString(from: lap.elapsedTime))
			}
		 }
		 .padding(.horizontal)
		 .padding(.vertical,5)

	  }//V
   }
}

#Preview {
   StopwatchView()
}
