//
//  SongTableViewCell.swift
//  MicrophoneAnalysis
//
//  Created by Iris Xu on 6/1/18.
//  Copyright © 2018 AudioKit. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    //MARK: Properties
    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var songImage: UIImageView!
    var songCell: Song!
     var index: Int = 0
    
    func setSong(song: Song) {
        songLabel.text = song.song
        artistLabel.text = song.artist
        songCell = song
        songImage.image = UIImage(named: song.sheetJPG[index])
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
