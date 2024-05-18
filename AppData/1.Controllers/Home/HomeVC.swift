//
//  HomeVC.swift
//  LN POS
//
//  Created by Mac mini on 15/05/2024.
//

import UIKit
import MapKit
import CoreLocation


class HomeVC: BaseVC {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
  
    func setupUI(){
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.registerCells(cells: ["LichVanNienCell","HomeSuKienCell","ViTriTamLinhCell"])

    }
}

extension HomeVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let i = indexPath.row
        switch i {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "LichVanNienCell", for: indexPath) as? LichVanNienCell else { return UITableViewCell()}
            cell.actXemLich = {
                [weak self] in
                guard let self = self else {return}
                
                self.pushVC(controller: LichAmDuongVC())
            }
          
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeSuKienCell", for: indexPath) as? HomeSuKienCell else { return UITableViewCell()}
            return cell
            
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ViTriTamLinhCell", for: indexPath) as? ViTriTamLinhCell else { return UITableViewCell()}
            
            
            cell.actXemViTri = {
                [weak self] in
                guard let self = self else {return}
                
                self.pushVC(controller: ViTriTamLinhVC())
            }
            return cell
            
            
        default:
            return UITableViewCell()
        }
     
        
       
    }
    
    
}
