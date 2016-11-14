//
//  MapViewController.swift
//  AC_Exam_文青讀書APP
//
//  Created by 洪德晟 on 2016/11/13.
//  Copyright © 2016年 洪德晟. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    var book: Book?
    
    @IBOutlet weak var myMap: MKMapView!
    
    // Create LocationManager for Map
    let locationManger = CLLocationManager()
    
    let geoCoder = CLGeocoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Auth for Map
        self.locationManger.requestWhenInUseAuthorization()
        
        if let book = book {
            self.geoCoder.geocodeAddressString(book.address) {
                (places, error) in
                
                if (places?.count)! > 0 {
                    let placeMark = places?.first
                    print("====Location: \(placeMark?.location)====")
                    
                    // 加大頭針
                    let annotation = MKPointAnnotation()
                    annotation.title = "GG"
                    annotation.subtitle = "GGG"
                    annotation.coordinate = (placeMark?.location?.coordinate)!
                    self.myMap.addAnnotation(annotation)
                    
                }
            }
        }
        
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

// MARK: - MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        
        let region = MKCoordinateRegion(center: (userLocation.location!.coordinate), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
        
        self.myMap.region = region
        
        self.geoCoder.reverseGeocodeLocation(userLocation.location!) {
            (places, error) in
            
            if (places?.count)! > 0 {
                let placeMark = places?.first
                
                for (key, value) in (placeMark?.addressDictionary)! {
                    print("======key: \(key), value: \(value)=====")
                }
                let addressArray = placeMark?.addressDictionary?["FormattedAddressLines"] as! [String]
                for address in addressArray {
                    print("=====Address: \(address)======")
                }
            }
        }
    }
}

