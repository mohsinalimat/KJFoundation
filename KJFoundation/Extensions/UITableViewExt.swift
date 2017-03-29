//
//  UITableViewExt.swift
//  KJFoundation
//
//  Created by Kenji on 13/3/17.
//  Copyright © 2017 DevLander. All rights reserved.
//

import UIKit

extension UITableView {

  func setBackgroundView(image: UIImage, coverColor: UIColor) {
    let bgView = UIImageView(image: image)
    bgView.contentMode = .scaleAspectFill
    
    let coverView = UIView(frame: bgView.bounds)
    coverView.backgroundColor = coverColor
    coverView.translatesAutoresizingMaskIntoConstraints = true
    coverView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    bgView.addSubview(coverView)
    
    self.backgroundView = bgView
  }
  
}
