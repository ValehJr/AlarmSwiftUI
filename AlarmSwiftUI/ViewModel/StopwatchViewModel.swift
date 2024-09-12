//
//  StopwatchViewModel.swift
//  AlarmSwiftUI
//
//  Created by Valeh Ismayilov on 12.09.24.
//

import SwiftUI
import SwiftData

@Observable
class StopwatchViewModel {
   var isRunning = false
   var isPaused = false
   var elapsedTime: TimeInterval = 0
   var laps: [Lap] = []
   private var timer: DispatchSourceTimer? = nil
   private var startTime: Date? = nil
   private var pausedTime: TimeInterval = 0
   private var currentLapNumber: Int = 0

   // Start the stopwatch
   func start() {
	  isRunning = true
	  isPaused = false
	  startTime = Date()
	  startTimer()
   }

   // Stop the stopwatch
   func stop() {
	  isRunning = false
	  isPaused = true
	  pausedTime = elapsedTime
	  timer?.cancel()
	  timer = nil
   }

   // Resume the stopwatch
   func resume() {
	  isRunning = true
	  isPaused = false
	  startTime = Date()
	  startTimer()
   }

   // Reset the stopwatch
   func reset() {
	  stop()
	  isPaused = false
	  elapsedTime = 0
	  pausedTime = 0
	  laps = []
   }

   // Lap function remains the same
   func lap(context: ModelContext) {
	  guard isRunning else { return }
	  let lapNumber = laps.count + 1
	  let lapTime = Date()
	  let lapElapsedTime = elapsedTime
	  let newLap = Lap(time: lapTime, lapNumber: lapNumber, elapsedTime: lapElapsedTime)
	  laps.append(newLap)
	  context.insert(newLap)

	  do {
		 try context.save()
	  } catch {
		 print("Failed to save lap: \(error)")
	  }
   }

   // Start a DispatchSourceTimer on a background queue
   private func startTimer() {
	  let queue = DispatchQueue(label: "com.stopwatch.timer", qos: .userInteractive)
	  timer = DispatchSource.makeTimerSource(queue: queue)
	  timer?.schedule(deadline: .now(), repeating: 0.01)

	  timer?.setEventHandler { [weak self] in
		 guard let self = self, let startTime = self.startTime else { return }
		 let currentTime = Date().timeIntervalSince(startTime)
		 let totalElapsedTime = self.pausedTime + currentTime

		 // Ensure that updates to the UI are done on the main thread
		 DispatchQueue.main.async {
			self.elapsedTime = totalElapsedTime
		 }
	  }

	  timer?.resume()
   }

   // Format the time as a string
   func timeString(from timeInterval: TimeInterval) -> String {
	  let hours = Int(timeInterval) / 3600
	  let minutes = (Int(timeInterval) % 3600) / 60
	  let seconds = Int(timeInterval) % 60
	  let milliseconds = Int((timeInterval.truncatingRemainder(dividingBy: 1)) * 100)

	  if hours > 0 {
		 return String(format: "%02d:%02d:%02d,%02d", hours, minutes, seconds, milliseconds)
	  } else {
		 return String(format: "%02d:%02d,%02d", minutes, seconds, milliseconds)
	  }
   }
}
