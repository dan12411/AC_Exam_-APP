//
//  Book.swift
//  AC_Exam_文青讀書APP
//
//  Created by 洪德晟 on 2016/11/11.
//  Copyright © 2016年 洪德晟. All rights reserved.
//

import Foundation
import Firebase

class Book {
    let key: String
    let ref: FIRDatabaseReference?
    let createdAt: String
    var name = ""
    var photo = ""
    var address = ""
    var phone = ""
    var website = ""
    var description = ""
    
    init (key: String = "", createdAt: String = "", name: String, photo: String, address: String, phone: String, website : String, description: String) {
        self.key = key
        self.ref = nil
        self.createdAt = createdAt
        self.name = name
        self.photo = photo
        self.address = address
        self.phone = phone
        self.website = website
        self.description = description
    }
    
    // ????
    init(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        createdAt = snapshotValue["createdAt"] as! String
        name = snapshotValue["name"] as! String
        photo = snapshotValue["photo"] as! String
        address = snapshotValue["address"] as! String
        phone = snapshotValue["phone"] as! String
        website = snapshotValue["website"] as! String
        description = snapshotValue["description"] as! String
        ref = snapshot.ref
    }
    
    // 用來存入至資料庫
    func toAnyObject() -> Any {
        return [
            "createdAt": createdAt,
            "name": name,
            "photo": photo,
            "address": address,
            "phone": phone,
            "website": website,
            "description": description
        ]
    }
}
