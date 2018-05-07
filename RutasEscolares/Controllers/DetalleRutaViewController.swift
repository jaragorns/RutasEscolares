//
//  DetalleRutaViewController.swift
//  RutasEscolares
//
//  Created by Jonathan Silva on 6/05/18.
//  Copyright © 2018 Jonathan Silva. All rights reserved.
//

import UIKit
import Alamofire
import GoogleMaps

class DetalleRutaViewController: UIViewController {
    
    // MARK: Params & References
    @IBOutlet weak var mapView: GMSMapView!
    private let locationManager = CLLocationManager()
    var nameRuta = String()
    var descriptionRuta = String()
    var stopsUrl = String()
    var stops = DataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        self.title = self.descriptionRuta
    }
    
    override func viewDidAppear(_ animated: Bool) {
        Alamofire.request(stopsUrl).responseJSON { response in
            if let answer = response.result.value as? [String : Any] {
                self.stops = DataSource(JSON: answer)!
                self.loadStops(stops: self.stops)
            } else {
                print("ERROR LOADING STOPS")
            }
        }
    }
    func loadStops(stops: DataSource) {
        
        var zoom = 15
        
        if nameRuta != "Ruta 01" {
            zoom = 14
        }
        
        let setInitialPosition = stops.stops[0]
        let camera = GMSCameraPosition.camera(withLatitude: setInitialPosition.latitude,
                                              longitude: setInitialPosition.longitude,
                                              zoom: Float(zoom))
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        
        for stop in stops.stops {
            let position = CLLocationCoordinate2D(latitude: stop.latitude, longitude: stop.longitude)
            let marker = GMSMarker(position: position)
            marker.appearAnimation = GMSMarkerAnimation.pop
            marker.map = mapView
        }
        self.view = mapView
    }
    
}

extension DetalleRutaViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        guard status == .authorizedWhenInUse else {
            return
        }
        
        locationManager.startUpdatingLocation()
        
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        
        locationManager.stopUpdatingLocation()
    }
}
