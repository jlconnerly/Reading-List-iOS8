//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Jake Connerly on 6/11/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController {
    
    //
    // MARK: - Properties
    //
    
    let bookController = BookController()

    //
    // MARK: - View LifeCycle
    //
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    //
    // MARK: - Table view data source
    //
    
    private func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        } else {
            return bookController.unreadBooks[indexPath.row]
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch (section) {
        case 0:
            return "Read Books"
        case 1:
            return "Unread Books"
        default:
            return ""
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section){
        case 0:
            return bookController.readBooks.count
        case 1:
            return bookController.unreadBooks.count
        default:
            return bookController.books.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? ReadingListTableViewCell else {return UITableViewCell()}
        let book = bookFor(indexPath: indexPath)
        cell.book = book
        cell.delegate = self
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            bookController.deleteBook(bookToDelete: bookFor(indexPath: indexPath))
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    
    //
    // MARK: - Navigation
    //
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "DetailSegue" {
            guard let bookDetailVC = segue.destination as? BookDetailViewController,
                  let selectedIndexPath = tableView.indexPathForSelectedRow else {return }
            let selectedBook = bookFor(indexPath: selectedIndexPath)
            bookDetailVC.book = selectedBook
            bookDetailVC.bookController = bookController
            
        }else if segue.identifier == "AddSegue" {
            guard let addBookVC = segue.destination as? BookDetailViewController else { return }
            addBookVC.bookController = bookController
            addBookVC.title = "Add a Book"
        }
    }
    

} // end of class

//
// MARK: - Extensions
//

extension ReadingListTableViewController: ReadingListTableViewCellDelegate {
    func toggleHasBeenRead(for cell: ReadingListTableViewCell) {
        guard let book = cell.book else { return }
        bookController.updateHasBeenRead(for: book)
        tableView.reloadData()
        cell.updateViews()
    }
}
