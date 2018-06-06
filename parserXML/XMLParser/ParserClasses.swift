//
//  ParserClasses.swift
//  DED
//
//  Created by marcus on 5/18/18.
//  Copyright © 2018 marcus. All rights reserved.
//

import Foundation

class Note{
    var pitch: String = String()
    var duration: String = String()
    var octave: String = String()
}

class Measure{
    var number: Int = Int()
    var notes = [Note]()
    var numberOfNotes: Int = Int()
}
