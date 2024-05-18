//
//  LichVanNienCell.swift
//  ChonCat-App
//
//  Created by Mac mini on 16/05/2024.
//

import UIKit
import VietnameseLunar


class LichVanNienCell: UITableViewCell {
    
    @IBOutlet weak var lbThu: UILabel!
    var actXemLich: ClosureAction?
    @IBOutlet weak var lbThangNamAL: UILabel!
    @IBOutlet weak var lbNgayAL: UILabel!
    @IBOutlet weak var lbThangNamDL: UILabel!
    @IBOutlet weak var lbNgayDL: UILabel!
    @IBOutlet weak var vLichVanNien: UIView!
    var lichNgay: LichModel = LichModel()
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        setupData()
    }
    
    func setupUI(){
        vLichVanNien.layer.cornerRadius = myCornerRadius.c10
        vLichVanNien.addNDropShadow()
    }
    @IBOutlet weak var btnNextDayPressed: NSLayoutConstraint!
    func setupData(){
        let currentDate = Date()
        
        // Tạo Calendar để trích xuất các thành phần
        lichNgay = LichModel(date: currentDate)
        
        setDataDate()
    }
    @IBAction func btnReloadPressed(_ sender: Any) {
        let currentDate = Date()
        
        // Tạo Calendar để trích xuất các thành phần
        lichNgay = LichModel(date: currentDate)
        
        setDataDate()
    }
    @IBAction func btnPrevDayPressed(_ sender: Any) {
        lichNgay = DateHelper.share.prevDay(day: lichNgay.ngayDL ?? 0, month: lichNgay.thangDL ?? 0, year: lichNgay.namDL ?? 0)

        setDataDate()
    }
    @IBAction func btnNextDayPressed(_ sender: Any) {
        lichNgay = DateHelper.share.nextDay(day: lichNgay.ngayDL ?? 0, month: lichNgay.thangDL ?? 0, year: lichNgay.namDL ?? 0)
        
        setDataDate()

    }
    func setDataDate(){
        lbNgayDL.text = "\(lichNgay.ngayDL ?? 0)"
        lbThangNamDL.text = "Tháng \(lichNgay.thangDL ?? 0) - \(lichNgay.namDL ?? 0)"
        lbThu.text = lichNgay.thu
   
        lbNgayAL.text = "\(lichNgay.ngayAL ?? 0)"
        lbThangNamAL.text = "Tháng \(lichNgay.thangAL ?? 0)-\(lichNgay.namAL ?? "")"

    }
    @IBAction func btnXemLichPressed(_ sender: Any) {
        actXemLich?()
    }
}
