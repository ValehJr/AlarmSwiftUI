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
   }

   func deleteAlarm(at index: Int) {
	  if index < alarms.count {
		 alarms.remove(at: index)
		 saveAlarms()
	  } else {
		 print("Error: Attempted to delete alarm at an invalid index \(index).")
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

   func filterAlarmsByTime() -> [Alarm] {
	  return alarms.sorted { $0.time < $1.time }
   }

   private func getDocumentsDirectory() -> URL {
	  return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
   }
}
