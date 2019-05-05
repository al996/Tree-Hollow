//
//  Keys.swift
//  TreeHollow
//
//  Created by Rachel Deng on 5/4/19.
//  Copyright © 2019 Rachel Deng. All rights reserved.
//

import Foundation

enum Keys: String {
    
    case googleClientIdKey = "GOOGLE_CLIENT_ID"
    
    /// The string value of the key
    var value: String {
        return Keys.keyDict[rawValue] as? String ?? ""
    }
    
    private static let keyDict: NSDictionary = {
        guard let path = Bundle.main.path(forResource: "Keys", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path) else { return [:] }
        return dict
    }()
    
}
