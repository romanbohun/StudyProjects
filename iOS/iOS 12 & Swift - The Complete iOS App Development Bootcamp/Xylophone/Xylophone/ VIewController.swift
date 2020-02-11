//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 27/01/2016.
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController{
    
    let url = Bundle.main.url(forResource: "note1", withExtension: "wav")

    var audioPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func notePressed(_ sender: UIButton) {
        let url = prepareUrlForTag(sender.tag)
        playSound(url)
    }
    
    private func prepareUrlForTag(_ tag: Int) -> URL {
        return Bundle.main.url(forResource: "note\(tag)", withExtension: "wav")!
    }
    
    private func playSound(_ forUrl: URL) {
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: forUrl)
            audioPlayer?.play()
        } catch {
            print(error)
        }
    }
}

