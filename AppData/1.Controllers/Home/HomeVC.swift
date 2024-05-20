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
    func shareText(_ text: String) {
        let activityViewController = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        
        if let popoverController = activityViewController.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        self.present(activityViewController, animated: true, completion: nil)
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
            cell.actChiaSe = {
                [weak self] s in
                guard let self = self else {return}
                self.shareText(s)
            }
            cell.actEdit = {
                [weak self] e in
                guard let self = self else {return}
                let vc = ThemSuKienVC()
                vc.bindData(e: e)
                vc.actThanhCong = {

                    cell.setupTableSuKien()
                }
                self.pushVC(controller: vc)
            }
            cell.actAdd = {
                [weak self] in
                guard let self = self else {return}
                let vc = ThemSuKienVC()
                vc.actThanhCong = {
                    cell.setupTableSuKien()
                }
                self.pushVC(controller: vc)
            }
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
