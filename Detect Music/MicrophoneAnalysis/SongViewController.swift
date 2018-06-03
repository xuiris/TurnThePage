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
    @IBOutlet weak var musicScoreView: UIImageView!
    
    var mic: AKMicrophone!
    var tracker: AKFrequencyTracker!
    var silence: AKBooster!
    var music: Song!
    var flats: String!
    var sharps: String!
    var detectedNotes: [String] = []
    var pitchIndex = 0
    var musicScoreIndex: Int = 0
    var pageViewController : UIPageViewController?
    

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
        matchMusic()
        
        Timer.scheduledTimer(timeInterval: 0.1,
                             target: self,
                             selector: #selector(SongViewController.updateUI),
                             userInfo: nil,
                             repeats: true)

    }

    func matchMusic() {

        // If it detects that the musician hasn't reached the end of the music,
        // keep matching sound to music score.
        if (self.music.currMeasure < self.music.musicScore.count) {
            DispatchQueue.global(qos: .background).async (execute: {
                self.matchPage()
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        AKSettings.audioInputEnabled = true
        mic = AKMicrophone()
        tracker = AKFrequencyTracker(mic)
        silence = AKBooster(tracker, gain: 0)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.hidesBarsOnTap = true;
        self.navigationController?.hidesBarsOnSwipe = true;
        displaySong()
        
    }
    
    func displaySong() {
        // Decide how the image will display in the UIImageView box
        self.musicScoreView.contentMode = UIViewContentMode.scaleAspectFit
        
        // Load the sheet music
        self.musicScoreView.image = UIImage(named: music.sheetJPG[musicScoreIndex])
    }
    
    func flipPage() {
        // Change image display to show the next page in the music score
        musicScoreIndex += 1
        if (musicScoreIndex < (music.sheetJPG.count)) {
            self.musicScoreView.image = UIImage(named: music.sheetJPG[musicScoreIndex])
            outputLabel.text = "Status: "
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }

    @objc func matchPage() {
        // FUNCTION NEEDS TO BE CALLED FOR EVERY NEW PAGE //
        // musicScore MUST NOT BE EMPTY
    
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
            music.currMeasure += 1 // loop to next measure in the page
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
        DispatchQueue.main.async (execute: {
            self.outputLabel.text = "Status: End of Page"
            self.flipPage()
            self.matchMusic()
        })
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
                //var pitchIndex = 0

                for i in 0..<noteFrequencies.count {
                    let distance = fabsf(Float(noteFrequencies[i]) - frequency)
                    if distance < minDistance {
                        pitchIndex = i
                        minDistance = distance
                    }
                }
                //let octave = Int(log2f(Float(tracker.frequency) / frequency))
            
            DispatchQueue.main.async (execute: {
                self.noteNameWithSharpsLabel.text = "\(self.noteNamesWithSharps[self.pitchIndex])"
                self.noteNameWithFlatsLabel.text = "\(self.noteNamesWithFlats[self.pitchIndex])"
            })
            print(noteNamesWithSharps[pitchIndex])
            print(noteNamesWithFlats[pitchIndex])

            flats = noteNamesWithFlats[pitchIndex]
            sharps = noteNamesWithSharps[pitchIndex]
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
            AKLog("Error: Could not stop microphone detection.")
        }
    }
    


}
