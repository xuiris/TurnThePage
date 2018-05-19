//
//  Classes.swift
//  MicrophoneAnalysis
//
//  Created by Iris Xu on 5/16/18.
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
    //var duration: String = String()
    //var octave: String = String()
    var isLastNote: Bool = false
    init(pitch:String, isLastNote:Bool) {
        self.pitch = pitch
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
    init(song:String, musicScore:[Measure], currMeasure:Int) {
        self.song = song
        self.musicScore = musicScore
        self.currMeasure = 0
    }
    
    
}
