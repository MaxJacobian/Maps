//
//  MapsViewController.swift
//  hw_10
//
//  Created by Максим Нечеперунко on 06.09.2021.
//



import UIKit
import GoogleMaps
import GooglePlaces

class MapsViewController: UIViewController {
    
    
    let locManager = CLLocationManager()
    var userLocation: CLLocationCoordinate2D?
    var preciseLocationZoomLevel: Float = 15.0
    var approximateLocationZoomLevel: Float = 10.0

    @IBOutlet weak var mapView: GMSMapView!
    
    var places: [PlaceG] = [
        PlaceG(coordinate: CLLocationCoordinate2D(latitude: 37.8199922, longitude: -122.4776436), image: UIImage(named: "bridge")!, name: "Golden Gate Bridge"),
        PlaceG(coordinate: CLLocationCoordinate2D(latitude: 37.80236686646559, longitude: -122.40586793291813), image: UIImage(named: "coit")!, name: "Coit Tower"),
        PlaceG(coordinate: CLLocationCoordinate2D(latitude: 37.77653661026273, longitude: -122.43287914054896), image: UIImage(named: "lady")!, name: "The Painted Ladies"),
        PlaceG(coordinate: CLLocationCoordinate2D(latitude: 37.803740483072616, longitude: -122.44802359443416), image: UIImage(named: "arts")!, name: "The place of Fine Arts"),
        PlaceG(coordinate: CLLocationCoordinate2D(latitude: 37.827710994231744, longitude: -122.42227035442882), image: UIImage(named: "alcatraaz")!, name: "Alcatraz Island")
    ]
    
    @IBAction func center(_ sender: Any) {
        let zoomLevel = locManager.accuracyAuthorization == .fullAccuracy ? preciseLocationZoomLevel : approximateLocationZoomLevel
        let camera = GMSCameraPosition.camera(withLatitude: userLocation!.latitude, longitude: userLocation!.longitude, zoom: zoomLevel)
        mapView.animate(to: camera)
    }
    
    @IBAction func plus(_ sender: Any) {
       
        let camera = GMSCameraPosition.camera(withLatitude: mapView.camera.target.latitude, longitude: mapView.camera.target.longitude, zoom: mapView.camera.zoom*1.1)
        mapView.animate(to: camera)
        
    }
    
    @IBAction func minus(_ sender: Any) {
        let camera = GMSCameraPosition.camera(withLatitude: mapView.camera.target.latitude, longitude: mapView.camera.target.longitude, zoom: mapView.camera.zoom/1.1)
        mapView.animate(to: camera)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        locManager.requestWhenInUseAuthorization()
        locManager.startUpdatingLocation()
        locManager.delegate = self
        
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
        
        mapView.settings.consumesGesturesInView = false
        mapView.settings.zoomGestures = false
        
        
        mapView.camera = GMSCameraPosition(target: CLLocationCoordinate2D(latitude: places[4].coordinate.latitude, longitude: places[4].coordinate.longitude), zoom: 12)
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        for plac in places {
            let places = GMSMarker(position: CLLocationCoordinate2D(latitude: plac.coordinate.latitude, longitude: plac.coordinate.longitude))
            places.icon = plac.image
            places.snippet = plac.name
            places.map = mapView
        }
    }
}
extension MapsViewController: GMSMapViewDelegate, CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.last!.coordinate
    }
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print((marker.snippet!))
        return true
    }
    func locationManager(manager:CLLocationManager, didUpdateLocations locations:[AnyObject]) {
        locManager.stopUpdatingLocation()}
    
    
}

