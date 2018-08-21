//
//  gameManager.swift
//  bout-time
//
//  Created by Elena Meneghini on 09/08/2018.
//  Copyright © 2018 Elena Meneghini. All rights reserved.
//

import Foundation
import GameKit

class GameManager {
    var seriesProvider = SeriesProvider()
    var level: GameLevel = .easy
    var selectedSeries: [Series] = []
    var totRounds = 6
    var roundsCompleted = 0
    var points = 0
    var numOfOptionsPerQuiz: Int {
        switch level {
        case .easy: return 4
        case .medium: return 5
        case .difficult: return 6
        }
    }
    var pointsPerQuiz: Int {
        switch level {
        case .easy: return 10
        case .medium: return 15
        case .difficult: return 30
        }
    }
 
    func getRandomSetOfSeries() {
        var previousSelectedIndexes: [Int] = []
        var previousSelectedYears: [Int] = []
        // Reset previous array of series
        selectedSeries = []
        
        // Select set of series
        for _ in 1...numOfOptionsPerQuiz {
            
            // Get random index
            var newRandomIndex = GKRandomSource.sharedRandom().nextInt(upperBound: seriesProvider.allSeries.count)
            
            // Check for non repeating indexes
            if previousSelectedIndexes.contains(newRandomIndex) {
                newRandomIndex = GKRandomSource.sharedRandom().nextInt(upperBound: seriesProvider.allSeries.count)
            } else {
                 previousSelectedIndexes.append(newRandomIndex)
            }
            
            // Check for non repeating years
            if previousSelectedYears.contains(seriesProvider.allSeries[newRandomIndex].year) {
                newRandomIndex = GKRandomSource.sharedRandom().nextInt(upperBound: seriesProvider.allSeries.count)
            } else {
                previousSelectedYears.append(seriesProvider.allSeries[newRandomIndex].year)
            }
            
            // Append final set of series
            selectedSeries.append(seriesProvider.allSeries[newRandomIndex])
            
        }
    
        for series in selectedSeries {
            print("\(series.title) \(series.year)")
        }
    }
    
    func seriesSortedByYear() -> [String] {
        var titlesSorted = [String]()
        let seriesSortedByYear = selectedSeries.sorted(by:{ ($0.year) < ($1.year) })
        for series in seriesSortedByYear {
            titlesSorted.append(series.title)
        }
        
        return titlesSorted
    }
}
