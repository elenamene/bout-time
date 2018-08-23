//
//  ViewController.swift
//  bout-time
//
//  Created by Elena Meneghini on 09/08/2018.
//  Copyright © 2018 Elena Meneghini. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
  
    @IBOutlet var gameLevelButtons: [UIButton]!
    @IBOutlet weak var selectLevelButton: UIButton!
    
    @IBOutlet weak var option1View: UIStackView!
    @IBOutlet weak var option2View: UIStackView!
    @IBOutlet weak var option3View: UIStackView!
    @IBOutlet weak var option4View: UIStackView!
    @IBOutlet weak var option5View: UIStackView!
    @IBOutlet weak var option6View: UIStackView!
    
    @IBOutlet var optionsSubViews: [UIView]!
    
    @IBOutlet weak var option1Label: UILabel!
    @IBOutlet weak var option2Label: UILabel!
    @IBOutlet weak var option3Label: UILabel!
    @IBOutlet weak var option4Label: UILabel!
    @IBOutlet weak var option5Label: UILabel!
    @IBOutlet weak var option6Label: UILabel!
    
    @IBOutlet weak var option6UpButton: UIButton!
    
    @IBOutlet weak var shakeToCompleteLabel: UILabel!
    @IBOutlet weak var nextRoundSuccessView: UIImageView!
    @IBOutlet weak var nextRoundFailView: UIImageView!
    
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    // MARK: - Properties
    
    var optionsViews = [UIStackView]()
    var labels = [UILabel]()
    
    // MARK: - Game initialization
    
    var game: SortingGame
    
    required init?(coder aDecoder: NSCoder) {
        do {
            let arrayOfTVSeries = try PlistConverter.importArray(fromPList: "TVSeries", ofType: "plist")
            let seriesCollection = try collectionUnarchiver.collection(fromArray: arrayOfTVSeries)
            self.game = TVSeriesGame.init(collection: seriesCollection)
        } catch let error {
            fatalError("\(error)")
        }
        
        super.init(coder: aDecoder)
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideAllOptions()
        displayNewRound()
        nextRoundFailView.isHidden = true
        nextRoundSuccessView.isHidden = true
    }
    
    override func viewWillLayoutSubviews() {
        // Set style to views and labels
        optionsSubViews.forEach { (view) in
            view.applyBasicStyle()
        }
        option1Label.applyStyle()
        option2Label.applyStyle()
        option3Label.applyStyle()
        option4Label.applyStyle()
        option5Label.applyStyle()
        option6Label.applyStyle()
    }
    
    // MARK: - Helpers
    
    func displayNewRound() {
        // Layout
        nextRoundSuccessView.isHidden = true
        shakeToCompleteLabel.isHidden = false
        pointsLabel.text = "Points: \(String(game.points))"
        roundLabel.text = "Round: \(game.roundsCompleted)"
        // Display options
        buildOptionsButtons()
        displayOptionsButtons()
        self.view.layoutIfNeeded()
        // Select random series
        let selectedSeries = game.generateRandomList()
        // Assign titles to labels
        for index in 0...labels.count - 1 {
            labels[index].text = selectedSeries[index].title
        }
        
        for tvSeries in selectedSeries {
            print("\(tvSeries.title) \(tvSeries.year)")
        }
    }
    
    func hideAllOptions() {
        option1View.isHidden = true
        option2View.isHidden = true
        option3View.isHidden = true
        option4View.isHidden = true
        option5View.isHidden = true
        option6View.isHidden = true
        // Reset collections
       //  optionsViews = []
        // labels = []
    }
    
    func buildOptionsButtons() {
        // Reset previous arrays
        optionsViews = []
        labels = []
        // build new array of buttons
        let numOfOptions = game.numOfItemsDisplayed
        switch numOfOptions {
        case 4:
            optionsViews += [option1View, option2View, option3View, option6View]
            labels += [option1Label, option2Label, option3Label, option6Label]
            // change tag to last button
            option6UpButton.tag = 4
        case 5:
            optionsViews += [option1View, option2View, option3View, option4View, option6View]
            labels += [option1Label, option2Label, option3Label, option4Label, option6Label]
            // change tag to last button
            option6UpButton.tag = 5
        case 6:
            optionsViews += [option1View, option2View, option3View, option4View, option5View, option6View]
            labels += [option1Label, option2Label, option3Label, option4Label, option5Label, option6Label]
            // change tag to last button to default
            option6UpButton.tag = 6
        default: print("Invalid number of options")
        }
        print("Num. of buttons built: \(optionsViews.count)")
        print("Num. of labels: \(labels.count)")
    }
    
    func displayOptionsButtons() {
        for view in optionsViews {
            view.isHidden = false
        }
    }
    
    func showSolution() {
        for label in labels {
            for series in game.selectedItems {
                if label.text == series.title {
                    label.text = "\(series.title) - \(series.year)"
                }
            }
        }
    }
    
    // Check order on shake gesture
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        shakeToCompleteLabel.isHidden = true
        // Get the current order displayed in an array
        var currentTitlesDisplayed = [String]()
        for label in labels {
            if let title = label.text {
                currentTitlesDisplayed.append(title)
            }
        }
        print("Currrent order: \(currentTitlesDisplayed)")
        // Check for correct order
        if game.checkOrder(of: currentTitlesDisplayed) {
            print("Correct order!")
            print("Points: \(game.points)")
            print("Rounds completed: \(game.roundsCompleted)")
            nextRoundSuccessView.isHidden = false
            showSolution()
            
            // Load next round
            loadNextRound(delay: 3)
        } else {
            print("Wrong order")
            nextRoundFailView.alpha = 1
            nextRoundFailView.isHidden = false
            UIView.animate(withDuration: 0.3, delay: 2.0, animations: {
                self.nextRoundFailView.alpha = 0
            })
            shakeToCompleteLabel.isHidden = false
        }
    }
    
    func nextRound() {
        if game.roundsCompleted == game.roundsPerGame {
            // Game is over
     
        } else {
            // Continue game
           displayNewRound()
        }
    }
    
    func loadNextRound(delay seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }
    
    // MARK: - Actions
    
    // Reveal dropdown menu
    @IBAction func selectLevel(_ sender: UIButton) {
        for button in gameLevelButtons {
            if button.currentTitle == game.level.rawValue {
                button.isSelected = true
            } else {
                button.isSelected = false
            }
        }
        
        // Reveal level buttons
        gameLevelButtons.forEach { (button) in
            UIView.animate(withDuration: 0.3, animations: {
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
            })
        }
    }
    
    // Select level in dropdown menu
    @IBAction func changeLevel(_ sender: UIButton) {
        guard let title = sender.currentTitle, let level = GameLevel(rawValue: title) else {
            return
        }
        // Select level
        switch level {
        case .easy: game.level = .easy
        case .medium: game.level = .medium
        case .difficult: game.level = .difficult
        }
        print("Level selected: \(sender.currentTitle!)")
        print("Game level: \(game.level)")
        // Hide current options
        hideAllOptions()
        // Display new options
        displayNewRound()
        // Hide level buttons
        gameLevelButtons.forEach { (button) in
            UIView.animate(withDuration: 0.3, animations: {
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @IBAction func moveUp(_ sender: UIButton) {
        let index = sender.tag - 1
        let titleSelected = labels[index].text
        let previousTitle = labels[index - 1].text
        labels[index].text = previousTitle
        labels[index - 1].text = titleSelected
    }
    
    @IBAction func moveDown(_ sender: UIButton) {
        let index = sender.tag - 1
        let titleSelected = labels[index].text
        let followingTitle = labels[index + 1].text
        labels[index].text = followingTitle
        labels[index + 1].text = titleSelected
    }
    
}

