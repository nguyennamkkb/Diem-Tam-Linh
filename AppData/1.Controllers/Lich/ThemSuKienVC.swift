//
//  ThemSuKienVC.swift
//  ChonCat-App
//
//  Created by Mac mini on 17/05/2024.
//

import UIKit

class ThemSuKienVC: BaseVC {

    @IBOutlet weak var btnXacNhan: UIButton!
    @IBOutlet weak var vNhapChuThich: UIView!
    @IBOutlet weak var vNhapTieuDe: UIView!
    @IBOutlet weak var vNhapNgay: UIView!
    @IBOutlet weak var vDuongLich: UIView!
    @IBOutlet weak var vAmLich: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    func setupUI(){
        btnXacNhan.layer.cornerRadius = myCornerRadius.c10
        vAmLich.layer.cornerRadius = myCornerRadius.c10
        vNhapChuThich.layer.cornerRadius = myCornerRadius.c10
        vNhapTieuDe.layer.cornerRadius = myCornerRadius.c10
        vNhapNgay.layer.cornerRadius = myCornerRadius.c10
        vDuongLich.layer.cornerRadius = myCornerRadius.c10
        
        vAmLich.backgroundColor = myColor.CN_7_NEN
        vNhapChuThich.backgroundColor = myColor.CN_7_NEN
        vNhapTieuDe.backgroundColor = myColor.CN_7_NEN
        vNhapNgay.backgroundColor = myColor.CN_7_NEN
        vDuongLich.backgroundColor = myColor.CN_7_NEN
    }
    @IBAction func btnBackPressed(_ sender: Any) {
        onBackNav()
    }
    

}
