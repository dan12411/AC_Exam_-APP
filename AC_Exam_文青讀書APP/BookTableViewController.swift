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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
        
        /*
         // Override to support conditional editing of the table view.
         override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
         // Return false if you do not want the specified item to be editable.
         return true
         }
         */
        
        /*
         // Override to support editing the table view.
         override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
         // Delete the row from the data source
         tableView.deleteRows(at: [indexPath], with: .fade)
         } else if editingStyle == .insert {
         // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
         }
         }
         */
        
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
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destinationViewController.
         // Pass the selected object to the new view controller.
         }
         */
        
}
