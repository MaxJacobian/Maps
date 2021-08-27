//
//  ViewController.swift
//  hw_10
//
//  Created by Максим Нечеперунко on 22.08.2021.
//

import UIKit
import MapKit

class ViewController: UIViewController{
    
    var userLocation: CLLocationCoordinate2D?
    let locManager = CLLocationManager()
    
    var places: [Place] = [
        Place(coordinate: CLLocationCoordinate2D(latitude: 37.8199922, longitude: -122.4776436), image: UIImage(named: "bridge")!, name: "Golden Gate Bridge"),
        Place(coordinate: CLLocationCoordinate2D(latitude: 37.80236686646559, longitude: -122.40586793291813), image: UIImage(named: "coit")!, name: "Coit Tower"),
        Place(coordinate: CLLocationCoordinate2D(latitude: 37.77653661026273, longitude: -122.43287914054896), image: UIImage(named: "lady")!, name: "The Painted Ladies"),
        Place(coordinate: CLLocationCoordinate2D(latitude: 37.803740483072616, longitude: -122.44802359443416), image: UIImage(named: "arts")!, name: "The place of Fine Arts"),
        Place(coordinate: CLLocationCoordinate2D(latitude: 37.827710994231744, longitude: -122.42227035442882), image: UIImage(named: "alcatraaz")!, name: "Alcatraz Island")
    ]
    
    
    
    @IBOutlet weak var mapView: MKMapView!

    @IBAction func centerForMe(_ sender: Any) {
        let me = MKCoordinateRegion(center: userLocation ?? CLLocationCoordinate2D(latitude: 0, longitude: 0), latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(me, animated: true)
    }
    @IBAction func plus(_ sender: Any) {
        let reg  = MKCoordinateRegion(center: mapView.region.center, span: MKCoordinateSpan(latitudeDelta: mapView.region.span.latitudeDelta*0.7, longitudeDelta: mapView.region.span.longitudeDelta*0.7))
        mapView.setRegion(reg, animated: true)

    }
    
    @IBAction func minus(_ sender: Any) {
        let reg  = MKCoordinateRegion(center: mapView.region.center, span: MKCoordinateSpan(latitudeDelta: mapView.region.span.latitudeDelta/0.7, longitudeDelta: mapView.region.span.longitudeDelta/0.7))
        mapView.setRegion(reg, animated: true)
    }
    
  override func viewDidLoad() {
        super.viewDidLoad()
    
        mapView.delegate = self
        mapView.addAnnotations(places)
        
        locManager.delegate = self
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        locManager.requestWhenInUseAuthorization()
        locManager.startUpdatingLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Focus on Sights
        let region =  MKCoordinateRegion(center: places[0].coordinate, latitudinalMeters: 15000, longitudinalMeters: 15000)
        mapView.setRegion(region, animated: true)
    }

}

// Extensions
extension ViewController: CLLocationManagerDelegate, MKMapViewDelegate {
   
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {return nil}
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotionView") ?? MKAnnotationView()
        if let place = annotation as? Place {
            annotationView.image = place.image
        }
        return annotationView
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print((view.annotation as! Place).name)
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let locValue: CLLocationCoordinate2D = manager.location?.coordinate {
            userLocation = locValue
        }
        else { return }
    }

    func locationManager(manager:CLLocationManager, didUpdateLocations locations:[AnyObject]) {
            locManager.stopUpdatingLocation()}
}

