//
//  SuKienCell.swift
//  ChonCat-App
//
//  Created by Mac mini on 17/05/2024.
//

import UIKit

class SuKienCell: UITableViewCell {
    
   
    @IBOutlet weak var btnBell: UIButton!
    var actBatTatThongBao: ClosureAction?
    var actChiaSe: ClosureCustom<String>?
    var actSua: ClosureAction?
    var actXoa: ClosureAction?
    @IBOutlet weak var lbChuThich: UILabel!
    @IBOutlet weak var lbNgaySuKien: UILabel!
    @IBOutlet weak var lbTenSuKien: UILabel!
    var item = SuKienEntity()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    func bindData(e: SuKienEntity){
        item = e
        lbTenSuKien.text = item.title
        lbNgaySuKien.text = item.getDateString()
        lbChuThich.text = item.note
        setImageBell(stt: item.notification)
    }
    func setImageBell(stt: Bool){
        if stt {
            btnBell.setImage(UIImage(systemName: "bell"), for: .normal)
        }else {
            btnBell.setImage(UIImage(systemName: "bell.slash"), for: .normal)
        }
    }
    @IBAction func btnChiaSePressed(_ sender: Any) {
        let s: String = """
        Sự kiện: \(item.title ?? "")
        Ngày: \(item.getDateString())
        Chú thích: \(item.note ?? "")
        """
        actChiaSe?(s)
    }
    @IBAction func btnBatThongBao(_ sender: Any) {
        actBatTatThongBao?()
    }
    @IBAction func btnSuaPressed(_ sender: Any) {
        actSua?()
    }
    @IBAction func btnXoaPressed(_ sender: Any) {
        actXoa?()
    }
    
    
}
