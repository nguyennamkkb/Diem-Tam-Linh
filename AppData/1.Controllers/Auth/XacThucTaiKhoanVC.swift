//
//  XacThucTaiKhoanVC.swift
//  LN POS
//
//  Created by Mac mini on 25/04/2024.
//

import UIKit

class XacThucTaiKhoanVC: BaseVC {

    @IBOutlet weak var tfOTP: UITextField!
    @IBOutlet weak var btnXacNhan: UIButton!
    @IBOutlet weak var vOTP: UIView!
    @IBOutlet weak var vForm: UIView!
    var emailInput: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

//        btnXacNhan.layer.cornerRadius = myCornerRadius.corner10
//        vForm.layer.cornerRadius = myCornerRadius.corner20
//        vOTP.layer.cornerRadius = myCornerRadius.corner10
//        vOTP.addBorder(color: myColor.SPA_FE!, width: 1)
       
    }
    func bindData(email: String){
        emailInput = email
    }
    @IBAction func backPressed(_ sender: Any) {
        self.onBackNav()
    }
   
    


}
