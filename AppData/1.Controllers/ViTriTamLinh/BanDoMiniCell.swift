//
//  BanDoMiniCell.swift
//  ChonCat-App
//
//  Created by Mac mini on 18/05/2024.
//

import UIKit
import MapKit
import CoreLocation


class BanDoMiniCell: UITableViewCell {
    
    @IBOutlet weak var tfKeySearch: UITextField!
    @IBOutlet weak var btnViTriHienTai: UIButton!
    @IBOutlet weak var vTimKiem: UIView!
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    var completer: MKLocalSearchCompleter?
    //    var searchResults: [MKLocalSearchCompletion] = []
    var searchResults: [MKMapItem] = []
    
    var currentLocation: CLLocation?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vTimKiem.layer.cornerRadius = myCornerRadius.c10
        btnViTriHienTai.layer.cornerRadius = myCornerRadius.c10
        mapView.layer.cornerRadius = myCornerRadius.c10
        mapView.layer.cornerRadius = myCornerRadius.c5
        setupTable()
        setupMap()
        setupLocation()

        

    }
    func setupLocation(){
        // Yêu cầu quyền truy cập vị trí
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        // Bắt đầu cập nhật vị trí
        locationManager.startUpdatingLocation()
    }
    func setupTable(){
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.registerCell(nibName: "TraVeTimKiemCell")
    }
    func setupMap(){
        // Thiết lập delegate cho mapView
        mapView.delegate = self
        mapView.mapType = .satellite
        // Thêm gesture recognizer cho mapView
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleMapTap(_:)))
        mapView.addGestureRecognizer(tapGesture)
        // Thiết lập hiển thị vị trí người dùng trên bản đồ
        mapView.showsUserLocation = true
        
    }
    @IBAction func btnTimKiemPressed(_ sender: Any) {
        guard let query = tfKeySearch.text, !query.isEmpty else {
            return
        }
        performSearch(query: query)
    }
    
    @IBAction func btnVitriHienTaiPressed(_ sender: Any) {
        // Thiết lập hiển thị vị trí người dùng trên bản đồ
        mapView.showsUserLocation = true
        
        // Thêm nút quay về vị trí hiện tại
        centerToCurrentLocation()
    }
    func performSearch(query: String) {
        guard let location = currentLocation else {
               print("Current location is not available")
               return
           }
           
           let searchRequest = MKLocalSearch.Request()
           searchRequest.naturalLanguageQuery = query
           searchRequest.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
           
           let search = MKLocalSearch(request: searchRequest)
           search.start { [weak self] response, error in
               guard let self = self, let response = response else {
                   if let error = error {
                       print("Error during search: \(error.localizedDescription)")
                   }
                   return
               }
               
               self.searchResults = response.mapItems
               if self.searchResults.count > 0 {
                   tableView.isHidden = false
                   DispatchQueue.main.async {
                       self.tableView.reloadData()
                   }
               }
               
           }
       
    }
    
}
extension BanDoMiniCell: CLLocationManagerDelegate {
    // Hàm delegate được gọi khi quyền truy cập vị trí thay đổi
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }
    
    // Hàm delegate được gọi khi cập nhật vị trí
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            currentLocation = location
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(region, animated: true)
            locationManager.stopUpdatingLocation()
        }
    }
    
    // Hàm delegate được gọi khi có lỗi
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
    // Hành động quay về vị trí hiện tại
    func centerToCurrentLocation() {
        guard let location = currentLocation else {
            print("Current location is not available")
            return
        }
        
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }
    
}
extension BanDoMiniCell: MKMapViewDelegate {
    // Hàm xử lý sự kiện khi nhấn vào mapView
    @objc func handleMapTap(_ gestureRecognizer: UITapGestureRecognizer) {
        // Lấy vị trí nhấn trên màn hình
        tableView.isHidden = true
        let locationInView = gestureRecognizer.location(in: mapView)
        
        // Chuyển đổi vị trí từ view sang toạ độ trên map
        let coordinate = mapView.convert(locationInView, toCoordinateFrom: mapView)
        
        // In ra tọa độ
        print("Tọa độ được chọn: \(coordinate.latitude), \(coordinate.longitude)")
        mapView.removeAnnotations(mapView.annotations)
        // Tạo một annotation để đánh dấu vị trí được chọn trên bản đồ
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
}

extension BanDoMiniCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return searchResults.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TraVeTimKiemCell", for: indexPath) as? TraVeTimKiemCell else {
                return UITableViewCell()
            }
            let searchResult = searchResults[indexPath.row]
            let mapItem = searchResults[indexPath.row]
            cell.bindData(tieuDe: searchResult.name ?? "", phuDe: searchResult.placemark.title ?? "")
            cell.actTap = {
                [weak self] in
                guard let self = self else {return}
                self.showOnMap(mapItem)
            }
            return cell
        }
        func showOnMap(_ mapItem: MKMapItem) {
            mapView.removeAnnotations(mapView.annotations)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = mapItem.placemark.coordinate
            annotation.title = mapItem.name
            annotation.subtitle = mapItem.placemark.title
            mapView.addAnnotation(annotation)
            
            let region = MKCoordinateRegion(center: mapItem.placemark.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(region, animated: true)
            tableView.isHidden = true
        }
}
