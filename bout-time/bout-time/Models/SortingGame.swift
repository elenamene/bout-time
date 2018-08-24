//
//  gameManager.swift
//  bout-time
//
//  Created by Elena Meneghini on 09/08/2018.
//  Copyright © 2018 Elena Meneghini. All rights reserved.
//

import Foundation
import GameKit

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
    var collection: [SortableItem] { get }
    var selectedItems: [SortableItem] { get }
    var numOfItemsDisplayed: Int { get }
    var level: GameLevel { get set }
    var points: Int { get set }
    var pointsPerCorrectSolution: Int { get }
    var roundsPerGame: Int { get }
    var roundsCompleted: Int { get set }
    
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
    var collection: [SortableItem]
    var selectedItems: [SortableItem] = []
    var level: GameLevel = .easy
    var points: Int = 0
    var pointsPerCorrectSolution: Int {
        switch level {
        case .easy: return 10
        case .medium: return 15
        case .difficult: return 30
        }
    }
    let roundsPerGame: Int = 1
    var roundsCompleted: Int = 0
    var numOfItemsDisplayed: Int {
        switch level {
        case .easy: return 4
        case .medium: return 5
        case .difficult: return 6
        }
    }
    
    required init(collection: [SortableItem]) {
        self.collection = collection
    }
    
    func generateRandomList() -> [SortableItem] {
        selectedItems = []
        var usedIndexes: [Int] = []
        var usedYears: [Int] = []
        
        // Select set of series
        for _ in 1...numOfItemsDisplayed {
            var randomNumber = GKRandomSource.sharedRandom().nextInt(upperBound: collection.count)
            // Check for not used indexes and non repeating years
            while usedIndexes.contains(randomNumber) || usedYears.contains(collection[randomNumber].year) {
                randomNumber = GKRandomSource.sharedRandom().nextInt(upperBound: collection.count)
            }
            usedYears.append(collection[randomNumber].year)
            usedIndexes.append(randomNumber)
            selectedItems.append(collection[randomNumber])
        }
        
        return selectedItems
    }
    
    func checkOrder(of list: [String]) -> Bool {
        let seriesSortedByYear = selectedItems.sorted(by:{ ($0.year) < ($1.year) })
        var titlesInCorrectOrder: [String] = []
        for series in seriesSortedByYear {
            titlesInCorrectOrder.append(series.title)
        }
        print("Correct solution: \(titlesInCorrectOrder)")
        if list == titlesInCorrectOrder {
            points += pointsPerCorrectSolution
            roundsCompleted += 1
            return true
        } else {
            return false
        }
    }
}
