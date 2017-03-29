//
//  KJUtils.swift
//  KJFoundation
//
//  Created by Kenji on 17/1/17.
//  Copyright © 2017 DevLander. All rights reserved.
//

import UIKit


class KJUtils {
  
  static let instance = KJUtils()
  
  // MARK: - App
  
  static func getAppVersion() -> String {
    if let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
      return version
    }
    return "unknown"
  }
  
  static func getAppBuild() -> String {
    if let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String {
      return build
    }
    return "unknown"
  }
  
  static func getDeviceUUID() -> String {
    if let identifier = UIDevice.current.identifierForVendor {
      return identifier.uuidString
    } else {
      return ""
    }
  }
  
  static func getDocumentDirectoryPath() -> String {
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    return paths.first!
  }
  
  static func getDeviceToken(fromData deviceToken: Data) -> String {
    let token = deviceToken.map { (byte) -> String in
      return String(format: "%02.2hhx", byte as CVarArg)
      }.filter { (char) -> Bool in
        return [" ", "-", "<", ">"].contains(char) == false
      }.joined()
    return token
  }
  
  // MARK: - Others
  
  static func genJsonString(from object: Any, defaultJSON: String) -> String {
    if let data = try? JSONSerialization.data(withJSONObject: object, options: .prettyPrinted) {
      if let json = String(data: data, encoding: .utf8) {
        return json
      }
    }
    return defaultJSON
  }
  
  static func genObject(from json: String, defaultObject: Any) -> Any {
    if let data = json.data(using: .utf8) {
      if let object = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
        return object
      }
    }
    return defaultObject
  }
}


