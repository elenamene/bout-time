//
//  gameManager.swift
//  bout-time
//
//  Created by Elena Meneghini on 09/08/2018.
//  Copyright © 2018 Elena Meneghini. All rights reserved.
//

import Foundation

// MARK: Protocols

protocol SortableItem {
    var title: String { get }
    var year: Int { get }
    var url: String { get }
}

protocol Randomable {
    func generateRandomList() -> [SortableItem]
}

protocol Sortable {
    func checkOrder(of list: [String]) -> Bool
}

protocol SortingGame: Randomable, Sortable {
    var collectionOfTvSeries: [SortableItem] { get }
    var selectedTVSeries: [SortableItem] { get }
    var numOfItemsDisplayed: Int { get }
    var level: GameLevel { get set }
    var points: Int { get set }
    var pointsPerCorrectSolution: Int { get }
    var roundsPerGame: Int { get }
    var roundsCompleted: Int { get set }
    var roundsWon: Int { get set }
    
    init(collection: [SortableItem])
    
    func generateRandomList() -> [SortableItem]
    func checkOrder(of list: [String]) -> Bool
}

// MARK: Objects

struct TVSeries: SortableItem {
    var title: String
    var year: Int
    var url: String
}

class TVSeriesGame: SortingGame {
    var collectionOfTvSeries: [SortableItem]
    var selectedTVSeries: [SortableItem] = []
    var level: GameLevel = .easy
    var points: Int = 0
    var pointsPerCorrectSolution: Int {
        switch level {
        case .easy: return 10
        case .medium: return 15
        case .difficult: return 30
        }
    }
    let roundsPerGame: Int = 6
    var roundsWon = 0
    var roundsCompleted: Int = 0
    var numOfItemsDisplayed: Int {
        switch level {
        case .easy: return 4
        case .medium: return 5
        case .difficult: return 6
        }
    }
    
    required init(collection: [SortableItem]) {
        self.collectionOfTvSeries = collection
    }
    
    func generateRandomList() -> [SortableItem] {
        selectedTVSeries = []
        var usedIndexes: [Int] = []
        var usedYears: [Int] = []
        
        // Select set of random series
        for _ in 1...numOfItemsDisplayed {
            var randomIndex = Int.random(in: 0..<collectionOfTvSeries.count)
            
            // Check for non used indexes and non repeating years
            while usedIndexes.contains(randomIndex) || usedYears.contains(collectionOfTvSeries[randomIndex].year) {
                randomIndex = Int.random(in: 0..<collectionOfTvSeries.count)
            }
            
            // Append arrays
            usedYears.append(collectionOfTvSeries[randomIndex].year)
            usedIndexes.append(randomIndex)
            selectedTVSeries.append(collectionOfTvSeries[randomIndex])
        }
        
        return selectedTVSeries
    }
    
    func checkOrder(of list: [String]) -> Bool {
        // Generate an array of titles sorted by year
        let seriesSortedByYear = selectedTVSeries.sorted(by:{ ($0.year) < ($1.year) })
        var titlesInCorrectOrder: [String] = []
        for series in seriesSortedByYear {
            titlesInCorrectOrder.append(series.title)
        }
        print("Solution: \(titlesInCorrectOrder)")
        
        // Compare the sorted array with the the user's solution (list)
        if list == titlesInCorrectOrder {
            roundsWon += 1
            points += pointsPerCorrectSolution
            return true
        } else {
            return false
        }
    }
}
