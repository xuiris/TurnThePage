//
//  TableViewController.swift
//  XMLParser
//
//  Created by marcus on 5/18/18.
//  Copyright © 2018 TurnThePage. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, XMLParserDelegate{
    
    
    var currentMeasure = 0
    var measures = [Measure]()
    var note = Note();
    
    var eName: String = String()
    
    var duration = String()
    var octave = String()
    var pitch = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        if let path = Bundle.main.url(forResource: "xmlparsingtest", withExtension: "xml")
        {
            if let parser = XMLParser(contentsOf: path)
            {
                parser.delegate = self;
                parser.parse()
                
            }}
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
	        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return measures.count;
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "yes", for: indexPath)
        
        // Configure the cell...
        let measure = measures[indexPath.row]
        var notes_ = String()
        cell.textLabel?.text = "\(measure.number)"
        for x in measure.notes {
            notes_.append(x.pitch)
            notes_.append(x.octave)
            notes_.append(" ")
        }
        cell.detailTextLabel?.text = notes_
        return cell
    }
    
    //now 3 parser functions
    
    //1: sent by parser when it reaches the start of every tag
    //create a Measure
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
}
   
