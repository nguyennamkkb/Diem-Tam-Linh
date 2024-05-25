//
//  ViTriTamLinhVC.swift
//  ChonCat-App
//
//  Created by Mac mini on 17/05/2024.
//

import UIKit
import MapKit
import CoreLocation
import ARKit

class ViTriTamLinhVC: BaseVC {
    
    
    @IBOutlet weak var ARSCNView: ARSCNView!
    @IBOutlet weak var mapView: MKMapView!
    var completer: MKLocalSearchCompleter?
    var searchResults: [MKLocalSearchCompletion] = []
    //    var locationManager: CLLocationManager!
    
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Khởi tạo locationManager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        // Thiết lập mapView
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .followWithHeading
        
    }
    @IBAction func backPressed(_ sender: Any) {
        onBackNav()
    }
    @IBAction func btnThemViTriTamLinhPressed(_ sender: Any) {
        self.pushVC(controller: ThemViTriTamLinhVC())
    }
    @IBAction func btnViTriHienThaiPressed(_ sender: Any) {
        mapView.userTrackingMode = .followWithHeading
    }
    
}

extension ViTriTamLinhVC: CLLocationManagerDelegate {
    // Delegate method để cập nhật vị trí
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
//            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
//            mapView.setRegion(region, animated: true)
        }
    }
    // Xử lý yêu cầu quyền truy cập vị trí
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }
}
