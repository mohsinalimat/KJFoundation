//
//  UIViewControllerExt.swift
//  KJFoundation
//
//  Created by Kenji on 22/2/17.
//  Copyright © 2017 DevLander. All rights reserved.
//

import UIKit

extension UIViewController {
  
  var isVisibled: Bool {
    return self.isViewLoaded && self.view.window != nil && self.view.isHidden != true
  }

}
