//
//  DetailTableViewController.swift
//  AC_Exam_文青讀書APP
//
//  Created by 洪德晟 on 2016/11/12.
//  Copyright © 2016年 洪德晟. All rights reserved.
//

import UIKit
import SafariServices

class DetailTableViewController: UITableViewController {
    
    var book: Book?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var test: UIButton!
    @IBOutlet weak var adressButton: UIButton!
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBAction func toWeb(_ sender: Any) {
        // 用網址產生 URL
        if let book = book {
            if let url = URL(string: book.website) {
                // 生出 SafariViewController
                let safariController = SFSafariViewController(url: url)
                // 推出 SafariViewController
                present(safariController, animated: true, completion: nil)
            }
        }
    }
    
    // make a phone call (not support at simulator)
    @IBAction func phoneCall(_ sender: Any) {
        if let book = book {
            if let url = NSURL(string: "tel://\(book.phone)"), UIApplication.shared.canOpenURL(url as URL) {
                UIApplication.shared.openURL(url as URL)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let book = book {
            adressButton.setTitle("書局地址: \(book.address)", for: .normal)
            adressButton.setTitle("", for: .highlighted)
            
            phoneButton.setTitle("書局電話: \(book.phone)", for: .normal)
            phoneButton.setTitle("", for: .highlighted)
            
            websiteLabel.text = "書本介紹網站:\n \(book.website)"
            descLabel.text = "書本簡介:\n \(book.description)"
            
            nameLabel.text = book.name
            bookImage.image = UIImage(named: (book.photo))
        }
        
        // Remove the separators of the empty rows
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        // Change the color of the separator
        tableView.separatorColor = UIColor.clear
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
    }
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
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
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showMap" {
            let dvc = segue.destination as? MapViewController
            dvc?.book = book
        }
        
        if segue.identifier == "showPhoto" {
            let dvc = segue.destination as? BookPhotoViewController
            dvc?.book = book
        }
    }
}
