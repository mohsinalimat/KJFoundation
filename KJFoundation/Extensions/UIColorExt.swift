//
//  UIColorExt.swift
//  KJFoundation
//
//  Created by Kenji on 17/1/17.
//  Copyright © 2017 DevLander. All rights reserved.
//

import UIKit

extension UIColor {
  
  /**
   init UIColor with hex String without prefix: RED-GREEN-BLUE, alpha = 1.0
   
   - parameter hexString: hex value, e.g: ffffff
   
   - returns: UIColor
   */
  convenience init(hex: String) {
    self.init(hex: hex, alpha: 1.0)
  }

  /**
   init UIColor with hex String without prefix: RED-GREEN-BLUE
   
   - parameter hexString: hex value, e.g: ffffff
   - parameter alpha:     alpha channel
   
   - returns: UIColor
   */
  convenience init(hex: String, alpha: Float) {
    
    let scanner = Scanner(string: hex)
    var value: UInt32 = 0
    scanner.scanHexInt32(&value)
    
    let r = UInt8(truncatingBitPattern: (value >> 16))
    let g = UInt8(truncatingBitPattern: (value >> 8))
    let b = UInt8(truncatingBitPattern: (value))
    
    let red = CGFloat(r) / 255.0
    let green = CGFloat(g) / 255.0
    let blue = CGFloat(b) / 255.0
    
    self.init(red: red, green: green, blue: blue, alpha: CGFloat(alpha))
  }
  
  /**
   Create a ligher color
   */
  func lighter(by percentage: CGFloat = 30.0) -> UIColor {
    return self.adjustBrightness(by: abs(percentage))
  }
  
  /**
   Create a darker color
   */
  func darker(by percentage: CGFloat = 30.0) -> UIColor {
    return self.adjustBrightness(by: -abs(percentage))
  }
  
  /**
   Try to increase brightness or decrease saturation
   */
  func adjustBrightness(by percentage: CGFloat = 30.0) -> UIColor {
    var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
    if self.getHue(&h, saturation: &s, brightness: &b, alpha: &a) {
      if b < 1.0 {
        let newB: CGFloat = max(min(b + (percentage/100.0)*b, 1.0), 0,0)
        return UIColor(hue: h, saturation: s, brightness: newB, alpha: a)
      } else {
        let newS: CGFloat = min(max(s - (percentage/100.0)*s, 0.0), 1.0)
        return UIColor(hue: h, saturation: newS, brightness: b, alpha: a)
      }
    }
    return UIColor(cgColor: self.cgColor)
  }
  
  /**
   Mix two color and to get the average
   */
  func mixedWithColor(_ color: UIColor, percentage: CGFloat = 50.0) -> UIColor {
    let target: CGFloat = max(min(percentage, 100), 0)
    let source: CGFloat = 100 - target
    var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
    if self.getRed(&r, green: &g, blue: &b, alpha: &a) {
      var r1: CGFloat = 0, g1: CGFloat = 0, b1: CGFloat = 0, a1: CGFloat = 0
      if color.getRed(&r1, green: &g1, blue: &b1, alpha: &a1) {
        let newR: CGFloat = (r*source + r1*target) / 100
        let newG: CGFloat = (g*source + g1*target) / 100
        let newB: CGFloat = (b*source + b1*target) / 100
        return UIColor(red: newR, green: newG, blue: newB, alpha: a)
      }
      return UIColor(cgColor: self.cgColor)
    }
    return UIColor(cgColor: self.cgColor)
  }
}
