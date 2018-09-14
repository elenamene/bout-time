//
//  Sound.swift
//  bout-time
//
//  Created by Elena Meneghini on 11/09/2018.
//  Copyright © 2018 Elena Meneghini. All rights reserved.
//

/*
import Foundation
import AudioToolbox

enum SoundType: String {
    case mp3
    case wav
}

struct Sound {
    let soundName: String
    let type: SoundType
    var soundURL: URL {
        let path = Bundle.main.path(forResource: soundName, ofType: type.rawValue)
        return URL(fileURLWithPath: path!)
    }
}

struct SoundsProvider {
    let correctDing = Sound(soundName: "correctDing", type: .wav)
    let incorrectBuzz = Sound(soundName: "incorrectBuzz", type: .wav)
}

class SoundPlayer {
    let soundsProvider = SoundsProvider()
    
    func play(_ sound: Sound) {
        let soundUrl = sound.soundURL as CFURL
        var mySound: SystemSoundID = 0 // This property stores the sound we want to play
        AudioServicesCreateSystemSoundID(soundUrl, &mySound)
        AudioServicesPlaySystemSound(mySound)
    }
}
*/
