//
//  KJGradientView.swift
//  KJFoundation
//
//  Created by Kenji on 19/1/17.
//  Copyright © 2017 DevLander. All rights reserved.
//

import UIKit

class KJGradientView: UIView {

  internal var gradientLayer: CAGradientLayer?
  
  override func layoutSubviews() {
    super.layoutSubviews()
  }
  
  override func layoutSublayers(of layer: CALayer) {
    super.layoutSublayers(of: layer)
    self.gradientLayer?.frame = self.bounds
  }
  
  func setGradient(with colors: [UIColor], on locations: [CGFloat]) {
    self.backgroundColor = UIColor.clear
    
    if self.gradientLayer == nil {
      self.gradientLayer = CAGradientLayer()
    }
    
    let layer = self.gradientLayer!
    layer.colors = colors.map({ (color) -> CGColor in
      return color.cgColor
    })
    layer.locations  = locations.map({ (float) -> NSNumber in
      return NSNumber(value: Float(float))
    })
    
    layer.frame = self.bounds
    self.layer.insertSublayer(layer, at: 0)
  }
  
}
