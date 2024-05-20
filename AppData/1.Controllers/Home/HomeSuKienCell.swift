//
//  HomeSuKienCell.swift
//  ChonCat-App
//
//  Created by Mac mini on 17/05/2024.
//

import UIKit

class HomeSuKienCell: UITableViewCell {

    var actAdd: ClosureAction?
    var actChiaSe: ClosureCustom<String>?
    var actEdit: ClosureCustom<SuKienEntity>?
    
    var tableData: [SuKienEntity] = [SuKienEntity]()
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var vItem: UIView!
    @IBOutlet weak var tableView: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        //dang ky tableView
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.registerCell(nibName: "SuKienCell")
        vItem.layer.cornerRadius = myCornerRadius.c10
        btnAdd.layer.cornerRadius = myCornerRadius.c10
//        btnAdd.addBorder(color: myColor.CN_1_TIM!, width: 1)
        setupTableSuKien()
    }
    
    func setupTableSuKien(){
        // Lấy danh sách tất cả các sự kiện
        tableData = SuKienManager.shared.getAllSuKien2()
        DispatchQueue.main.async {
            
            self.tableView?.reloadData()
        }
    }
    @IBAction func btnAddPressed(_ sender: Any) {
        actAdd?()
    }
    
}

extension  HomeSuKienCell:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SuKienCell", for: indexPath) as? SuKienCell else {return UITableViewCell()}
        
        let e = tableData.itemAtIndex(index: indexPath.row) ?? SuKienEntity()
        cell.bindData(e: e)
        cell.actXoa = {
            [weak self] in
            guard let self = self else {return}
            SuKienManager.shared.deleteSuKien(suKien: e)
            EventManager.share.deleteEvent(byCustomID: "\(e.id ?? UUID())")
            self.setupTableSuKien()
        }
        
        cell.actSua = {
            [weak self] in
            guard let self = self else {return}
            self.actEdit?(e)
      
        }
        cell.actBatTatThongBao = {
            [weak self] in
            guard let self = self else {return}
            e.notification = !e.notification
            let stt = SuKienManager.shared.updateNotiSuKien(suKien: e, notification: e.notification)
            if stt, e.notification {
                //bat thong bao
                EventManager.share.addEvent(ev: e)
              
            }else if stt, !e.notification{
                // xoa thong bao
                EventManager.share.deleteEvent(byCustomID: "\(e.id ?? UUID())")
        
            }
                self.setupTableSuKien()
    
            
        }
        cell.actChiaSe = {
            [weak self] s in
            guard let self = self else {return}
            print("Chia se")

            self.actChiaSe?(s)
        }
        return cell
    }
    
    
}
