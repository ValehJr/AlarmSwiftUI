//
//  AlarmStore.swift
//  AlarmSwiftUI
//
//  Created by Valeh Ismayilov on 16.09.24.
//

import Foundation
import SwiftUI
import Combine

class AlarmStore: ObservableObject {
   @Published var alarms: [Alarm] = []
   private let fileName = "alarms.json"

   init() {
	  loadAlarms()
   }

   func addAlarm(_ alarm: Alarm) {
	  alarms.append(alarm)
	  alarms = filterAlarmsByTime()
	  print("Added alarm: \(alarm)")
	  saveAlarms()
	  NotificationManager.shared.scheduleAlarm(alarm: alarm)
	  NotificationManager.shared.scheduleAlarmNotification(alarm: alarm)
   }

   func deleteAlarm(at index: Int) {
	  if index < alarms.count {
		 let removedAlarm = alarms[index]
		 alarms.remove(at: index)
		 saveAlarms()
		 NotificationManager.shared.cancelAlarm(for: removedAlarm)
		 NotificationManager.shared.cancelNotification(for: removedAlarm)
	  } else {
		 print("Error: Attempted to delete alarm at an invalid index \(index).")
	  }
   }

   func editAlarm(_ updatedAlarm: Alarm, at index: Int) {
	  if index < alarms.count {
		 alarms[index] = updatedAlarm
		 alarms = filterAlarmsByTime()
		 print("Edited alarm: \(updatedAlarm)")
		 saveAlarms()
		 toggleAlarm(updatedAlarm)
	  } else {
		 print("Error: Attempted to edit alarm at an invalid index \(index).")
	  }
   }


   func saveAlarms() {
	  if let encoded = try? JSONEncoder().encode(alarms) {
		 let url = getDocumentsDirectory().appendingPathComponent(fileName)
		 try? encoded.write(to: url)
		 self.loadAlarms()
	  }
   }

   func loadAlarms() {
	  let url = getDocumentsDirectory().appendingPathComponent(fileName)
	  if let data = try? Data(contentsOf: url) {
		 if let decoded = try? JSONDecoder().decode([Alarm].self, from: data) {
			alarms = decoded
			alarms = filterAlarmsByTime()
		 } else {
			print("Failed to decode alarms.")
		 }
	  } else {
		 print("No alarms file found.")
	  }
   }

   func toggleAlarm(_ alarm: Alarm) {
	  if alarm.isOn {
		 NotificationManager.shared.scheduleAlarm(alarm: alarm)
		 NotificationManager.shared.scheduleAlarmNotification(alarm: alarm)
	  } else {
		 NotificationManager.shared.cancelAlarm(for: alarm)
		 NotificationManager.shared.cancelNotification(for: alarm)
	  }
	  saveAlarms()
   }

   func filterAlarmsByTime() -> [Alarm] {
	  return alarms.sorted { $0.time < $1.time }
   }

   private func getDocumentsDirectory() -> URL {
	  return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
   }
}
