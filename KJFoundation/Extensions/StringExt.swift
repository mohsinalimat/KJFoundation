//
//  StringExt.swift
//  KJFoundation
//
//  Created by Kenji on 17/1/17.
//  Copyright © 2017 DevLander. All rights reserved.
//
/*
 * Tweak CommonCrypto to be imported
 
  > Import CommonCrypto into project to be used in both Framework & Playground
  + source: http://iosdeveloperzone.com/2014/10/03/using-commoncrypto-in-swift

  1) create a module file (change the path accordingly)
  module CommonCrypto [system] {
    header "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/usr/include/CommonCrypto/CommonCrypto.h"
    header "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/usr/include/CommonCrypto/CommonRandom.h"
    export *
  }
  save as module.map

  2) create a CommonCrypto.framework in iPhoneOS.platform to support iPhone Device:
  $ cd /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/System/Library/Frameworks
  $ sudo mkdir CommonCrypto.framework
  $ cp module.map CommonCrypto.framework

  3) Do the same thing for iPhoneSimulator.platform to support Simulator and Playground

  4) In project, #import CommonCrypto and use as normal
 */

import Foundation
import CommonCrypto


extension String {
  
  func trimmingWhitespacesAndNewlines() -> String {
    return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
  }
  
  func toURL() -> URL? {
    return URL(string: self)
  }
  
  static func fromStringOrInt(_ value: Any?) -> String? {
    if let stringValue = value as? String { return stringValue }
    if let intValue = value as? Int { return String(intValue) }
    return nil
  }
  
}

// MARK: - Crypto

extension String {
  func md5() -> String {
    let data = self.data(using: .utf8)!
    var values = [UInt8](repeating: 0, count:data.count)
    data.copyBytes(to: &values, count: data.count)
    var digest = [UInt8](repeating: 0, count:Int(CC_MD5_DIGEST_LENGTH))
    CC_MD5(values, CC_LONG(data.count), &digest)
    let hexBytes = digest.map { String(format: "%02hhx", $0) }
    return hexBytes.joined(separator: "")
  }
  
  func sha1() -> String {
    let data = self.data(using: .utf8)!
    var values = [UInt8](repeating: 0, count:data.count)
    data.copyBytes(to: &values, count: data.count)
    var digest = [UInt8](repeating: 0, count:Int(CC_SHA1_DIGEST_LENGTH))
    CC_SHA1(values, CC_LONG(data.count), &digest)
    let hexBytes = digest.map { String(format: "%02hhx", $0) }
    return hexBytes.joined(separator: "")
  }
  
  func sha256() -> String {
    let data = self.data(using: .utf8)!
    var values = [UInt8](repeating: 0, count: data.count)
    data.copyBytes(to: &values, count: data.count)
    var digest = [UInt8](repeating: 0, count:Int(CC_SHA256_DIGEST_LENGTH))
    CC_SHA1(values, CC_LONG(data.count), &digest)
    let hexBytes = digest.map { String(format: "%02hhx", $0) }
    return hexBytes.joined(separator: "")
  }
}
