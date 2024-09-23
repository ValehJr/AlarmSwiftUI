//
//  Alarm.swift
//  AlarmSwiftUI
//
//  Created by Valeh Ismayilov on 16.09.24.
//

import Foundation

struct Alarm: Identifiable, Codable, Equatable {
   var id = UUID()
   var time: String
   var days: [String]
   var isOn:Bool
   init(id: UUID = UUID(), time: String, days: [String],isOn: Bool) {
	  self.id = id
	  self.time = time
	  self.days = days
	  self.isOn = isOn
   }
}
