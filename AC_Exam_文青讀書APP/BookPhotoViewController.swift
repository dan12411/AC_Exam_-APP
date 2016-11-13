//
//  BookPhotoViewController.swift
//  AC_Exam_文青讀書APP
//
//  Created by 洪德晟 on 2016/11/13.
//  Copyright © 2016年 洪德晟. All rights reserved.
//

import UIKit

class BookPhotoViewController: UIViewController, UIScrollViewDelegate {
    
    var book: Book?

    @IBOutlet weak var myScrollView: UIScrollView!
    @IBOutlet weak var bookImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let book = book {
        bookImage.image = UIImage(named: book.photo)
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return bookImage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
