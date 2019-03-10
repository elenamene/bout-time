//
//  PListConversion.swift
//  bout-time
//
//  Created by Elena Meneghini on 22/08/2018.
//  Copyright © 2018 Elena Meneghini. All rights reserved.
//

import Foundation

enum collectionError: Error {
    case invalidResource
    case conversionFailure
    case invalidDictionary
}

class PlistConverter {
    static func list(fromFile name: String, ofType type: String) throws -> [[String: Any]] {
        // Check if valid path to the resource
        guard let path = Bundle.main.path(forResource: name, ofType: type) else {
            throw collectionError.invalidResource
        }
        
        // Check if plist contains root as Array
        guard let list = NSArray(contentsOfFile: path) as? [[String: Any]] else {
            throw collectionError.conversionFailure
        }
        
        return list
    }
}

class collectionUnarchiver {
    static func collection(fromList list: [[String: Any]]) throws -> [TVSeries] {
        var collection: [TVSeries] = []
        
        for dictionary in list {
            if let title = dictionary["title"] as? String,
                let year = dictionary["year"] as? Int,
                let url = dictionary["url"] as? String {
                
                let tvSeries = TVSeries(title: title, year: year, url: url)
                collection.append(tvSeries)
            } else {
                throw collectionError.invalidDictionary
            }
        }
        
        return collection
    }
}
