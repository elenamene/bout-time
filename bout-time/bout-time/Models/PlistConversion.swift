//
//  PListConversion.swift
//  bout-time
//
//  Created by Elena Meneghini on 22/08/2018.
//  Copyright © 2018 Elena Meneghini. All rights reserved.
//

import Foundation

enum collectionImportError: Error {
    case invalidResource
    case conversionFailure
    case invalidDictionary
}

class PlistConverter {
    static func importArray(fromPList name: String, ofType type: String) throws -> [[String: Any]] {
        // If valid path to the resource
        guard let path = Bundle.main.path(forResource: name, ofType: type) else {
            throw collectionImportError.invalidResource
        }
        
        // If plist contains root as Array
        guard let arrayOfDictionaries = NSArray(contentsOfFile: path) as? [[String: Any]] else {
            throw collectionImportError.conversionFailure
        }
        
        return arrayOfDictionaries
    }
}

class collectionUnarchiver {
    static func collection(fromArray array: [[String: Any]]) throws -> [TVSeries] {
        var collection: [TVSeries] = []
        
        for dictionary in array {
            if let title = dictionary["title"] as? String,
                let year = dictionary["year"] as? Int,
                let url = dictionary["url"] as? String {
                
                let tvSeries = TVSeries(title: title, year: year, url: url)
                collection.append(tvSeries)
            } else {
                throw collectionImportError.invalidDictionary
            }
        }
        
        return collection
    }
}
