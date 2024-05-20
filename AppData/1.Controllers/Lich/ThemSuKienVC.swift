//
//  ThemSuKienVC.swift
//  ChonCat-App
//
//  Created by Mac mini on 17/05/2024.
//

import UIKit
import VietnameseLunar
import ObjectMapper

class ThemSuKienVC: BaseVC {

    @IBOutlet weak var lbNgayAmDuong: UILabel!
    var actThanhCong: ClosureAction?
    
    var ngayDaChon: Date = Date()
    let chonNgay = UIDatePicker()
    
    @IBOutlet weak var tfChonNgay: UITextField!
    @IBOutlet weak var imgDuongLich: UIImageView!
    @IBOutlet weak var imgAmLich: UIImageView!
    var loaiLich: Int = 0 // 0 am, 1: duong
    @IBOutlet weak var swThongBao: UISwitch!
    @IBOutlet weak var tfChuThich: UITextField!
    @IBOutlet weak var tfTieuDe: UITextField!
    @IBOutlet weak var btnXacNhan: UIButton!
    @IBOutlet weak var vNhapChuThich: UIView!
    @IBOutlet weak var vNhapTieuDe: UIView!
    @IBOutlet weak var vNhapNgay: UIView!
    @IBOutlet weak var vDuongLich: UIView!
    @IBOutlet weak var vAmLich: UIView!
    
    var item: SuKienEntity = SuKienEntity()
    var trangThaiSua: Bool = false
    var ngayModel:NgayModel  = NgayModel()
    override func viewDidLoad() {
        
        super.viewDidLoad()

        setupUI()
        setupDatePicker()
        setupData()
       
        
        
    }

    func bindData(e: SuKienEntity) {
        item = e
        ngayModel = Mapper<NgayModel>().map(JSONString: item.ngay ?? "") ?? NgayModel()
        trangThaiSua = true
    }
    
    func setupData(){
        ChonLich(n: 0)
        tfChonNgay.text = formatDate(date: ngayDaChon)
        if trangThaiSua {
            ChonLich(n: Int(ngayModel.loaiLich ?? 0))
            tfTieuDe.text = item.title
            tfChuThich.text = item.note
            swThongBao.isOn = item.notification
            ngayDaChon =  item.getDate() ?? Date()
            tfChonNgay.text = formatDate(date: ngayModel.getDate() ?? Date())
        }
        
        
        
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
    func setupDatePicker(){
        chonNgay.datePickerMode = .date
        chonNgay.locale = Locale(identifier: "vi_VN")
        chonNgay.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
        chonNgay.frame.size = CGSize(width: 0, height: 300)
        if #available(iOS 13.4, *) {
            chonNgay.preferredDatePickerStyle = .wheels
        }
        chonNgay.setDate(Date(), animated: true)
        tfChonNgay.inputView = chonNgay
        
    }
    @objc func dateChange(datePicker: UIDatePicker) {
        tfChonNgay.text = formatDate(date: datePicker.date)
      
    }
    func formatDate(date: Date) -> String {
        ngayDaChon = date
        let formatrer =  DateFormatter()
        formatrer.dateFormat = "dd/MM/yyyy"
        hienThiNgayDaChon()
        return formatrer.string(from: date)
    }
    
    func hienThiNgayDaChon(){
        let formatrer =  DateFormatter()
        formatrer.dateFormat = "dd/MM/yyyy"
        let ngay = NgayModel(date: ngayDaChon)
        if loaiLich == 0 {
            let ngay = DateHelper.share.amLichSangDuongLich(day: ngay.ngay ?? 1, month: ngay.thang ?? 1, year: ngay.nam ?? 1970)
            lbNgayAmDuong.text = "AL: \(ngay.ngayAL ?? 1)/\(ngay.thangAL ?? 1)/\(ngay.canChi ?? ""), DL: \(ngay.ngayDL ?? 1 )/\(ngay.thangDL ?? 1)/\(ngay.namDL ?? 1970)"
        }
        if loaiLich == 1 {
            let ngay = VietnameseCalendar(date: ngayDaChon)
            lbNgayAmDuong.text = "DL: \(formatrer.string(from: ngayDaChon)), AL: \(ngay.vietnameseDate.day)/\(ngay.vietnameseDate.month)/\(ngay.vietnameseDate.year)"
        }
    }
    @IBAction func btnBackPressed(_ sender: Any) {
        onBackNav()
    }

    @IBAction func btnChonLichAm(_ sender: Any) {
        ChonLich(n: 0)
        
    }
    @IBAction func btnChonLichDuong(_ sender: Any) {
        ChonLich(n: 1)

        
    }
    func ChonLich(n: Int){
        imgAmLich.image =  UIImage(systemName: "circle")
        imgDuongLich.image =  UIImage(systemName: "circle")
        switch n {
        case 0:
            imgAmLich.image =  UIImage(systemName: "circle.fill")
            loaiLich = 0
            break
        case 1:
            imgDuongLich.image =  UIImage(systemName: "circle.fill")
            loaiLich = 1
            break
        default:
            imgAmLich.image =  UIImage(systemName: "circle.fill")
            loaiLich = 0
            break
        }
        hienThiNgayDaChon()
    }

    
    @IBAction func btnXacNhanPressed(_ sender: Any) {
        let ngay = NgayModel(date: ngayDaChon)
        ngay.loaiLich = loaiLich
        let sukien = SuKienModel()
        guard let tenSuKien = tfTieuDe.text, tenSuKien.count > 0 else {return}
        guard let chuThich = tfChuThich.text, chuThich.count > 0 else {return}
        sukien.title = tenSuKien
        sukien.note = chuThich
        sukien.notification = swThongBao.isOn
        sukien.ngay = ngay
        sukien.status = 1
 
        
        if trangThaiSua {
            if SuKienManager.shared.updateSuKien(suKien: item,e: sukien) {
                self.hienThiThongBao(trangThai: 1, loiNhan: "Cap Nhat thành công")
                actThanhCong?()
                
            }else {
                self.hienThiThongBao(trangThai: 0, loiNhan: "Kiểm tra thông tin nhập")
            }
        }else {
            if SuKienManager.shared.addSuKien(e: sukien) {
                self.hienThiThongBao(trangThai: 1, loiNhan: "Thêm lịch thành công")
                actThanhCong?()
                
            }else {
                self.hienThiThongBao(trangThai: 0, loiNhan: "Kiểm tra thông tin nhập")
            }
        }
       
        
    }
}
