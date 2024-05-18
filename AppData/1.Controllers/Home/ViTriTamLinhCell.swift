//
//  ViTriTamLinhCell.swift
//  ChonCat-App
//
//  Created by Mac mini on 16/05/2024.
//

import UIKit
import MapKit
import CoreLocation

class ViTriTamLinhCell: UITableViewCell {
    
    var actXemViTri: ClosureAction?
    let locationManager = CLLocationManager()
    @IBOutlet weak var vItem: UIView!
    @IBOutlet weak var mapView: MKMapView!
    override func awakeFromNib() {
        super.awakeFromNib()
        vItem.layer.cornerRadius = myCornerRadius.c10
        
        mapView.mapType = .satellite
        
        // Yêu cầu quyền truy cập vị trí
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        // Bắt đầu cập nhật vị trí
        locationManager.startUpdatingLocation()
        
        // Thiết lập hiển thị vị trí người dùng trên bản đồ
        mapView.showsUserLocation = true
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @IBAction func btnDinhViPressed(_ sender: Any) {
        locationManager.startUpdatingLocation()
                
        // Thiết lập hiển thị vị trí người dùng trên bản đồ
        mapView.showsUserLocation = true
    }
    @IBAction func btnViTriTamLinhPressed(_ sender: Any) {
        actXemViTri?()
    }
    
}


extension ViTriTamLinhCell: CLLocationManagerDelegate {
    
    // Hàm delegate được gọi khi quyền truy cập vị trí thay đổi
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }
    
    // Hàm delegate được gọi khi cập nhật vị trí
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            // Zoom vào vị trí hiện tại
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(region, animated: true)
            
            // Dừng cập nhật vị trí để tiết kiệm pin
            locationManager.stopUpdatingLocation()
        }
    }
    
    // Hàm delegate được gọi khi có lỗi
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
}
