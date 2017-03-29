//
//  KJReuseableView.swift
//  KJFoundation
//
//  Created by Kenji on 11/2/17.
//  Copyright © 2017 DevLander. All rights reserved.
//

import UIKit

/*
 A reuseable view using for UITableViewCell or UICollectionViewCell
 + the cell in xib file must have name and identifier same as its class
 + for i.e: a cell ProfileCell will return getReuseIdentifier: "ProfileCell" and load the xib file: "ProfileCell.xib"
 */

protocol KJReuseableView: class {
  
  static func getNib() -> UINib
  
  static func getReuseIdentifier() -> String
  
  static func registerWithTableView(_ tableView: UITableView)
  
  static func registerWithCollectionView(_ collectionView: UICollectionView)
  
}

extension KJReuseableView where Self: UIView {
  
  static func getNib() -> UINib {
    let className = NSStringFromClass(self).components(separatedBy: ".").last!
    return UINib(nibName: className, bundle: nil)
  }
  
  static func getReuseIdentifier() -> String {
    return NSStringFromClass(self).components(separatedBy: ".").last!
  }
  
  static func registerWithTableView(_ tableView: UITableView) {
    assert(Self.self is UITableViewCell.Type, "view must be a UITableViewCell")
    tableView.register(Self.getNib(), forCellReuseIdentifier: Self.getReuseIdentifier())
  }
  
  static func registerWithCollectionView(_ collectionView: UICollectionView) {
    assert(Self.self is UICollectionViewCell.Type, "view must be a UICollectionViewCell")
    collectionView.register(Self.getNib(), forCellWithReuseIdentifier: Self.getReuseIdentifier())
  }
  
  static func registerReusableViewWithCollectionView(_ collectionView: UICollectionView, viewKind: String) {
    assert(Self.self is UICollectionReusableView.Type, "view must be a UICollectionReusableView")
    collectionView.register(Self.getNib(), forSupplementaryViewOfKind: viewKind, withReuseIdentifier: Self.getReuseIdentifier())
  }
  
}
