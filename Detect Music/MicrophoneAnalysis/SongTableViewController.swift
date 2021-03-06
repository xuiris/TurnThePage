//
//  SongTableViewController.swift
//  MicrophoneAnalysis
//
//  Created by Iris Xu on 6/1/18.
//  Copyright © 2018 AudioKit. All rights reserved.
//

import UIKit
import os.log

class SongTableViewController: UITableViewController, XMLParserDelegate {
    //MARK: Properties
    
    var songs = [Song]()

    var currentMeasure = 0
    var measures = [Measure]()
    var note = Note();
    var eName: String = String()
    var duration = String()
    var octave = String()
    var pitch = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the "instructions" and sample Song data
        
        if let path = Bundle.main.url(forResource: "xmlparsingtest", withExtension: "xml")
        {
            if let parser = XMLParser(contentsOf: path)
            {
                parser.delegate = self;
                parser.parse()
                
            }
        }
        loadInstructionCell()
        
        
        //loadSampleSongs()
        //        // title of tableview
        //        let headerView:UIView = UIView(frame:
        //            CGRect(x:0, y:0, width:tableView!.frame.size.width, height:60))
        //        let headerlabel:UILabel = UILabel(frame: headerView.bounds)
        //        headerlabel.textColor = UIColor.white
        //        headerlabel.backgroundColor = UIColor.clear
        //        headerlabel.font = UIFont.systemFont(ofSize: 24)
        //        headerlabel.text = "                                                          Show all my songs"
        //        headerView.addSubview(headerlabel)
        //        headerView.backgroundColor = UIColor(red: 1, green: 165/255, blue: 0, alpha: 1)
        //        tableView?.tableHeaderView = headerView
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String: String])
    {
        eName = elementName
        if elementName == "measure"
        {
            let tempMeasure = Measure();
            
            //this is how you get attribute values
            currentMeasure = Int(attributeDict["number"]!)!
            
            tempMeasure.number = currentMeasure
            measures.append(tempMeasure)
        }
        
        if elementName == "note"
        {
            pitch = String()
            octave = String()
            duration = String()
        }
    }
    
    //2 sent by parser when reaches the end of any tag
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI amespaceURI: String?, qualifiedName qName: String?)
    {
        //if that ending tag is note, we are done making the note obj and add it to the measure
        if elementName == "note"
        {
            let note = Note()
            note.pitch = pitch
            note.octave = octave
            note.duration = duration
            //self-explanatory, and the - 1 in the index is because the xml files start counting at measure 1, not 0
            measures[currentMeasure-1].notes.append(note)
            measures[currentMeasure-1].numberOfNotes+=1
        }
        if (elementName == "part")
        {
            measures[currentMeasure-1].isLastMeasure = true;
            measures[currentMeasure-1].notes[measures[currentMeasure-1].numberOfNotes-1].isLastNote = true;
        }
    }
    //3 this is where the logic happens, this runs between the first two functions
    func parser(_ parser: XMLParser, foundCharacters string: String)
    {
        let data = string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        
        if (!data.isEmpty) {
            //this checks for note name, like A, B, or C
            if eName == "step" {
                pitch += data
            }
                //this checks for the octave, can be used later on
            else if eName == "octave" {
                octave += data
            }
                //this checks for the duration
            else if eName == "duration" {
                duration += data
            }
            //this could be used to check the type
            //else if eName == "type" {
            //type += data
            //}
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // these are visual groupings of cells within the table
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // how many rows to display given a section, each Song should have its own row
        return songs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // ******Here the data is actually loaded into the cell
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "SongTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SongTableViewCell
            else {
            fatalError("The dequeued cell is not an instance of SongTableViewCell.")
        }
        
        // Fetches the appropriate song for the data source layout.
        let song = songs[indexPath.row]
        
        // Configure the cell...
        cell.setSong(song: song)
        
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            songs.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    //MARK: Actions
    
    @IBAction func unwindToMySongList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? LibraryTableViewController {
            
            // Add new songs to "My Songs".
            let newSongs = sourceViewController.songsToAdd
            
            for s in newSongs {
                let newIndexPath = IndexPath(row: songs.count, section: 0)
                songs += [s]
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
        }
    }
    
    //MARK: Private Methods
    private func loadInstructionCell() {
        let measure0 = Measure(number: 0, notes: [Note(pitch: "A", isLastNote: false), Note(pitch: "B", isLastNote: false), Note(pitch: "C", isLastNote: false), Note(pitch: "D", isLastNote: true)], isLastMeasure: false)
        let measure1 = Measure(number: 0, notes: [Note(pitch: "E", isLastNote: false), Note(pitch: "F", isLastNote: false), Note(pitch: "G", isLastNote: true), Note(pitch: "A", isLastNote: false)], isLastMeasure: true)
        
        let instructions = Song(song: "Scales" , artist: "Unknown", genre: "Practice", musicScore: measures, currMeasure: 0, sheetJPG: ["testsong.jpg"])
        
        songs += [instructions]
    }
    
    private func loadSampleSongs() {
        
        let measure0 = Measure(number: 0, notes: [Note(pitch: "A", isLastNote: false), Note(pitch: "B", isLastNote: false), Note(pitch: "C", isLastNote: false), Note(pitch: "D", isLastNote: true)], isLastMeasure: false)
        let measure1 = Measure(number: 0, notes: [Note(pitch: "E", isLastNote: false), Note(pitch: "F", isLastNote: false), Note(pitch: "G", isLastNote: true), Note(pitch: "A", isLastNote: false)], isLastMeasure: true)
        
        let song1 = Song(song: "Test Song 1 (2 pages)", artist: "Artist 1", genre: "Practice", musicScore: [measure0, measure1, measure0, measure1], currMeasure: 0, sheetJPG: ["testsong.jpg", "jinglebells.jpg"])
        let song2 = Song(song: "Test Song 2 (1 page)", artist: "Artist 2", genre: "Christmas", musicScore: [measure0, measure1], currMeasure: 0, sheetJPG: ["jinglebells.jpg"])
        let song3 = Song(song: "Test Song 3 (1 page)", artist: "Artist 3", genre: "Practice", musicScore: [measure0, measure1], currMeasure: 0, sheetJPG: ["testsong.jpg"])
        
        songs += [song1, song2, song3]
    }

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            case "ViewLibrary":
                os_log("Viewing library.", log: OSLog.default, type: .debug)
            
            case "BeginDetect":
                // Get the new view controller using segue.destinationViewController.
                guard let songDetailViewController = segue.destination as? SongViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")
                }
                
                guard let selectedSongCell = sender as? SongTableViewCell else {
                    fatalError("Unexpected sender: \(sender)")
                }
                
                guard let indexPath = tableView.indexPath(for: selectedSongCell) else {
                    fatalError("The selected cell is not being displayed by the table")
                }
                
                let selectedSong = songs[indexPath.row]
                songDetailViewController.music = selectedSong
                // Pass the selected object to the new view controller.
            
            default:
                fatalError("Unexpected Segue Identifier; \(segue.identifier)")
            }
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */




    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
 

}
