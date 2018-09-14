//
//  StartViewController.swift
//  bout-time
//
//  Created by Elena Meneghini on 26/08/2018.
//  Copyright © 2018 Elena Meneghini. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet var gameLevelButtons: [UIButton]!
    @IBOutlet weak var startButton: UIButton!
    
    var levelSelected: GameLevel!
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.isEnabled = false
        startButton.roundCorners(corners: .allCorners, radius: 4)
        gameLevelButtons.forEach { button in
            button.roundCorners(corners: .allCorners, radius: 4)
            button.backgroundColor = UIColor.black.withAlphaComponent(0.05)
        }
    }
    
    // Reset the default state of the buttons
    func resetButtonStates() {
        for button in gameLevelButtons {
            button.isHighlighted = false
            button.backgroundColor = UIColor.black.withAlphaComponent(0.05)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startGame" {
            if let gameViewController = segue.destination as? GameViewController {
                 gameViewController.game.level = levelSelected
            }
        }
    }
    
    // MARK: - Actions

    @IBAction func selectLevel(_ sender: UIButton) {
        // Reset the default state to all the buttons
        resetButtonStates()
        
        // Update the button state of the selected button alone if its not selected already
        sender.roundCorners(corners: .allCorners, radius: 4)
        sender.backgroundColor = UIColor(red:1.00, green:0.99, blue:0.91, alpha:1.0)
    
        startButton.isEnabled = true
        startButton.backgroundColor = UIColor(red:1.00, green:0.60, blue:0.00, alpha:1.0)
        startButton.setTitleColor(UIColor.white, for: .normal)
        
        guard let title = sender.title(for: .normal) else {
            return
        }
        
        levelSelected = GameLevel(rawValue: title)
    }
    
    @IBAction func startGame(_ sender: UIButton) {
        performSegue(withIdentifier: "startGame", sender: sender)
    }

}
