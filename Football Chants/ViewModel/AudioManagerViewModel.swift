//
//  AudioManagerViewModel.swift
//  Football Chants
//
//  Created by Alonso Alas on 11/1/23.
//

import Foundation
import AVKit

class AudioManagerViewModel {
    private var chantsAudioPlayer: AVAudioPlayer?
    
    func playback(_ team: Team) {
        if team.isPlaying {
            // Pausar la reproduccion
            chantsAudioPlayer?.stop()
        }else {
            // Llamar la funcion que va a reproducir el audio
            guard let path = Bundle.main.path(forResource: "\(team.id.chantFile).mp3", ofType: nil) else {return}
            let url = URL(fileURLWithPath: path)
            
            do {
                chantsAudioPlayer = try AVAudioPlayer(contentsOf: url)
                chantsAudioPlayer?.numberOfLoops = -1
                chantsAudioPlayer?.play()
            }catch{
                print(error)
            }
        }
    }
}
