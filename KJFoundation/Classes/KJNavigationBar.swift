//
//  KJNavigationBar.swift
//  KJFoundation
//
//  Created by Kenji on 13/2/17.
//  Copyright © 2017 DevLander. All rights reserved.
//
//  A NavigationBar which support title text, title image, sub title and tap on subtitle
//

import UIKit


protocol KJNavigationBarDelegate {
  func navigationBarDidTappedOnTitle(navigationBar: KJNavigationBar)
}

extension KJNavigationBarDelegate {
  func navigationBarDidTappedOnTitle(navigationBar: KJNavigationBar) {
    print("KJNavigationBarDelegate: did tapped on title")
  }
}

class KJNavigationBar: UINavigationBar {
  
  var imvTitle: UIImageView!
  
  var lblTitle: UILabel!
  var lblSubTitle: UILabel!
  var isShowSubTitle: Bool = false
  
  var btnTitle: UIButton!
  
  var kjDelegate: KJNavigationBarDelegate?
  
  private var _isInitializedSubViews = false
  private var _defaultTitleFrame: CGRect = CGRect.zero
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.initSubViews()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.initSubViews()
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.initSubViews()
  }
  
  func initSubViews() {
    if _isInitializedSubViews {
      return
    }
    
    _isInitializedSubViews = true
    
    // background color
    self.tintColor = UIColor.white
    self.barTintColor = UIColor.blue
    self.isTranslucent = false
    let bounds = UIScreen.main.bounds
    let width = bounds.size.width - 128
    let height = CGFloat(40)
    let x = (bounds.size.width - width) / 2.0
    let y = (44 - height) / 2.0
    _defaultTitleFrame = CGRect(x: x, y: y, width: width, height: height)
    
    // title
    self.lblTitle = UILabel()
    self.lblTitle.isHidden = true
    self.lblTitle.textColor = UIColor(hex: "0xFDFDFD")
    self.lblTitle.backgroundColor = UIColor(hex: "000000", alpha: 0.0)
    self.lblTitle.font = UIFont.systemFont(ofSize: 20)
    self.lblTitle.textAlignment = .center
    self.lblTitle.minimumScaleFactor = 0.85
    self.lblTitle.adjustsFontSizeToFitWidth = true
    self.lblTitle.frame = _defaultTitleFrame
    self.addSubview(self.lblTitle)
    
    // subtitle
    self.lblSubTitle = UILabel()
    self.lblSubTitle.isHidden = true
    self.lblSubTitle.textColor = UIColor(hex: "0xfdfdfd")
    self.lblSubTitle.backgroundColor = UIColor(hex: "000000", alpha: 0.0)
    self.lblSubTitle.font = UIFont.systemFont(ofSize: 20)
    self.lblSubTitle.textAlignment = .center
    self.lblSubTitle.minimumScaleFactor = 0.85
    self.lblSubTitle.adjustsFontSizeToFitWidth = true
    self.lblSubTitle.frame = _defaultTitleFrame
    self.addSubview(self.lblSubTitle)
    
    // image view
    self.imvTitle = UIImageView()
    self.imvTitle.isHidden = true
    self.imvTitle.contentMode = .scaleAspectFill
    self.imvTitle.clipsToBounds = true
    self.imvTitle.frame = _defaultTitleFrame
    self.addSubview(self.imvTitle)
    
    // title button
    self.btnTitle = UIButton(type: .custom)
    self.btnTitle.setTitle("", for: .normal)
    self.btnTitle.addTarget(self, action: #selector(btnTitleDidTapped), for: .touchUpInside)
    self.btnTitle.frame = _defaultTitleFrame
    self.addSubview(self.btnTitle)
  }
  
  func btnTitleDidTapped(_ sender: Any) {
    self.kjDelegate?.navigationBarDidTappedOnTitle(navigationBar: self)
  }
  
  func setNavigationBarBackgroundColor(color: UIColor) {
    self.barTintColor = color
    self.isTranslucent = false
  }
  
  func setNavigationBarTitleText(text: String) {
    self.imvTitle.isHidden = true
    self.lblTitle.isHidden = false
    self.lblTitle.text = text
  }
  
  func setNavigationBarTitleImage(image: UIImage) {
    self.imvTitle.isHidden = false
    self.lblTitle.isHidden = true
    self.imvTitle.image = image
  }
  
  func setNavigationBarShowSubTitle(show: Bool) {
    
    if self.isShowSubTitle == show {
      return
    }
    
    self.isShowSubTitle = show
    
    if self.isShowSubTitle == true {
      self.lblSubTitle.isHidden = false
      
      var titleFrame = _defaultTitleFrame
      titleFrame.origin.y = 0
      titleFrame.size.height = 21
      self.lblTitle.frame = titleFrame
      self.lblTitle.font = UIFont.systemFont(ofSize: 18)
      
      var subTitleFrame = titleFrame
      subTitleFrame.origin.y = titleFrame.origin.y + titleFrame.size.height
      subTitleFrame.size.height = 21
      self.lblSubTitle.frame = subTitleFrame
      self.lblSubTitle.font = UIFont.systemFont(ofSize: 14)
    }
    else {
      self.lblSubTitle.isHidden = true
      
      self.lblTitle.frame = _defaultTitleFrame
      self.lblTitle.font = UIFont.systemFont(ofSize: 24)
    }
  }
  
  func setNavigationBarSubTitleText(text: String) {
    self.lblSubTitle.text = text
  }
}

