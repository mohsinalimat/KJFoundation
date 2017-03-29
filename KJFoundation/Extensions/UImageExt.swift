//
//  UImageExt.swift
//  KJFoundation
//
//  Created by Kenji on 16/1/17.
//  Copyright © 2017 DevLander. All rights reserved.
//

import UIKit

extension UIImage {

  static func fromColor(color: UIColor, size: CGSize? = nil, cornerRadius: Float? = nil) -> UIImage? {
    
    var rect = CGRect(x: 0, y: 0, width: 1, height: 1)
    if size != nil {
      rect.size.width = size!.width
      rect.size.height = size!.height
    }
    
    UIGraphicsBeginImageContext(rect.size)
    guard let context = UIGraphicsGetCurrentContext() else {
      return nil
    }
    
    context.setFillColor(color.cgColor)
    context.fill(rect)
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    let radius = CGFloat(cornerRadius ?? 0)
    
    // return image if radius is 0
    if radius == 0 {
      return image
    }
    
    // create rounded image
    UIGraphicsBeginImageContext(rect.size)
    
    UIBezierPath(roundedRect: rect, cornerRadius: radius).addClip()
    image!.draw(in: rect)
    let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
    
    UIGraphicsEndImageContext()
    return roundedImage
  }
  
  /**
   Rotate the image in radians
   
   - parameter image: input image
   - parameter degrees: angle in degrees
   */
  static func rotateImageByRadians(_ image: UIImage, radians: CGFloat) -> UIImage? {
    return rotateImageByDegrees(image, degrees: degreesFromRadians(radians))
  }
  
  /**
   Rotate the image in degrees
   
   - parameter image: input image
   - parameter degrees: angle in degrees
   */
  static func rotateImageByDegrees(_ image: UIImage, degrees: CGFloat) -> UIImage? {
    let rotatedViewBox = UIView(frame: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
    let transform = CGAffineTransform.init(rotationAngle: radiansFromDegrees(degrees))
    rotatedViewBox.transform = transform
    let rotatedSize = rotatedViewBox.frame.size
    
    UIGraphicsBeginImageContext(rotatedSize)
    guard let context = UIGraphicsGetCurrentContext() else {
      UIGraphicsEndImageContext();
      return nil
    }
    
    context.translateBy(x: rotatedSize.width/2, y: rotatedSize.height/2)
    context.rotate(by: radiansFromDegrees(degrees))
    context.scaleBy(x: 1.0, y: -1.0)
    let imageRect = CGRect(x: -image.size.width/2.0, y: -image.size.height/2.0, width: image.size.width, height: image.size.height)
    if let cgImage = image.cgImage {
      context.draw(cgImage, in: imageRect)
    }
    
    let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return rotatedImage
  }
  
  /**
   Crop the image
   
   - parameter image:    input image
   - parameter cropRect: crop rect
   */
  static func cropImage(_ image: UIImage, rect: CGRect) -> UIImage? {
    if let croppedImageRef = image.cgImage!.cropping(to: rect) {
      let croppedImage = UIImage(cgImage: croppedImageRef)
      let newImage = UIImage(cgImage: croppedImage.cgImage!, scale: 1.0, orientation: image.imageOrientation)
      return newImage
    }
    return nil
  }
  
  // MARK: - Helpers
  
  static func radiansFromDegrees(_ degrees: CGFloat) -> CGFloat {
    return degrees * CGFloat(M_PI) / 180.0
  }
  
  static func degreesFromRadians(_ radians: CGFloat) -> CGFloat {
    return radians * 180.0 / CGFloat(M_PI)
  }
}
