//
//  UIViewExt.swift
//  KJFoundation
//
//  Created by Kenji on 18/1/17.
//  Copyright © 2017 DevLander. All rights reserved.
//

import UIKit

extension UIView {
  
  func roundToCircle(borderWidth: CGFloat? = nil, borderColor: UIColor? = nil) {
    self.round(cornerRadius: self.frame.size.width/2.0, borderWidth: borderWidth, borderColor: borderColor)
  }

  func round(cornerRadius: CGFloat? = nil, borderWidth: CGFloat? = nil, borderColor: UIColor? = nil) {
    self.layoutIfNeeded()
    self.layer.masksToBounds = true
    self.layer.cornerRadius = cornerRadius ?? 0.0
    self.layer.borderWidth = borderWidth ?? 0.0
    self.layer.borderColor = borderColor?.cgColor ?? UIColor.clear.cgColor
  }
  
}
