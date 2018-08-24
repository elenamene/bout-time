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
    
    // MARK: - Properties
    
    var pointsScored: Int?
    var roundsCompleted: Int?
    var totRounds: Int?
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let pointsScored = pointsScored,
            let roundsCompleted = roundsCompleted,
            let totRounds = totRounds {
            pointsLabel.text = "\(pointsScored)pts"
            roundsLabel.text = "\(roundsCompleted)/\(totRounds)"
        }
    }
    
    // MARK: - Actions

    @IBAction func playAgain(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
