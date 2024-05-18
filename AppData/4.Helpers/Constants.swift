//
//  Constant.swift
//  BaseApp
//
//  Created by namnl on 24/04/2023.
//

import Foundation
import UIKit
import Printer

let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_HEIGHT = UIScreen.main.bounds.height
let bluetoothPrinterManager = BluetoothPrinterManager()
struct myColor {

    static let CN_1_TIM = UIColor(hex: "#6B49A1")
    static let CN_2_XANH = UIColor(hex: "#8284DA")
    static let CN_3_TIM = UIColor(hex: "#B78CD8")
    static let CN_4_CAM = UIColor(hex: "#F09CAD")
    static let CN_5_HONG = UIColor(hex: "#F4BEEE")
    static let CN_6_BLACK = UIColor(hex: "#000000")
    static let CN_7_NEN = UIColor(hex: "#FAFAFA")
    
}
struct myCornerRadius {
    static let c5 = 5.0
    static let c10 = 10.0
    static let c20 = 20.0
}

enum C: Any {
    enum Screen {
        static let WIDTH = UIScreen.main.bounds.width
        static let HEIGHT = UIScreen.main.bounds.height
    }
}
