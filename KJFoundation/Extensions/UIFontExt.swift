//
//  UIFontExt.swift
//  KJFoundation
//
//  Created by Kenji on 14/2/17.
//  Copyright © 2017 DevLander. All rights reserved.
//

import UIKit


extension UIFont {
  
  func sizeOf(string: String, constrainedToWidth width: CGFloat) -> CGSize {
    return NSString(string: string).boundingRect(with: CGSize(width: width, height: 9999_9999), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName : self], context: nil).size
  }
  
}
