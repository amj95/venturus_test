//
//  String+Extension.swift
//  venturus
//
//  Created by antonio marcos on 09/10/20.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}

