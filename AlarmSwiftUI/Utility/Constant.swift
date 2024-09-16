//
//  Constant.swift
//  AlarmSwiftUI
//
//  Created by Valeh Ismayilov on 12.09.24.
//

import Foundation
import SwiftUI

let rowSpacing:CGFloat = 10
var gridLayout: [GridItem] {
   return Array(repeating: GridItem(.flexible(),spacing: rowSpacing), count: 2)
}
let gradientColor = LinearGradient(gradient: Gradient(colors: [.gradientColor1,.gradientColor2]), startPoint: .topLeading, endPoint: .bottomTrailing)
var linearGradientC = LinearGradient(gradient: Gradient(colors: [.clear,.clear]), startPoint: .topLeading, endPoint: .bottomTrailing)
