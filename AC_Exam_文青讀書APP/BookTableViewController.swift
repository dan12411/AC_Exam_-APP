//
//  BookTableViewController.swift
//  AC_Exam_文青讀書APP
//
//  Created by 洪德晟 on 2016/11/11.
//  Copyright © 2016年 洪德晟. All rights reserved.
//

import UIKit
import Firebase

class BookTableViewController: UITableViewController {
    
    // MARK: Properties
    var books: [Book] = []
    var ref: FIRDatabaseReference?
    
    // 下拉更新
    @IBAction func refresh(_ sender: UIRefreshControl) {
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        //MARK: - Retrieving Data (取得資料!!)
        //When the change occurs, the database updates the app with the most recent data.
        ref = FIRDatabase.database().reference(withPath: "AC-books")
        // 1. Attach a listener to receive updates
        ref?.observe(.value, with: { snapshot in
            // 2. Store the latest version of the data in a local variable
            var newItems: [Book] = []
            
            // 3. loop through the grocery items
            for item in snapshot.children {
                // 4.
                let bookItem = Book(snapshot: item as! FIRDataSnapshot)
                newItems.append(bookItem)
            }
            
            // 5. Reassign items to the latest version of the data
            self.books = newItems
            self.tableView.reloadData()
        })
        
        //MARK: - Sorting the Grocery List(排序資料!!)
        // call queryOrdered(byChild:) on the Firebase reference, which takes a key to order by.
        ref?.queryOrdered(byChild: "createdAt").observe(.value, with: { snapshot in
            var newItems: [Book] = []
            
            for item in snapshot.children {
                let bookItem = Book(snapshot: item as! FIRDataSnapshot)
                newItems.append(bookItem)
            }
            
            self.books = newItems
            self.books = self.books.reversed()
            self.tableView.reloadData()
        })
    }
    
    @IBAction func addBook(_ sender: UIBarButtonItem) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return books.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BookTableViewCell
        
        cell.bookNameLabel.text = books[indexPath.row].name
        cell.bookImage.image = UIImage(named: books[indexPath.row].photo)
        
        return cell
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    //MARK:- (Delete Item)刪除資料!!
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // 找到要刪掉的資料
            let bookItem = books[indexPath.row]
            // calling removeValue() on that reference
            bookItem.ref?.removeValue()
        }
    }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
     // MARK: - Navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let dvc = segue.destination as? DetailTableViewController
                dvc?.book = books[indexPath.row]
            }
        }
     }
     
    
}
