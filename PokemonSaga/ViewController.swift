//
//  ViewController.swift
//  PokemonSaga
//
//  Created by KR DEVARAJAN NAIR on 2017/03/10.
//  Copyright © 2017 KR DEVARAJAN NAIR. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {
    
    
    @IBOutlet weak var mapView: MKMapView!
    var manager=CLLocationManager()
    var updateCount=0
    var allPokemons:[Pokemon]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mapView.delegate=self
        allPokemons=getAllPokemons()
        
        
        manager.delegate=self
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            print("authorised")
            mapView.showsUserLocation=true
            manager.startUpdatingLocation()
            
            Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: { (timer) in
                if let coord=self.manager.location?.coordinate{
                    let pokemon=self.allPokemons[Int(arc4random_uniform(UInt32(self.allPokemons.count)))]
                    let anno=PokeAnnotation(coord: coord, pokemon:pokemon)
                    
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
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        
        if annotation is MKUserLocation{
            let annoView=MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
            annoView.image=UIImage(named: "player-1")
            var frame=annoView.frame
            frame.size.height=40
            frame.size.width=40
            annoView.frame=frame
            return annoView
        }
        
        let annoView=MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        let pokemon=(annotation as! PokeAnnotation).pokemon
        annoView.image=UIImage(named: pokemon.image!)
        var frame=annoView.frame
        frame.size.height=40
        frame.size.width=40
        annoView.frame=frame
        
        return annoView
        
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

