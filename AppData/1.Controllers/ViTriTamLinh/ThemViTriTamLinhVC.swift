//
//  ThemViTriTamLinhVC.swift
//  ChonCat-App
//
//  Created by Mac mini on 18/05/2024.
//

import UIKit

class ThemViTriTamLinhVC: BaseVC {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerCells(cells: ["BanDoMiniCell","FormViTriCell"])
      
    }

}
extension ThemViTriTamLinhVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell =  tableView.dequeueReusableCell(withIdentifier: "BanDoMiniCell") as? BanDoMiniCell else {return UITableViewCell()}
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FormViTriCell") as? FormViTriCell else {return UITableViewCell()}
            return cell
        default:
            return UITableViewCell()

        }
    }
    
    
}
