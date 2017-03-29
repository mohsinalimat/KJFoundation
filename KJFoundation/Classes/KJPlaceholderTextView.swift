//
//  KJPlaceholderTextView.swift
//  KJFoundation
//
//  Created by Kenji on 19/1/17.
//  Copyright © 2017 DevLander. All rights reserved.
//

import UIKit

class KJPlaceholderTextView: UITextView {
  
  lazy var placeholder: String = {
    return ""
  }()

  lazy var placeholerColor: UIColor = {
    return UIColor.gray
  }()
  
  internal lazy var placeholderLabel: UILabel = {
    var label = UILabel(frame: CGRect(x: 8, y: 8, width: self.bounds.size.width-16, height: 0))
    
    label.numberOfLines = 0
    label.font = self.font
    label.backgroundColor = UIColor.clear
    label.textColor = self.placeholerColor
    label.alpha = 0.0
    self.addSubview(label)
    
    return label
  }()
  
  deinit {
    NotificationCenter.default.removeObserver(self, name: Notification.Name.UITextViewTextDidChange, object: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override init(frame: CGRect, textContainer: NSTextContainer?) {
    super.init(frame: frame, textContainer: textContainer)
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    NotificationCenter.default.addObserver(self, selector: #selector(handleTextChanged), name: Notification.Name.UITextViewTextDidChange, object: nil)
  }
  
  func handleTextChanged(notice: Notification) {
    if self.placeholder.characters.count == 0 {
      return
    }
    
    UIView.animate(withDuration: 0.35) { 
      if self.text.characters.count == 0 {
        self.placeholderLabel.alpha = 1.0
      } else {
        self.placeholderLabel.alpha = 0.0
      }
    }
    
    self.setNeedsDisplay()
  }
  
  override func draw(_ rect: CGRect) {
    
    if self.placeholder.characters.count > 0 {
      
      self.placeholderLabel.text = self.placeholder
      self.placeholderLabel.sizeToFit()
      self.sendSubview(toBack: self.placeholderLabel)
      
      if self.text.characters.count == 0 {
        self.placeholderLabel.alpha = 1.0
      }
    }
    
    super.draw(rect)
  }
}
