//
//  String+sha256.swift
//  Recipedia
//
//  Created by Ryan Vreeke on 6/3/25.
//

import Foundation
import CryptoKit

extension String {
    var sha256: String {
        let data = Data(self.utf8)
        let hashedData = SHA256.hash(data: data)
        let hashedString = hashedData.map { String(format: "%02hhx", $0) }.joined()
        
        return hashedString
    }
}
