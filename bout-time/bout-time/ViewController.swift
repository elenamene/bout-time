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
  
    @IBOutlet weak var option1View: UIStackView!
    @IBOutlet weak var option2View: UIStackView!
    @IBOutlet weak var option3View: UIStackView!
    @IBOutlet weak var option4View: UIStackView!
    @IBOutlet weak var option5View: UIStackView!
    @IBOutlet weak var option6View: UIStackView!
    
    @IBOutlet weak var subviewOption1: UIView!
    @IBOutlet weak var subviewOption2: UIView!
    @IBOutlet weak var subviewOption3: UIView!
    @IBOutlet weak var subviewOption4: UIView!
    @IBOutlet weak var subviewOption5: UIView!
    @IBOutlet weak var subviewOption6: UIView!
    
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
        subviewOption1.applyBasicStyle()
        subviewOption2.applyBasicStyle()
        subviewOption3.applyBasicStyle()
        subviewOption4.applyBasicStyle()
        subviewOption5.applyBasicStyle()
        subviewOption6.applyBasicStyle()
        option1Label.applyStyle()
        option2Label.applyStyle()
        option3Label.applyStyle()
        option4Label.applyStyle()
        option5Label.applyStyle()
        option6Label.applyStyle()
    }
    
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        print("Device was shaken!")
        shakeToCompleteLabel.isHidden = true
        
        // Get the current order displayed
        var currentTitlesOrder = [String]()
        for label in labels {
            if let title = label.text {
                currentTitlesOrder.append(title)
            }
        }
        
        // Check for correct order
        if currentTitlesOrder == gameManager.seriesSortedByYear() {
            print("Correct order!")
            nextRoundSuccessView.isHidden = false
            // Assign points
            switch gameManager.gameLevel {
            case .easy: gameManager.points += 1
            case .medium: gameManager.points += 3
            case .difficult: gameManager.points += 5
            }
            print("Points: \(gameManager.points)")
        } else {
            print("Wrong order")
            nextRoundFailView.isHidden = false
        }
    }
    
    // MARK: - Helpers
    
    func displayNewRound() {
        // Select random series
        gameManager.getRandomSetOfSeries()
        
        // Display options
        buildOptionsButtons()
        displayOptionsButtons()
        
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
    }
    
    func buildOptionsButtons() {
        let numOfOptionsPerQuiz = gameManager.numOfOptionsPerQuiz
        switch numOfOptionsPerQuiz {
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
        default: print("Invalid number of options")
        }
    }
    
    func displayOptionsButtons() {
        for view in optionsViews {
            view.isHidden = false
        }
    }
    
    // MARK: - Actions
    
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
