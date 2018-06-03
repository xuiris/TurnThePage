//
//  Classes.swift
//  MicrophoneAnalysis
//
//  Created by Iris Xu on 5/16/18.
//  Copyright © 2018 AudioKit. All rights reserved.
//

import Foundation

//class Detect{
//    var song: String
//    var musicScore = [Measure]()
//    var currMeasure: Int
//    init(song:String, musicScore:[Measure], currMeasure:Int) {
//        self.song = song
//        self.musicScore = musicScore
//        self.currMeasure = 0
//    }
//
//}

class Song{
    var song: String = String()
    var artist: String = String()
    var musicScore = [Measure]()
    var currMeasure: Int
    //var sheetPDF: String = String()
    //var sheetXML: String = String()
    init(song:String, artist:String, musicScore:[Measure], currMeasure:Int /*, sheetPDF:String, sheetXML:String*/) {
        self.song = song
        self.artist = artist
        self.musicScore = musicScore
        self.currMeasure = 0
        //self.sheetPDF = sheetPDF
        //self.sheetXML = sheetXML
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

