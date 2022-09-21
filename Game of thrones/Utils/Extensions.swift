//
//  Extensions.swift
//  Game of thrones
//
//  Created by Kuda Zata on 21/9/2022.
//

import Foundation

extension String {
    func titlecased() -> String {
        return self.replacingOccurrences(of: "([A-Z])", with: " $1", options: .regularExpression, range: self.range(of: self))
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .capitalized
    }
}
