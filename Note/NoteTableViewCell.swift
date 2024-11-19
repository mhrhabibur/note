//
//  NoteTableViewCell.swift
//  Note
//
//  Created by Habibur Rahman on 11/15/24.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
