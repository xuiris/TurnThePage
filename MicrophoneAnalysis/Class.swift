//
//  Class.swift
//  MicrophoneAnalysis
//
//  Created by Iris Xu on 5/15/18.
//  Copyright © 2018 AudioKit. All rights reserved.
//

import Foundation

class Song{
    var songName: String = String()
    var artist: String = String()
    var sheetPDF: String = String()
    var sheetXML: String = String()
    init(songName:String, artist:String, sheetPDF:String, sheetXML:String) {
        self.songName = songName
        self.artist = artist
        self.sheetPDF = sheetPDF
        self.sheetXML = sheetXML
    }
}

class Note{
    var pitch: String = String()
    var duration: String = String()
    var octave: String = String()
    var isLastNote: Bool = false
    init(pitch:String, duration:String, octave:String, isLastNote:Bool) {
        self.pitch = pitch
        self.duration = duration
        self.octave = octave
        self.isLastNote = isLastNote
    }
}

class Measure{
    var number: Int = Int()
    var notes = [Note]()
    var isLastMeasure: Bool = false
    init(number:Int, notes:[Note], isLastMeasure:Bool) {
        self.number = number
        self.notes = notes
        self.isLastMeasure = isLastMeasure
    }
}

class Detect{
    var song: String
    var musicScore = [Measure]()
    var currMeasure: Int
    var mic: ViewController
    init(song:String, musicScore:[Measure], currMeasure:Int, mic:ViewController) {
        self.song = song
        self.musicScore = musicScore
        self.currMeasure = 0
        self.mic = mic
    }
    
    func matchNotes() {
        // FUNCTION NEEDS TO BE CALLED FOR EVERY NEW PAGE //
        // musicScore MUST NOT BE EMPTY
        
        repeat {
            let measure: Measure = musicScore[currMeasure]
            var i = 0
            
            if !measure.notes.isEmpty { // check for non empty measure
                repeat {
                    // check if mic picks up the same note
                    if ((measure.notes[i].pitch == mic.noteNameWithSharpsLabel.text) || (measure.notes[i].pitch == mic.noteNameWithFlatsLabel.text)) {
                        i += 1 // successful detection. loop to next note in the measure.
                    }
                } while (!measure.notes[i].isLastNote)
            }
            
            currMeasure += 1 // loop to next measure in the music score
        } while (!musicScore[currMeasure].isLastMeasure)
        // if here, then we have hit the last measure on the page
        
        // STUB CODE, NEED TO LINK TO NEXT PAGE BUTTON //
        print("Have reached end of page")
    }
    
}






