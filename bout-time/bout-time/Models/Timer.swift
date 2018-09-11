//
//  timer.swift
//  bout-time
//
//  Created by Elena Meneghini on 24/08/2018.
//  Copyright © 2018 Elena Meneghini. All rights reserved.
//

import Foundation

class GameTimer {
    var timer = Timer()
    var secondsRemaining: Int = 60
    
    func start() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        secondsRemaining = 60
        print("timer started")
    }
    
    @objc func updateCounter() {
        secondsRemaining -= 1
        print(secondsRemaining)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "timeUpdate"), object: nil)
        
        if secondsRemaining == 0 {
            NotificationCenter.default.post(name: Notification.Name(rawValue: "timeOver"), object: nil)
            timer.invalidate()
            print("time over")
        }
    }
    
    func reset() {
        timer.invalidate()
        print("timer stopped")
    }
}
