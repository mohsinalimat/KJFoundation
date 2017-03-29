//
//  KJStoryboardInitable.swift
//  KJFoundation
//
//  Created by Kenji on 18/1/17.
//  Copyright © 2017 DevLander. All rights reserved.
//

import UIKit

/*
 UIViewController A which adopt this protocol must make sure that it has
 + Storyboard which name is classname. e.g: A.storyboard
 + ReuseIdentifier in the Storyboard above same as class name: e.g: reuse = "A"
 */

protocol KJStoryboardInitable: class {
  static func instanceFromStoryboard() -> UIViewController
}

extension KJStoryboardInitable where Self: UIViewController {
  static func instanceFromStoryboard() -> UIViewController {
    let className = NSStringFromClass(self).components(separatedBy: ".").last!
    return UIStoryboard(name: className, bundle: nil).instantiateViewController(withIdentifier: className)
  }
}
