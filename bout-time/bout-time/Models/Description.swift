//
//  description.swift
//  bout-time
//
//  Created by Elena Meneghini on 16/08/2018.
//  Copyright © 2018 Elena Meneghini. All rights reserved.
//

enum Description {
    case title(title: String)
    case titleAndYear(title: String, year: Int)
    
    func description() -> String {
        switch self {
        case .title(let title): return "\(title)"
        case .titleAndYear(let title, let year): return "\(title) - \(year)"
        }
    }
}
