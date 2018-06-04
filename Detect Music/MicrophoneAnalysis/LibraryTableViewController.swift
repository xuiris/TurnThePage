//
//  LibraryTableViewController.swift
//  MicrophoneAnalysis
//
//  Created by Iris Xu on 6/3/18.
//  Copyright © 2018 AudioKit. All rights reserved.
//

import UIKit
import os.log

class LibraryTableViewController: UITableViewController, LibraryCellDelegate {
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var librarySongs = [Song]()
    var songsToAdd = [Song]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadLibrarySongs()
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
        return librarySongs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // ******Here the data is actually loaded into the cell
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "LibraryTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? LibraryTableViewCell  else {
            fatalError("The dequeued cell is not an instance of LibraryTableViewCell.")
        }
        
        // Fetches the appropriate song for the data source layout.
        let song = librarySongs[indexPath.row]
        
        // Configure the cell...
        cell.setSong(song: song)
        cell.delegate = self
        
        return cell
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
    }
    
    // My functions:
    private func loadLibrarySongs() {
        
        let measure0 = Measure(number: 0, notes: [Note(pitch: "A", isLastNote: false), Note(pitch: "B", isLastNote: false), Note(pitch: "C", isLastNote: false), Note(pitch: "D", isLastNote: true)], isLastMeasure: false)
        let measure1 = Measure(number: 0, notes: [Note(pitch: "E", isLastNote: false), Note(pitch: "F", isLastNote: false), Note(pitch: "G", isLastNote: true), Note(pitch: "A", isLastNote: false)], isLastMeasure: true)
        
        let song1 = Song(song: "Test Song 1 (2 pages)", artist: "Artist 1", musicScore: [measure0, measure1, measure0, measure1], currMeasure: 0, sheetJPG: ["testsong.jpg", "jinglebells.jpg"])
        let song2 = Song(song: "Test Song 2 (1 page)", artist: "Artist 2", musicScore: [measure0, measure1], currMeasure: 0, sheetJPG: ["testsong.jpg"])
        let song3 = Song(song: "Test Song 3 (1 page)", artist: "Artist 3", musicScore: [measure0, measure1], currMeasure: 0, sheetJPG: ["testsong.jpg"])
        
        librarySongs += [song1, song2, song3]
    }
    
    func addSong(song: Song) {
        songsToAdd += [song]
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
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
