//
//  ReadingListTableViewCell.swift
//  Reading List
//
//  Created by Jake Connerly on 7/23/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewCell: UITableViewCell {


    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var readButton: UIButton!
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    @IBAction func readButtonTapped(_ sender: UIButton) {
        self.delegate?.toggleHasBeenRead(for: self)
    }
    
    weak var delegate: ReadingListTableViewCellDelegate?
    
    func updateViews() {
        guard let book = book else { return }
        
        bookTitleLabel.text = book.title
        
        if book.hasBeenRead == true {
            readButton.setImage(UIImage(named: "checked"), for: .normal)
        }else {
            readButton.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    }
}
