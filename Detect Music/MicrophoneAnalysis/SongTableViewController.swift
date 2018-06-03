//
//  SongTableViewController.swift
//  MicrophoneAnalysis
//
//  Created by Iris Xu on 6/1/18.
//  Copyright © 2018 AudioKit. All rights reserved.
//

import UIKit
import os.log

class SongTableViewController: UITableViewController {
    //MARK: Properties
    
    var songs = [Song]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Load the sample Song data
        loadSampleSongs()
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SongTableViewCell  else {
            fatalError("The dequeued cell is not an instance of SongTableViewCell.")
        }
        
        // Fetches the appropriate song for the data source layout.
        let song = songs[indexPath.row]
        
        // Configure the cell...
        cell.songLabel.text = song.song
        cell.artistLabel.text = song.artist
        
        return cell
    }
    
    //MARK: Private Methods
    
    private func loadSampleSongs() {
        
        let measure0 = Measure(number: 0, notes: [Note(pitch: "A", isLastNote: false), Note(pitch: "B", isLastNote: false), Note(pitch: "C", isLastNote: false), Note(pitch: "D", isLastNote: true)], isLastMeasure: false)
        let measure1 = Measure(number: 0, notes: [Note(pitch: "E", isLastNote: false), Note(pitch: "F", isLastNote: false), Note(pitch: "G", isLastNote: true), Note(pitch: "A", isLastNote: false)], isLastMeasure: true)
        
        
        let song1 = Song(song: "JingleBells", artist: "Artist1", musicScore: [measure0, measure1], currMeasure: 0)
        let song2 = Song(song: "Song2", artist: "Artist2", musicScore: [measure0, measure1], currMeasure: 0)
        let song3 = Song(song: "Song3", artist: "Artist3", musicScore: [measure0, measure1], currMeasure: 0)
        
        songs += [song1, song2, song3]
    }

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            case "ViewImage":
                os_log("Viewing image.", log: OSLog.default, type: .debug)
            
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
