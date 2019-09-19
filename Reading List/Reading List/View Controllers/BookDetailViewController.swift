//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Jake Connerly on 6/11/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    //
    //MARK: - IBOutlets and Properties
    //
    
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var reasonToReadTextView: UITextView!
    
    var bookController: BookController?
    
    var book: Book? {
        didSet {
            if let _ = view {
                updateViews()
            }

        }
    }
    
    //
    //MARK: - IBActions & Methods
    //
    

    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let bookTitle      = bookTitleTextField.text,
              let reason         = reasonToReadTextView.text,
              let bookController = bookController else { return }
        bookController.createBook(named: bookTitle, reason: reason)
        navigationController?.popToRootViewController(animated: true)
    }
    
    func updateViews() {
        
        guard let book = book else { return }
   
        bookTitleTextField.text = book.title
        reasonToReadTextView.text = book.reasonToRead
        self.title = title
    }


}
