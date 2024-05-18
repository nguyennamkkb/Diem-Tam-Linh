//
//  ViTriTamLinhCell.swift
//  ChonCat-App
//
//  Created by Mac mini on 16/05/2024.
//

import UIKit
import MapKit
import CoreLocation

class ViTriTamLinhCell: UITableViewCell {
    
    var actXemViTri: ClosureAction?
    @IBOutlet weak var vItem: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        vItem.layer.cornerRadius = myCornerRadius.c10

    }
    


    @IBAction func btnViTriTamLinhPressed(_ sender: Any) {
        actXemViTri?()
    }
    
}

