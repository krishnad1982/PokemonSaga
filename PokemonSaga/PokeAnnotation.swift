//
//  PokeAnnotation.swift
//  PokemonSaga
//
//  Created by KR DEVARAJAN NAIR on 2017/03/23.
//  Copyright © 2017 KR DEVARAJAN NAIR. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class PokeAnnotation:NSObject,MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    var pokemon:Pokemon
    init(coord:CLLocationCoordinate2D,pokemon:Pokemon) {
        self.coordinate=coord
        self.pokemon=pokemon
    }
}
