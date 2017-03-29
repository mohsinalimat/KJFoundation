//
//  KJActionHandler.swift
//  KJFoundation
//
//  Created by Kenji on 22/2/17.
//  Copyright © 2017 DevLander. All rights reserved.
//
//

import Foundation

protocol KJActionHandler : class {
  
  associatedtype SenderType
  associatedtype ActionType
  
  var onActionHandler: ((_ sender: SenderType, _ action: ActionType) -> Void)? { get set }
}
