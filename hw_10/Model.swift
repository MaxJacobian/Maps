//
//  Model.swift
//  hw_10
//
//  Created by Максим Нечеперунко on 26.08.2021.
//

import Foundation
import MapKit
import GoogleMaps


class Place: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    let image: UIImage
    let name: String
    let annotation = MKAnnotationView()
    init(coordinate: CLLocationCoordinate2D,image: UIImage, name: String) {
        self.coordinate = coordinate
        self.image = image
        self.name = name
    }
}
class PlaceG: GMSMarker {
    var coordinate: CLLocationCoordinate2D
    let image: UIImage
    let name: String
    
    init(coordinate: CLLocationCoordinate2D,image: UIImage, name: String) {
        self.coordinate = coordinate
        self.image = image
        self.name = name
    }
}



