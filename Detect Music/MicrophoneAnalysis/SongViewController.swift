//
//  SongViewController.swift
//  MicrophoneAnalysis
//
//  Created by Kanstantsin Linou, revision history on Githbub.
//  Copyright © 2018 AudioKit. All rights reserved.
//
//  Additions made by Turn the Page group, for CS48 : Comparing functionality to parsed music
//


import AudioKit
import AudioKitUI
import UIKit

class SongViewController: UIViewController {

    @IBOutlet private var frequencyLabel: UILabel!
    @IBOutlet private var amplitudeLabel: UILabel!
    @IBOutlet var noteNameWithSharpsLabel: UILabel!
    @IBOutlet var noteNameWithFlatsLabel: UILabel!
    @IBOutlet private var audioInputPlot: EZAudioPlot!

    var mic: AKMicrophone!
    var tracker: AKFrequencyTracker!
    var silence: AKBooster!
    var music: Song!
    var measure0: Measure!
    var measure1: Measure!
    var flats: String!
    var sharps: String!
    var detectedNotes: [String] = []
    var index = 0
    

    let noteFrequencies = [16.35, 17.32, 18.35, 19.45, 20.6, 21.83, 23.12, 24.5, 25.96, 27.5, 29.14, 30.87]
    let noteNamesWithSharps = ["C", "C♯", "D", "D♯", "E", "F", "F♯", "G", "G♯", "A", "A♯", "B"]
    let noteNamesWithFlats = ["C", "D♭", "D", "E♭", "E", "F", "G♭", "G", "A♭", "A", "B♭", "B"]

    func setupPlot() {
        let plot = AKNodeOutputPlot(mic, frame: audioInputPlot.bounds)
        plot.plotType = .rolling
        plot.shouldFill = true
        plot.shouldMirror = true
        plot.color = UIColor.blue
        audioInputPlot.addSubview(plot)
    }

    @IBOutlet weak var outputLabel: UILabel!
    
    @IBAction func startClicked(_ sender: Any) {
        AudioKit.output = silence
        do {
            try AudioKit.start()
        } catch {
            AKLog("AudioKit did not start!")
        }
        setupPlot()
        DispatchQueue.global(qos: .background).async (execute: {
            self.matchNotes()
        })
        
        Timer.scheduledTimer(timeInterval: 0.1,
                             target: self,
                             selector: #selector(SongViewController.updateUI),
                             userInfo: nil,
                             repeats: true)

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        AKSettings.audioInputEnabled = true
        mic = AKMicrophone()
        tracker = AKFrequencyTracker(mic)
        silence = AKBooster(tracker, gain: 0)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }

    @objc func matchNotes() {
        // FUNCTION NEEDS TO BE CALLED FOR EVERY NEW PAGE //
        // musicScore MUST NOT BE EMPTY
        
        //if tracker.amplitude > 0.05 {
            var measure: Measure = music.musicScore[music.currMeasure]
            var i = 0    
            while (!music.musicScore[music.currMeasure].isLastMeasure) {
                if !measure.notes.isEmpty { // Enter if there are notes in the measure
                    repeat {
                        // now check for the note:
                        if ((measure.notes[i].pitch == flats) || (measure.notes[i].pitch == sharps)) {
                            i += 1 // successful detection. loop to next note in the measure.
                        }
                    } while (i < measure.notes.count)
                   // if here, then we are at the last note in the measure
                    
                }
                i = 0
                music.currMeasure += 1 // loop to next measure in the music score
                measure = music.musicScore[music.currMeasure]
            }
            if !measure.notes.isEmpty { // Enter if there are notes in the measure
                repeat {
                    // now check for the note:
                    if ((measure.notes[i].pitch == flats) || (measure.notes[i].pitch == sharps)) {
                        i += 1 // successful detection. loop to next note in the measure.
                    }
                } while (i < measure.notes.count)
                // if here, then we are at the last note in the measure
                
            }
        
            // if here, then we have hit the last measure on the page
            
            // STUB CODE, NEED TO LINK TO NEXT PAGE BUTTON //
            DispatchQueue.main.async (execute: {
                self.outputLabel.text = "Status: End of Page"
            })
        //}
    }
    
    @objc func updateUI() {
        if tracker.amplitude > 0.02 {
            let currThread = Thread.current
            print("Current: \(currThread)")
            
                DispatchQueue.main.async (execute: {
                    self.frequencyLabel.text = String(format: "%0.1f", self.tracker.frequency)
            })
            
                var frequency = Float(tracker.frequency)
                while frequency > Float(noteFrequencies[noteFrequencies.count - 1]) {
                    frequency /= 2.0
                }
                while frequency < Float(noteFrequencies[0]) {
                    frequency *= 2.0
                }

                var minDistance: Float = 10_000.0
                //var index = 0

                for i in 0..<noteFrequencies.count {
                    let distance = fabsf(Float(noteFrequencies[i]) - frequency)
                    if distance < minDistance {
                        index = i
                        minDistance = distance
                    }
                }
                //let octave = Int(log2f(Float(tracker.frequency) / frequency))
            
            DispatchQueue.main.async (execute: {
                self.noteNameWithSharpsLabel.text = "\(self.noteNamesWithSharps[self.index])"
                self.noteNameWithFlatsLabel.text = "\(self.noteNamesWithFlats[self.index])"
            })
            print(noteNamesWithSharps[index])
            print(noteNamesWithFlats[index])

            flats = noteNamesWithFlats[index]
            sharps = noteNamesWithSharps[index]
            detectedNotes.append(flats)
        }
        
        DispatchQueue.main.async (execute: {
            self.amplitudeLabel.text = String(format: "%0.2f", self.tracker.amplitude)
        })
        
    }
    
    
    @IBAction func stop(_ sender: UIButton) {
        do {
            try AudioKit.stop()
        } catch {
            AKLog("cannot stop")
        }
    }

}
