//
//  TestBanDoVC.swift
//  ChonCat-App
//
//  Created by Mac mini on 21/05/2024.
//

import UIKit
import MapKit
import CoreLocation


class TestBanDoVC: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager: CLLocationManager!

    override func viewDidLoad() {
           super.viewDidLoad()

           // Khởi tạo mapView
       

           // Khởi tạo locationManager
           locationManager = CLLocationManager()
           locationManager.delegate = self
           locationManager.desiredAccuracy = kCLLocationAccuracyBest
           locationManager.requestWhenInUseAuthorization()
           locationManager.startUpdatingLocation()

           // Thiết lập mapView
           mapView.showsUserLocation = true

           // Thêm MKUserTrackingBarButtonItem vào thanh công cụ
           let trackingButton = MKUserTrackingBarButtonItem(mapView: mapView)
           navigationItem.rightBarButtonItem = trackingButton

           // Thêm một UISegmentedControl để thay đổi chế độ theo dõi người dùng
//           let segmentedControl = UISegmentedControl(items: ["None", "Follow", "Follow with Heading"])
//           segmentedControl.selectedSegmentIndex = 0
//           segmentedControl.addTarget(self, action: #selector(changeTrackingMode(_:)), for: .valueChanged)
//           segmentedControl.translatesAutoresizingMaskIntoConstraints = false
////           self.view.addSubview(segmentedControl)
//
//           // Thiết lập AutoLayout cho UISegmentedControl
//           NSLayoutConstraint.activate([
//               segmentedControl.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
//               segmentedControl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
//               segmentedControl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10)
//           ])
       }

    @IBAction func dinhHuong(_ sender: Any) {
        mapView.userTrackingMode = .none
        mapView.userTrackingMode = .followWithHeading
    }
    @objc func changeTrackingMode(_ sender: UISegmentedControl) {
           switch sender.selectedSegmentIndex {
           case 0:
               mapView.userTrackingMode = .none
           case 1:
               mapView.userTrackingMode = .follow
           case 2:
               mapView.userTrackingMode = .followWithHeading
           default:
               mapView.userTrackingMode = .none
           }
       }

       // Delegate method để cập nhật vị trí
       func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           
       }

       // Xử lý yêu cầu quyền truy cập vị trí
       func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
           if status == .authorizedWhenInUse || status == .authorizedAlways {
               locationManager.startUpdatingLocation()
           }
       }
}
