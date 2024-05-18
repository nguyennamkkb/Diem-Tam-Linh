//
//  FormViTriCell.swift
//  ChonCat-App
//
//  Created by Mac mini on 18/05/2024.
//

import UIKit

class FormViTriCell: UITableViewCell {

    @IBOutlet weak var vNgay: UIView!
    @IBOutlet weak var imgDL: UIImageView!
    @IBOutlet weak var imgAL: UIImageView!
    @IBOutlet weak var vDuongL: UIView!
    @IBOutlet weak var vAmL: UIView!
    @IBOutlet weak var vTenDiaDiem: UIView!
    @IBOutlet weak var vChuThich: UIView!
    @IBOutlet weak var btnXacNhan: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        btnXacNhan.layer.cornerRadius = myCornerRadius.c10
        vTenDiaDiem.layer.cornerRadius = myCornerRadius.c10
        vChuThich.layer.cornerRadius = myCornerRadius.c10
        vNgay.layer.cornerRadius = myCornerRadius.c10
        
    }

    
    
}
