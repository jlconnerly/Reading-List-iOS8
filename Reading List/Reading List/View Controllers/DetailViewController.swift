//
//  DetailViewController.swift
//  Reading List
//
//  Created by Jake Connerly on 7/23/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

  
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var reasonTextView: UITextView!
    
    var bookController: BookController?
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let book = book else { return }
        
        bookTitleTextField.text = book.title
        reasonTextView.text = book.reasonToRead
        self.title = book.title
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let bookTitle = bookTitleTextField.text,
            !bookTitle.isEmpty,
            let reason = reasonTextView.text,
            !reason.isEmpty else { return }
        bookController?.createBook(withName: bookTitle, reasonToRead: reason)
        self.dismiss(animated: true, completion: nil)
    }

}
