//
//  TraVeTimKiemCell.swift
//  ChonCat-App
//
//  Created by Mac mini on 18/05/2024.
//

import UIKit

class TraVeTimKiemCell: UITableViewCell {

    var actTap: ClosureAction?
    @IBOutlet weak var lbPhuDe: UILabel!
    @IBOutlet weak var lbTieuDe: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bindData(tieuDe: String, phuDe: String){
        print(tieuDe)
        lbPhuDe.text = phuDe
        lbTieuDe.text = tieuDe
    }
    @IBAction func btnChonPressed(_ sender: Any) {
        actTap?()
    }
    
}
