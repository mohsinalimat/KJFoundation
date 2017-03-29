//
//  KJTimeOutOperation.swift
//  KJFoundation
//
//  Created by Kenji on 19/2/17.
//  Copyright © 2017 DevLander. All rights reserved.
//
//  To adopt KJTimeOutOperation:
//  - call time out at the beginning of main(): startTimeOutBlock()
//  - add wait loop to the end of main(): while !self.isJobDone { usleep(1000_000) }


import Foundation


protocol KJTimeOutOperation : class {
  
  static var finishedMessage: Notification.Name { get }
  
  var timeOut: Double { get set }
  var isJobDone: Bool { get set }
  
  init(timeOut: Double)
  
  func startTimeOutBlock()
  func postFinishedNotification(isSuccess: Bool, data: Any?)
}


extension KJTimeOutOperation where Self : Operation {
  
  init(timeOut: Double) {
    self.init()
    self.timeOut = timeOut
  }
  
  func startTimeOutBlock() {
    if self.timeOut <= 0 {
      self.isJobDone = true
      return
    }
    DispatchQueue.global().asyncAfter(deadline: .now() + self.timeOut) {
      self.isJobDone = true
    }
  }
  
  func postFinishedNotification(isSuccess: Bool, data: Any?) {
    DispatchQueue.main.async(execute: {
      var userInfo: [String : Any] = ["success" : isSuccess]
      if let _data = data { userInfo["data"] = _data }
      NotificationCenter.default.post(name: Self.finishedMessage, object: nil, userInfo: userInfo)
    })
  }
  
}
