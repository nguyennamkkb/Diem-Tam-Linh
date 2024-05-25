//
//  TypeCell.swift
//  ChonCat-App
//
//  Created by Mac mini on 24/05/2024.
//

import UIKit

class TypeCell: UICollectionViewCell {


    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var vItem: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        vItem.layer.cornerRadius = myCornerRadius.c10
    }
    func bindData(s: String){
        lbTitle.text = s
//        self.layoutIfNeeded()
    }
    
    

}
