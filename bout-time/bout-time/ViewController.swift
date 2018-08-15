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
    
    // MARK: - Properties
    
    let gameManager = GameManager()
    var optionsViews = [UIStackView]()
    var labels = [UILabel]()
    
    // MARK: - View Lifecycle
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideAllOptions()
        displayNewRound()
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
        case 5:
            optionsViews += [option1View, option2View, option3View, option4View, option6View]
            labels += [option1Label, option2Label, option3Label, option4Label, option6Label]
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
        print("pressed UP")
    }
    
    @IBAction func moveDown(_ sender: UIButton) {
        print("pressed DOWN")
    }
    
}

