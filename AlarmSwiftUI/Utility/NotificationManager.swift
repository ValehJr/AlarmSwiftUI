//
//  NotificationManager.swift
//  AlarmSwiftUI
//
//  Created by Valeh Ismayilov on 17.09.24.
//

import Foundation
import AVFoundation
import UserNotifications

class NotificationManager {

   static let shared = NotificationManager()

   private init() {}

   var audioPlayer: AVAudioPlayer?
   var activeAlarms = [UUID: Bool]() // Dictionary to track active alarms by their ID

   func requestPermission() {
	  let hasRequestedPermission = UserDefaults.standard.bool(forKey: "hasRequestedNotificationPermission")

	  if !hasRequestedPermission {
		 UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
			if granted {
			   print("Permission granted")
			} else if let error = error {
			   print("Error: \(error.localizedDescription)")
			}
			// Store in UserDefaults that permission has been requested
			UserDefaults.standard.set(true, forKey: "hasRequestedNotificationPermission")
		 }
	  } else {
		 print("Notification permission has already been requested.")
	  }
   }
   

   func convertTimeStringToDate(_ timeString: String, on weekday: Int? = nil) -> Date? {
	  let formatter = DateFormatter()
	  formatter.dateFormat = "HH:mm"

	  if let time = formatter.date(from: timeString) {
		 let calendar = Calendar.current
		 var components = calendar.dateComponents([.hour, .minute], from: time)

		 if let weekday = weekday {
			components.weekday = weekday
		 }

		 return calendar.nextDate(after: Date(), matching: components, matchingPolicy: .nextTime)
	  }

	  return nil
   }

   func scheduleAlarm(alarm: Alarm) {
	  guard alarm.isOn else {
		 print("Alarm is off, no sound will be played.")
		 return
	  }

	  // Set the alarm as active
	  activeAlarms[alarm.id] = true

	  if !alarm.days.isEmpty {
		 // Schedule sound playback for each selected day
		 for dayString in alarm.days {
			if let day = dayStringToInt[dayString], let triggerDate = convertTimeStringToDate(alarm.time, on: day) {
			   let timerInterval = triggerDate.timeIntervalSinceNow
			   if timerInterval > 0 {
				  DispatchQueue.main.asyncAfter(deadline: .now() + timerInterval) {
					 self.playSoundIfAlarmIsActive(alarm)
				  }
			   }
			}
		 }
	  } else {
		 // Schedule one-time sound playback
		 if let triggerDate = convertTimeStringToDate(alarm.time) {
			let timerInterval = triggerDate.timeIntervalSinceNow
			if timerInterval > 0 {
			   DispatchQueue.main.asyncAfter(deadline: .now() + timerInterval) {
				  self.playSoundIfAlarmIsActive(alarm)
			   }
			}
		 }
	  }
   }

   func playSoundIfAlarmIsActive(_ alarm: Alarm) {
	  // Check if the alarm is still active before playing the sound
	  if activeAlarms[alarm.id] == true {
		 playAlarmSound()
	  } else {
		 print("Alarm \(alarm.id.uuidString) was canceled before it triggered.")
	  }
   }

   func playAlarmSound() {
	  guard let soundURL = Bundle.main.url(forResource: "alarm", withExtension: "mp3") else {
		 print("Failed to locate the sound file.")
		 return
	  }

	  do {
		 audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
		 audioPlayer?.play()
		 print("Playing alarm sound.")
	  } catch {
		 print("Error playing sound: \(error.localizedDescription)")
	  }
   }

   func cancelAlarm(for alarm: Alarm) {
	  // Mark the alarm as inactive
	  activeAlarms[alarm.id] = false
	  print("Cancelled alarm \(alarm.id.uuidString).")
   }
}

