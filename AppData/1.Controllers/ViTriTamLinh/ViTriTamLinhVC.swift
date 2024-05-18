//
//  ViTriTamLinhVC.swift
//  ChonCat-App
//
//  Created by Mac mini on 17/05/2024.
//

import UIKit
import MapKit
import CoreLocation

class ViTriTamLinhVC: BaseVC {
    
    @IBOutlet weak var vTimKiem: UIView!
    @IBOutlet weak var tfKeySearch: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var btnViTriHT: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var completer: MKLocalSearchCompleter?
    var searchResults: [MKLocalSearchCompletion] = []
    
    
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCell(nibName: "ViTriCell")
        
        completer = MKLocalSearchCompleter()
        completer?.delegate = self
        completer?.region = MKCoordinateRegion(center: mapView.centerCoordinate, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        
        btnViTriHT.layer.cornerRadius = myCornerRadius.c10
        vTimKiem.layer.cornerRadius = myCornerRadius.c10
        
        mapView.mapType = .satellite
        
        // Yêu cầu quyền truy cập vị trí
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        // Bắt đầu cập nhật vị trí
        locationManager.startUpdatingLocation()
        
        // Thiết lập hiển thị vị trí người dùng trên bản đồ
        mapView.showsUserLocation = true
        
        
        // Thêm gesture recognizer cho mapView
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleMapTap(_:)))
        mapView.addGestureRecognizer(tapGesture)
        
    }
    @IBAction func backPressed(_ sender: Any) {
        onBackNav()
    }
    @IBAction func btnThemViTriTamLinhPressed(_ sender: Any) {
        self.pushVC(controller: ThemViTriTamLinhVC())
    }
    @IBAction func btnViTriHienThaiPressed(_ sender: Any) {
        locationManager.startUpdatingLocation()
        
        // Thiết lập hiển thị vị trí người dùng trên bản đồ
        mapView.showsUserLocation = true
    }

    
    @IBAction func timDiemDaLuu(_ sender: Any) {
        print(tfKeySearch.text ?? "")
    }
    
}
extension ViTriTamLinhVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ViTriCell", for: indexPath) as? ViTriCell else {return UITableViewCell()}
        
        return cell
    }
    
    
}

extension ViTriTamLinhVC: CLLocationManagerDelegate, MKLocalSearchCompleterDelegate {
    
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
    
    // Hàm xử lý sự kiện khi nhấn vào mapView
    @objc func handleMapTap(_ gestureRecognizer: UITapGestureRecognizer) {
        // Lấy vị trí nhấn trên màn hình
        
        let locationInView = gestureRecognizer.location(in: mapView)
        
        // Chuyển đổi vị trí từ view sang toạ độ trên map
        let coordinate = mapView.convert(locationInView, toCoordinateFrom: mapView)
        mapView.removeAnnotations(mapView.annotations)
        
        // In ra tọa độ
        print("Tọa độ được chọn: \(coordinate.latitude), \(coordinate.longitude)")
        
        // Tạo một annotation để đánh dấu vị trí được chọn trên bản đồ
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
          print("Autocomplete failed with error: \(error.localizedDescription)")
      }
      
}

