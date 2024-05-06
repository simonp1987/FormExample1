//
//  String+Regex.swift
//  FormExample1
//
//  Created by Pierre Simon on 24/04/2024.
//

import Foundation

extension String {
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, 
                          options: .regularExpression,
                          range: nil,
                          locale: nil) != nil
    }
}
