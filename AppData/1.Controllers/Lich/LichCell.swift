//
//  LichCell.swift
//  ChonCat-App
//
//  Created by Mac mini on 16/05/2024.
//

import UIKit
import VietnameseLunar

class LichCell: UICollectionViewCell {

    @IBOutlet weak var vTrangThaiSuKien: UIView!
    @IBOutlet weak var lbNgayAL: UILabel!
    @IBOutlet weak var lbNgayDL: UILabel!
    @IBOutlet weak var vItem: UIView!
    var item: LichModel = LichModel()
    override func awakeFromNib() {
        super.awakeFromNib()
      
        vItem.layer.cornerRadius = myCornerRadius.c10
        vTrangThaiSuKien.layer.cornerRadius = myCornerRadius.c10
        vTrangThaiSuKien.isHidden = true
    }
    
    func bindData(e: LichModel){
        item = e
        

        if e.ngayDL == 0 {
            vItem.isHidden = true
        }else {
            lbNgayDL.text = "\(item.ngayDL ?? 0)"

            if item.ngayAL == 1 {
                lbNgayAL.text = "\(item.ngayAL ?? 0)/\(item.thangAL ?? 0)"
            }else {
                lbNgayAL.text = "\(item.ngayAL ?? 0)"
            }
            
            vItem.isHidden = false
        }
        if item.trangThaiSuKien == 1 {
            vTrangThaiSuKien.isHidden = false
        }
     
        if Common.ngayHomNay.ngayDL == item.ngayDL, Common.ngayHomNay.thangDL == item.thangDL,Common.ngayHomNay.namDL == item.namDL {
//            print(Common.ngayHomNay.toJSON())
//            print(item.toJSON())
            vItem.backgroundColor = myColor.CN_1_TIM
            lbNgayDL.textColor = UIColor.white
            lbNgayAL.textColor = myColor.CN_4_CAM
        }else {
            vItem.backgroundColor = myColor.CN_7_NEN
            lbNgayDL.textColor = UIColor.black
            lbNgayAL.textColor = myColor.CN_3_TIM
        }
    }

}
