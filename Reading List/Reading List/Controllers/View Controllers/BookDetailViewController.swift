//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Jake Connerly on 6/11/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var reasonToReadTextView: UITextView!
    
    var bookController = BookController()
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let bookTitle = bookTitleTextField.text,
            let reason = reasonToReadTextView.text else { return }
        bookController.createBook(named: bookTitle, reason: reason)
        navigationController?.popToRootViewController(animated: true)
    }
    
    func updateViews() {
        guard let title = book?.title else { return }
        guard let reason = book?.reasonToRead else { return }
        bookTitleTextField.text! = title
        reasonToReadTextView.text! = reason
        self.title = title
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
