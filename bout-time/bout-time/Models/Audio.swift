//
//  Audio.swift
//  bout-time
//
//  Created by Elena Meneghini on 14/09/2018.
//  Copyright © 2018 Elena Meneghini. All rights reserved.
//

import Foundation
import AudioToolbox

enum SoundType: String {
    case mp3
    case wav
}

struct Sound {
    let soundEffectName: String
    let type: SoundType
    var soundEffectURL: URL {
        let path = Bundle.main.path(forResource: soundEffectName, ofType: type.rawValue)!
        return URL(fileURLWithPath: path)
    }
}

struct SoundsProvider {
    let correctSolution = Sound(soundEffectName: "CorrectDing", type: .wav)
    let wrongSolution = Sound(soundEffectName: "IncorrectBuzz", type: .wav)
}

class SoundEffectsPlayer {
    var sound: SystemSoundID = 0 // This property stores the sound we want to play
    let sounds = SoundsProvider()
    
    func playSound(_ soundEffect: Sound) {
        let soundURL = soundEffect.soundEffectURL as CFURL
        AudioServicesCreateSystemSoundID(soundURL, &sound) // Locate sound: SystemSoundID = 0
        AudioServicesPlaySystemSound(sound) // Play sound: SystemSoundID = 0
    }
}
