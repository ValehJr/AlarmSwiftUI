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
   var activeAlarms = [UUID: Bool]()

   func requestPermission() {
	  let hasRequestedPermission = UserDefaults.standard.bool(forKey: "hasRequestedNotificationPermission")

	  if !hasRequestedPermission {
		 UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
			if granted {
			   print("Permission granted")
			} else if let error = error {
			   print("Error: \(error.localizedDescription)")
			}
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

   func scheduleAlarmNotification(alarm: Alarm) {
	  guard alarm.isOn else {
		 print("Alarm is off, no notification will be scheduled.")
		 return
	  }

	  activeAlarms[alarm.id] = true

	  let content = UNMutableNotificationContent()
	  content.title = "Alarm"
	  content.body = "Your alarm is ringing!"
	  content.sound = .default

	  if activeAlarms[alarm.id] == true {
		 if !alarm.days.isEmpty {
			for dayString in alarm.days {
			   if let day = dayStringToInt[dayString], let triggerDate = convertTimeStringToDate(alarm.time, on: day) {
				  let dateComponents = Calendar.current.dateComponents([.hour, .minute, .weekday], from: triggerDate)
				  let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

				  let request = UNNotificationRequest(identifier: "\(alarm.id.uuidString)_\(day)", content: content, trigger: trigger)
				  UNUserNotificationCenter.current().add(request) { error in
					 if let error = error {
						print("Error scheduling notification for day \(day): \(error.localizedDescription)")
					 }
				  }
			   }
			}
		 } else {
			if let triggerDate = convertTimeStringToDate(alarm.time) {
			   let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: triggerDate)
			   let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

			   let request = UNNotificationRequest(identifier: alarm.id.uuidString, content: content, trigger: trigger)
			   UNUserNotificationCenter.current().add(request) { error in
				  if let error = error {
					 print("Error scheduling one-time notification: \(error.localizedDescription)")
				  }
			   }
			}
		 }
	  }
   }

   //   func printPendingNotifications() {
   //	  UNUserNotificationCenter.current().getPendingNotificationRequests { notifications in
   //		 print("Pending Notifications: \(notifications.map { $0.identifier })")
   //	  }
   //   }


   func cancelNotification(for alarm: Alarm) {
	  var identifiersToCancel = [alarm.id.uuidString] // One-time alarm ID
	  activeAlarms[alarm.id] = false

	  // If the alarm has specific days, add the day-specific IDs to the list
	  if !alarm.days.isEmpty {
		 for day in alarm.days {
			// Use the integer representation for the day
			if let dayInt = dayStringToInt[day] {
			   let identifier = "\(alarm.id.uuidString)_\(dayInt)"
			   identifiersToCancel.append(identifier)
			}
		 }
	  }

	  //	  	print("Identifiers to cancel: \(identifiersToCancel)")
	  //
	  //	  	print("Before canceling notifications for alarm \(alarm.id.uuidString):")
	  //		printPendingNotifications()

	  // Cancel all pending notifications
	  UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiersToCancel)

	  UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: identifiersToCancel)
	  //print("Cancelled notifications for alarm \(alarm.id.uuidString) on days: \(alarm.days)")
	  //	  DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // Give it a second to cancel
	  //		 print("After canceling notifications for alarm \(alarm.id.uuidString):")
	  //		 self.printPendingNotifications()
	  //	  }
   }

   func playSoundIfAlarmIsActive(_ alarm: Alarm) {
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
		 //print("Playing alarm sound.")
	  } catch {
		 print("Error playing sound: \(error.localizedDescription)")
	  }
   }


   func cancelAlarm(for alarm: Alarm) {
	  activeAlarms[alarm.id] = false
	  //print("Cancelled alarm \(alarm.id.uuidString).")
   }
}
