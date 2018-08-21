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
    @IBOutlet weak var timerLabel: UILabel!
    
    // MARK: - Properties
    
    let gameManager = GameManager()
    var optionsViews = [UIStackView]()
    var labels = [UILabel]()
    
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
        pointsLabel.text = "\(String(gameManager.points)) pts"
        // Select random series
        gameManager.getRandomSetOfSeries()
        // Display options
        buildOptionsButtons()
        displayOptionsButtons()
        self.view.layoutIfNeeded()
        // Assign titles to labels
        for index in 0...labels.count - 1 {
            let series = gameManager.selectedSeries[index]
            labels[index].text = series.title
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
        let numOfOptions = gameManager.numOfOptionsPerQuiz
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
            for series in gameManager.selectedSeries {
                if label.text == series.title {
                    label.text = "\(series.title) - \(series.year)"
                }
            }
        }
    }
    
    // Check order on shake gesture
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        shakeToCompleteLabel.isHidden = true
        // Get the current order displayed
        var currentTitlesOrder = [String]()
        for label in labels {
            if let title = label.text {
                currentTitlesOrder.append(title)
            }
        }
        print("Currrent order: \(currentTitlesOrder)")
        print(gameManager.seriesSortedByYear())
        // Check for correct order
        if currentTitlesOrder == gameManager.seriesSortedByYear() {
            print("Correct order!")
            nextRoundSuccessView.isHidden = false
            showSolution()
            // Assign points
            gameManager.points += gameManager.pointsPerQuiz
            // Keep track of num. of rounds completed
            gameManager.roundsCompleted += 1
            print("Points: \(gameManager.points)")
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
        if gameManager.roundsCompleted == gameManager.totRounds {
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
            if button.currentTitle == gameManager.level.rawValue {
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
        case .easy: gameManager.level = .easy
        case .medium: gameManager.level = .medium
        case .difficult: gameManager.level = .difficult
        }
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

