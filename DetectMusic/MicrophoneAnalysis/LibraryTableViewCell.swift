//
//  LibraryTableViewCell.swift
//  MicrophoneAnalysis
//
//  Created by Iris Xu on 6/3/18.
//  Copyright © 2018 AudioKit. All rights reserved.
//

import UIKit

protocol LibraryCellDelegate {
    func addSong(song: Song)
}

class LibraryTableViewCell: UITableViewCell {

    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
    var songItem: Song!
    var delegate: LibraryCellDelegate?
    
    func setSong(song: Song) {
        songLabel.text = song.song
        artistLabel.text = song.artist
        songItem = song
    }
    
    @IBAction func addSongClicked(_ sender: Any) {
        delegate?.addSong(song: songItem)
        let disableMyButton = sender as? UIButton
        disableMyButton?.isEnabled = false
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
