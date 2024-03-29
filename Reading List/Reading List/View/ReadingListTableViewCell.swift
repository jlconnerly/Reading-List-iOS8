//
//  ReadingListTableViewCell.swift
//  Reading List
//
//  Created by Jake Connerly on 6/11/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewCell: UITableViewCell {
    
    //
    // MARK: - Outlets and Properties
    //
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var readUnreadButton: UIButton!
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    weak var delegate: ReadingListTableViewCellDelegate?
    
    //
    // MARK: - Actions
    //

    @IBAction func readUnreadButtonTapped(_ sender: UIButton) {
        self.delegate?.toggleHasBeenRead(for: self)
    }
    
    //
    // MARK: - Methods
    //
    
    func updateViews() {
        guard let book = book else { return }
        bookTitleLabel.text = book.title
    
        if book.hasBeenRead == true {
            readUnreadButton.setImage(UIImage(named: "checked"), for: .normal)
        } else {
            readUnreadButton.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    }

}
