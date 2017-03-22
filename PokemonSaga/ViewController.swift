//
//  ViewController.swift
//  PokemonSaga
//
//  Created by KR DEVARAJAN NAIR on 2017/03/10.
//  Copyright © 2017 KR DEVARAJAN NAIR. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController,CLLocationManagerDelegate {
    
    
    @IBOutlet weak var mapView: MKMapView!
    var manager=CLLocationManager()
    var updateCount=0
    var allPokemons:[Pokemon]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        allPokemons=getAllPokemons()
        
        
        manager.delegate=self
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            print("authorised")
            mapView.showsUserLocation=true
            manager.startUpdatingLocation()
            
            Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: { (timer) in
                if let coord=self.manager.location?.coordinate{
                    let anno=MKPointAnnotation()
                    anno.coordinate=coord
                    let longi=(Double(arc4random_uniform(200))-100.0)/500000.0
                    let latti=(Double(arc4random_uniform(200))-100.0)/500000.0
                    anno.coordinate.latitude+=latti
                    anno.coordinate.longitude+=longi
                    self.mapView.addAnnotation(anno)
                }
            })
        }
        else{
            manager.requestWhenInUseAuthorization()
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if updateCount<3{
            let region=MKCoordinateRegionMakeWithDistance((manager.location?.coordinate)!, 300, 300)
            mapView.setRegion(region, animated: true)
            updateCount+=1
        }else{
            manager.stopUpdatingLocation() // not to stop the map moving,but just to save the battery life
        }
    }
    
    @IBAction func btnRelocate(_ sender: AnyObject) {
        if let coord=manager.location?.coordinate{
            let region=MKCoordinateRegionMakeWithDistance((coord), 300, 300)
            mapView.setRegion(region, animated: true)
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

