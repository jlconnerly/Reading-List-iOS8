//
//  ReadingListViewController.swift
//  Reading List
//
//  Created by Jake Connerly on 7/23/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let bookController = BookController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate   = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    //
    // MARK: - Navigation
    //
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailSegue" {
            guard let bookDetailVC      = segue.destination as? DetailViewController,
                  let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
            bookDetailVC.bookController = bookController
            let selectedBook = bookFor(indexPath: selectedIndexPath)
            bookDetailVC.book = selectedBook
        } else if segue.identifier == "AddBookSegue" {
            guard let addBookVC = segue.destination as? DetailViewController else { return }
            addBookVC.bookController = bookController
        }
    }
 

}

//
// MARK: - Extension TableView Data Source
//

extension ReadingListViewController: UITableViewDataSource {
    
    private func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        } else {
            return bookController.unreadBooks[indexPath.row]
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Read Books"
        case 1:
            return "Unread Books"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return bookController.readBooks.count
        case 1:
            return bookController.unreadBooks.count
        default:
            return bookController.books.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? ReadingListTableViewCell else { return UITableViewCell() }
        let book = bookFor(indexPath: indexPath)
        cell.book = book
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            bookController.deleteBook(bookToDelete: bookFor(indexPath: indexPath))
        }
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}

extension ReadingListViewController: UITableViewDelegate {
}

//
// MARK: - Etension ReadingListTableViewCellDelegate
//

extension ReadingListViewController: ReadingListTableViewCellDelegate {
    func toggleHasBeenRead(for cell: ReadingListTableViewCell) {
        guard let book = cell.book else { return }
        bookController.updateHasBeenRead(for: book)
        tableView.reloadData()
        cell.updateViews()
    }
}
