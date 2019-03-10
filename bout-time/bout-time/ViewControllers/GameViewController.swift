//
//  ViewController.swift
//  bout-time
//
//  Created by Elena Meneghini on 09/08/2018.
//  Copyright © 2018 Elena Meneghini. All rights reserved.
//

import UIKit
import SafariServices

class GameViewController: UIViewController {
    
    // MARK: - Outlets
   
    @IBOutlet weak var shakeToComplete: UILabel!
    
    @IBOutlet weak var option1View: UIStackView!
    @IBOutlet weak var option2View: UIStackView!
    @IBOutlet weak var option3View: UIStackView!
    @IBOutlet weak var option4View: UIStackView!
    @IBOutlet weak var option5View: UIStackView!
    @IBOutlet weak var option6View: UIStackView!
    
    @IBOutlet var optionsSubViews: [UIView]!
    
    @IBOutlet weak var option1Button: UIButton!
    @IBOutlet weak var option2Button: UIButton!
    @IBOutlet weak var option3Button: UIButton!
    @IBOutlet weak var option4Button: UIButton!
    @IBOutlet weak var option5Button: UIButton!
    @IBOutlet weak var option6Button: UIButton!
    
    @IBOutlet var UpDownButtons: [UIButton]!
    @IBOutlet weak var option6UpButton: UIButton!
    
    @IBOutlet weak var nextRoundButton: UIButton!
    
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    // MARK: - Properties
    
    var optionsViews = [UIStackView]()
    var buttons = [UIButton]()
    var timer = GameTimer()
    var game: SortingGame
    let soundEffectsPlayer = SoundEffectsPlayer()
    
    // MARK: - Plist import
    
    required init?(coder aDecoder: NSCoder) {
        do {
            let list = try PlistConverter.list(fromFile: "TVSeries", ofType: "plist")
            let collection = try collectionUnarchiver.collection(fromList: list)
            self.game = TVSeriesGame.init(collection: collection)
        } catch let error {
            fatalError("\(error)")
        }
        
        super.init(coder: aDecoder)
    }
    
    // MARK: - View Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideAllOptions()
        
        game.points = 0
        game.roundsCompleted = 0
    
        displayNewRound()
        
        // Observers for Timer
        NotificationCenter.default.addObserver(self, selector: #selector(handleTimeOver), name: Notification.Name(rawValue: "timeOver"), object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(handleTimeUpdate(notification:)), name: Notification.Name(rawValue: "timeUpdate"), object: nil)
    }
    
    override func viewWillLayoutSubviews() {
        for view in optionsSubViews {
            view.applyBasicStyle()
        }
    }
    
    deinit {
        // Clear observers
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Game Methods
    
    func displayNewRound() {
        // Create new list of TVseries
        buildOptionsButtons()
        displayOptionsButtons()
        let selectedSeries = game.generateRandomList()
        for n in 0...buttons.count - 1 {
            buttons[n].setTitle(selectedSeries[n].title, for: .normal)
        }
        
        // Set up display
        view.layoutIfNeeded()
        shakeToComplete.text = "Shake to complete"
        nextRoundButton.isHidden = true
        roundLabel.isHidden = false
        timerLabel.isHidden = false
        disableWebPageButtons()
    
        // Start timer
        timer.start()
        timerLabel.text = "\(timer.secondsRemaining)"
        
        game.roundsCompleted += 1
        updatePointsAndRoundsLabels()
    }
    
    // Check order on shake gesture
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        checkSolution()
    }
    
    func checkSolution() {
        disableButtons()
        enableWebPageButtons()
        timer.reset()
        shakeToComplete.text = "Tap a series to know more!"
        nextRoundButton.isHidden = false
        
        // Get the current order displayed in an array
        var currentTitlesDisplayed = [String]()
        for button in buttons {
            if let title = button.currentTitle {
                currentTitlesDisplayed.append(title)
            }
        }
        
        // Check if the order of the array is correct
        if game.checkOrder(of: currentTitlesDisplayed) {
            // Correct solution
            nextRoundButton.setImage(#imageLiteral(resourceName: "next_round_success"), for: .normal)
            soundEffectsPlayer.playSound(soundEffectsPlayer.sounds.correctSolution)
        } else {
            // Wrong Solution
            nextRoundButton.setImage(#imageLiteral(resourceName: "next_round_fail"), for: .normal)
            soundEffectsPlayer.playSound(soundEffectsPlayer.sounds.wrongSolution)
        }
    }
    
    func nextRound() {
        if game.roundsCompleted == game.roundsPerGame {
            // Game is over
            performSegue(withIdentifier: "endGame", sender: nil)
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
    
    // MARK: - Helpers
    
    func buildOptionsButtons() {
        // Reset previous arrays
        optionsViews = []
        buttons = []
        
        // build new array of buttons
        let numOfOptions = game.numOfItemsDisplayed
        switch numOfOptions {
        case 4:
            optionsViews += [option1View, option2View, option3View, option6View]
            buttons += [option1Button, option2Button, option3Button, option6Button]
            // set last button tag
            option6UpButton.tag = 4
        case 5:
            optionsViews += [option1View, option2View, option3View, option4View, option6View]
            buttons += [option1Button, option2Button, option3Button, option4Button, option6Button]
            // set last button tag
            option6UpButton.tag = 5
        case 6:
            optionsViews += [option1View, option2View, option3View, option4View, option5View, option6View]
            buttons += [option1Button, option2Button, option3Button, option4Button, option5Button, option6Button]
            // set last button tag to default
            option6UpButton.tag = 6
            
        default: print("Invalid number of options")
        }
    }
    
    func displayOptionsButtons() {
        for view in optionsViews {
            view.isHidden = false
        }
        enableButtons()
    }
    
    func disableButtons() {
        UpDownButtons.forEach { button in
            button.isEnabled = false
        }
    }
    
    func enableButtons() {
        UpDownButtons.forEach { button in
            button.isEnabled = true
        }
    }
    
    func disableWebPageButtons() {
        option1Button.isEnabled = false
        option2Button.isEnabled = false
        option3Button.isEnabled = false
        option4Button.isEnabled = false
        option5Button.isEnabled = false
        option6Button.isEnabled = false
    }
    
    func enableWebPageButtons() {
        option1Button.isEnabled = true
        option2Button.isEnabled = true
        option3Button.isEnabled = true
        option4Button.isEnabled = true
        option5Button.isEnabled = true
        option6Button.isEnabled = true
    }
    
    func hideAllOptions() {
        option1View.isHidden = true
        option2View.isHidden = true
        option3View.isHidden = true
        option4View.isHidden = true
        option5View.isHidden = true
        option6View.isHidden = true
    }
    
    func displayAllOptions() {
        option1View.isHidden = false
        option2View.isHidden = false
        option3View.isHidden = false
        option4View.isHidden = false
        option5View.isHidden = false
        option6View.isHidden = false
    }
    
    func updatePointsAndRoundsLabels() {
            pointsLabel.text = "Points: \(game.points)"
            roundLabel.text = "Rounds: \(game.roundsCompleted)"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "endGame" {
            if let endViewController = segue.destination as? EndViewController {
                endViewController.pointsScored = game.points
                endViewController.roundsSuccessfullyCompleted = game.roundsWon
                endViewController.totRounds = game.roundsPerGame
            }
        }
    }
    
    @objc func handleTimeUpdate(notification: NSNotification) {
       timerLabel.text = "\(timer.secondsRemaining)"
    }
    
    @objc func handleTimeOver(notification: NSNotification) {
        checkSolution()
    }
    
    // MARK: - SafariViewController
    
    func showWebPage(ofSeries title: String) {
        var stringURL = String()
        for series in game.collectionOfTvSeries {
            if series.title == title {
                stringURL = series.url
            }
        }
        
        if let url = URL(string: stringURL) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            
            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }
    
    // MARK: - Actions
    
    @IBAction func moveUp(_ sender: UIButton) {
        let index = sender.tag - 1
        let titleSelected = buttons[index].currentTitle
        let previousTitle = buttons[index - 1].currentTitle
        buttons[index].setTitle(previousTitle, for: .normal)
        buttons[index - 1].setTitle(titleSelected, for: .normal)
    }
    
    @IBAction func moveDown(_ sender: UIButton) {
        let index = sender.tag - 1
        let titleSelected = buttons[index].currentTitle
        let followingTitle = buttons[index + 1].currentTitle
        buttons[index].setTitle(followingTitle, for: .normal)
        buttons[index + 1].setTitle(titleSelected, for: .normal)
    }
    
    @IBAction func startNextRound(_ sender: UIButton) {
         loadNextRound(delay: 1)
    }
    
    @IBAction func openWebPage(_ sender: UIButton) {
        if let title = sender.currentTitle {
            showWebPage(ofSeries: title)
            print("Tap on \(title)")
        }
    }
    
}
