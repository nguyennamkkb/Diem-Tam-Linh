//
//  ViTriCell.swift
//  ChonCat-App
//
//  Created by Mac mini on 17/05/2024.
//

import UIKit

class ViTriCell: UITableViewCell {

    @IBOutlet weak var vMoBanDo: UIView!
    @IBOutlet weak var vViTri: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        vMoBanDo.layer.cornerRadius = myCornerRadius.c10
        vViTri.layer.cornerRadius = myCornerRadius.c10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
