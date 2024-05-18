//
//  HomeSuKienCell.swift
//  ChonCat-App
//
//  Created by Mac mini on 17/05/2024.
//

import UIKit

class HomeSuKienCell: UITableViewCell {

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
        
    }

}

extension  HomeSuKienCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SuKienCell", for: indexPath) as? SuKienCell else {return UITableViewCell()}
        
        return cell
    }
    
    
}
