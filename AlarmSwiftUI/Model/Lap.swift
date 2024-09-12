//
//  Lap.swift
//  AlarmSwiftUI
//
//  Created by Valeh Ismayilov on 12.09.24.
//

import Foundation
import SwiftData

@Model
class Lap {
   var id: UUID
   var time: Date
   var lapNumber: Int
   var elapsedTime: TimeInterval // Store the elapsed time for the lap

   init(time: Date, lapNumber: Int, elapsedTime: TimeInterval) {
	  self.id = UUID()
	  self.time = time
	  self.lapNumber = lapNumber
	  self.elapsedTime = elapsedTime
   }
}
