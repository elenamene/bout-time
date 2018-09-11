//
//  EndViewController.swift
//  bout-time
//
//  Created by Elena Meneghini on 23/08/2018.
//  Copyright © 2018 Elena Meneghini. All rights reserved.
//

import UIKit

class EndViewController: UIViewController {
    
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var roundsLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    
    // MARK: - Properties
    
    var pointsScored: Int?
    var roundsSuccessfullyCompleted: Int?
    var totRounds: Int?
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playAgainButton.roundCorners(corners: .allCorners, radius: 8)
        
        if let pointsScored = pointsScored,
            let roundsSuccessfullyCompleted = roundsSuccessfullyCompleted,
            let totRounds = totRounds {
            pointsLabel.text = "\(pointsScored)pts"
            roundsLabel.text = "\(roundsSuccessfullyCompleted)/\(totRounds)"
        }
    }
    
    // MARK: - Actions

    @IBAction func playAgain(_ sender: UIButton) {
        performSegue(withIdentifier: "playAgain", sender: sender)
    }
}


