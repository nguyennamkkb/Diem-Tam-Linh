//
//  LichAmDuongVC.swift
//  ChonCat-App
//
//  Created by Mac mini on 16/05/2024.
//

import UIKit
import VietnameseLunar
import Foundation

class LichAmDuongVC: BaseVC {
    
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    var tableData: [SuKienEntity] = [SuKienEntity]()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lbNamDL: UIButton!
    
    @IBOutlet weak var lbThangDL: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    var lichNgay: LichModel = LichModel()
    var lichThang: [LichModel] = [LichModel]()
    var ngayHomNay: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //LichCell
        setupUI()
        setLayout()
        setupTable()
        
        
    }
    func setupCalendar(){
        lbThangDL.setTitle("Tháng \(lichNgay.thangDL ?? 0)", for: .normal)
        lbNamDL.setTitle("\(lichNgay.namDL ?? 0)", for: .normal)
        if lichThang.count > 0 {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        if let date = DateHelper.share.getDate(day: 1, month: lichNgay.thangDL ?? 1, year: lichNgay.namDL ?? 1970), let dayOfWeek = DateHelper.share.dayOfWeek(for: date), let daysInMonth = DateHelper.share.numberOfDays(month: lichNgay.thangDL ?? 1, year: lichNgay.namDL ?? 1970) {
            
            if lichThang.count >= 36 {
                DispatchQueue.main.async {
                    self.collectionViewHeight.constant = 310
                    
                }
            }else {
                DispatchQueue.main.async {
                    self.collectionViewHeight.constant = 260
                }
            }
            
            
        } else {
            print("Không thể tạo ngày từ các thành phần cung cấp")
        }
    }
    func setupTable(){
        // Lấy danh sách tất cả các sự kiện
        tableData = SuKienManager.shared.getAllSuKien2()
        DispatchQueue.main.async {
            
            self.tableView?.reloadData()
        }
    }
    func setupUI(){
        
        //dang ky collectionView
        collectionView.dataSource = self
        collectionView.delegate = self
        let nib = UINib(nibName: "LichCell", bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: "LichCell")
        
        //dang ky tableView
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.registerCell(nibName: "SuKienCell")
        
        
        let currentDate = Date()
        
        // Tạo Calendar để trích xuất các thành phần
        let calendar = Calendar.current
        
        // Trích xuất ngày, tháng và năm từ ngày hiện tại
        ngayHomNay = calendar.component(.day, from: currentDate)
        let thang = calendar.component(.month, from: currentDate)
        let nam = calendar.component(.year, from: currentDate)
        
        lichNgay = LichModel(ngay: ngayHomNay, thang: thang, nam: nam)
        lbThangDL.setTitle("Tháng \(lichNgay.thangDL ?? 0)", for: .normal)
        lbNamDL.setTitle("\(lichNgay.namDL ?? 0)", for: .normal)
        
        
        if let date = DateHelper.share.getDate(day: 1, month: thang, year: nam), let dayOfWeek = DateHelper.share.dayOfWeek(for: date), let daysInMonth = DateHelper.share.numberOfDays(month: thang, year: nam) {
            var num: Int = 1
            for i in 0..<(dayOfWeek + daysInMonth) {
                
                if i >= dayOfWeek, num <= daysInMonth {
                    //                    ngayDL.append(num)
                    lichThang.append(LichModel(ngay: num, thang: lichNgay.thangDL ?? 1, nam: lichNgay.namDL ?? 1))
                    num += 1
                }else {
                    lichThang.append(LichModel(ngay: 0, thang: lichNgay.thangDL ?? 1, nam: lichNgay.namDL ?? 1))
                    //                    ngayDL.append(0)
                }

            }
            setupCalendar()
        } else {
            print("Không thể tạo ngày từ các thành phần cung cấp")
        }
        
    }
    @IBAction func btnThemMoiPressed(_ sender: Any) {
        let vc = ThemSuKienVC()
        vc.actThanhCong = {
            [weak self] in
            guard let self = self else { return  }
            self.setupTable()
        }
        self.pushVC(controller: vc)
    }
    @IBAction func btnBackPressed(_ sender: Any) {
        self.onBackNav()
    }
    @IBAction func btnNextMonthPressed(_ sender: Any) {
        
        lichThang =  DateHelper.share.nextMonth(month: lichNgay.thangDL, year: lichNgay.namDL)
        lichNgay = LichModel(ngay: 1, thang: lichThang[0].thangDL ?? 0, nam: lichThang[0].namDL ?? 0)
        setupCalendar()
    }
    @IBAction func btnPreMonthPressed(_ sender: Any) {
        lichThang =  DateHelper.share.previousMonth(month: lichNgay.thangDL, year: lichNgay.namDL)
        lichNgay = LichModel(ngay: 1, thang: lichThang[0].thangDL ?? 0, nam: lichThang[0].namDL ?? 0)
        
        setupCalendar()
    }
    
    
}

extension LichAmDuongVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lichThang.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LichCell", for: indexPath) as? LichCell else {return UICollectionViewCell()}
        
        let e = lichThang.itemAtIndex(index: indexPath.row) ?? LichModel()
        
        cell.bindData(e:e)
        return cell
    }
    
    func setLayout(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        // Số lượng item trên mỗi hàng
        let countItem: CGFloat = 7.0
        
        // Chiều rộng màn hình
        let screenWidth = UIScreen.main.bounds.width
        
        // Tổng khoảng cách giữa các item
        let totalSpacing = (countItem - 1) * layout.minimumInteritemSpacing
        
        // Chiều rộng của mỗi item
        let itemWidth = (screenWidth - totalSpacing) / countItem
        
        // Thiết lập kích thước cho item
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        
        // Thiết lập khoảng cách giữa các item
        layout.minimumInteritemSpacing = 5 // hoặc giá trị mong muốn
        layout.minimumLineSpacing = 5 // khoảng cách giữa các hàng
        
        // Thiết lập layout cho collectionView
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    func shareText(_ text: String) {
            let activityViewController = UIActivityViewController(activityItems: [text], applicationActivities: nil)
            
            if let popoverController = activityViewController.popoverPresentationController {
                popoverController.sourceView = self.view
                popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                popoverController.permittedArrowDirections = []
            }
            
            self.present(activityViewController, animated: true, completion: nil)
        }
    
}

extension LichAmDuongVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SuKienCell", for: indexPath) as? SuKienCell else {return UITableViewCell()}
        
        let e = tableData.itemAtIndex(index: indexPath.row) ?? SuKienEntity()
        cell.bindData(e: e)
        cell.actXoa = {
            [weak self] in
            guard let self = self else {return}
            SuKienManager.shared.deleteSuKien(suKien: e)
            EventManager.share.deleteEvent(byCustomID: "\(e.id ?? UUID())")
            self.setupTable()
        }
        
        cell.actSua = {
            [weak self] in
            guard let self = self else {return}
            let vc = ThemSuKienVC()
            vc.bindData(e: e)
            vc.actThanhCong = {
                [weak self] in
                guard let self = self else { return  }
                self.setupTable()
            }
            self.pushVC(controller: vc)
        }
        cell.actBatTatThongBao = {
            [weak self] in
            guard let self = self else {return}
            e.notification = !e.notification
            let stt = SuKienManager.shared.updateNotiSuKien(suKien: e, notification: e.notification)
            if stt, e.notification {
                //bat thong bao
                EventManager.share.addEvent(ev: e)
                self.setupTable()
            }else if stt, !e.notification{
                // xoa thong bao
                EventManager.share.deleteEvent(byCustomID: "\(e.id ?? UUID())")
                self.setupTable()
            }else {
                self.setupTable()
            }
            
        }
        cell.actChiaSe = {
            [weak self] s in
            guard let self = self else {return}
            print("Chia se")

            self.shareText(s)
        }
        return cell
    }
    
    
}
