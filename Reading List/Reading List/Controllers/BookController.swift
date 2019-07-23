//
//  BookController.swift
//  Reading List
//
//  Created by Jake Connerly on 7/23/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    //
    // MARK: - Properties
    //
    
    private(set) var books: [Book] = []
    
    var readBooks: [Book] {
        let readBooksArray = books.filter { $0.hasBeenRead == true }
        return readBooksArray
    }
    
    var unreadBooks: [Book] {
        let unreadBooksArray = books.filter { $0.hasBeenRead == false }
        return unreadBooksArray
    }
    
    
    
    //
    // MARK: - Private Methods
    //
    
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return directory.appendingPathComponent("readinglist.plist")
    }
    
    //
    // MARK: - Persistance Methods
    //
    
    func saveToPersistantStore() {
        guard let url = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(books)
            try data.write(to: url)
        } catch {
            print("Error saving books: \(error)")
        }
    }
    
    func loadFromPersistantStore() {
        let fileManager = FileManager.default
        guard let url = readingListURL,
                  fileManager.fileExists(atPath: url.path) else { return }
        
        do {
            let decoder = PropertyListDecoder()
            let data = try Data(contentsOf: url)
            let decodedBooks = try decoder.decode([Book].self, from: data)
            books = decodedBooks
        } catch {
            print("Error loading books: \(error)")
        }
    }
    
    //
    // MARK: - CRUD Methods
    //
    
    func createBook(withName name: String, reasonToRead reason: String) {
        let book = Book(title: name, reasonToRead: reason)
        books.append(book)
        saveToPersistantStore()
    }
    
    func deleteBook(bookToDelete deleteBook: Book) {
        var index = 0
        for book in books {
            if book.title == deleteBook.title {
                books.remove(at: index)
                saveToPersistantStore()
            } else{
                index += 1
            }
        }
    }
    
    func updateHasBeenRead(for bookToUpdate: Book) {
        var index = 0
        for book in books {
            if book.title == bookToUpdate.title {
                books[index].hasBeenRead.toggle()
            }else {
                index += 1
            }
        }
    }
    
    func editBookInfo(for bookToEdit: Book, withTitle title: String, withReason reason: String) {
        var index = 0
        for book in books {
            if book.title == bookToEdit.title {
                books[index].title = title
                books[index].reasonToRead = reason
            }else {
                index += 1
            }
        }
    }
    
}
