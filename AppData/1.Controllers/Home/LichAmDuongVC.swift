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
            for i in 0..<42 {
                
                if i >= dayOfWeek, num <= daysInMonth {
//                    ngayDL.append(num)
                    lichThang.append(LichModel(ngay: num, thang: lichNgay.thangDL ?? 1, nam: lichNgay.namDL ?? 1))
                    num += 1
                }else {
                    lichThang.append(LichModel(ngay: 0, thang: lichNgay.thangDL ?? 1, nam: lichNgay.namDL ?? 1))
//                    ngayDL.append(0)
                }
                
               
            }
        } else {
            print("Không thể tạo ngày từ các thành phần cung cấp")
        }
//        for e in lichThang {
//            print(e.ngayDL ?? 0)
//        }
    }
    @IBAction func btnThemMoiPressed(_ sender: Any) {
        self.pushVC(controller: ThemSuKienVC())
    }
    @IBAction func btnBackPressed(_ sender: Any) {
        self.onBackNav()
    }
    @IBAction func btnNextMonthPressed(_ sender: Any) {
        
        lichThang =  DateHelper.share.nextMonth(month: lichNgay.thangDL, year: lichNgay.namDL)
        lichNgay = LichModel(ngay: 1, thang: lichThang[0].thangDL ?? 0, nam: lichThang[0].namDL ?? 0)
        lbNamDL.titleLabel?.text = "\(lichNgay.namDL ?? 0)"
        lbThangDL.setTitle("Tháng \(lichNgay.thangDL ?? 0)", for: .normal)
        lbNamDL.setTitle("\(lichNgay.namDL ?? 0)", for: .normal)
        if lichThang.count > 0 {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    @IBAction func btnPreMonthPressed(_ sender: Any) {
        lichThang =  DateHelper.share.previousMonth(month: lichNgay.thangDL, year: lichNgay.namDL)
        lichNgay = LichModel(ngay: 1, thang: lichThang[0].thangDL ?? 0, nam: lichThang[0].namDL ?? 0)
  
        lbThangDL.setTitle("Tháng \(lichNgay.thangDL ?? 0)", for: .normal)
        lbNamDL.setTitle("\(lichNgay.namDL ?? 0)", for: .normal)
        
        if lichThang.count > 0 {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    

}

extension LichAmDuongVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 37
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
    
    
}

extension LichAmDuongVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        updateTableViewHeight()
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SuKienCell", for: indexPath) as? SuKienCell else {return UITableViewCell()}
        
        return cell
    }

 
}
