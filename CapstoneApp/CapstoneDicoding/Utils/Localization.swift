//
//  Localization.swift
//  CapstoneDicoding
//
//  Created by Fep on 25/07/24.
//

import Foundation

extension String {
  public func localized(identifier: String) -> String {
    let bundle = Bundle(identifier: identifier) ?? .main
    return bundle.localizedString(forKey: self, value: nil, table: nil)
  }
}
