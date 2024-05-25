//
//  MenuVC.swift
//  ChonCat-App
//
//  Created by Mac mini on 24/05/2024.
//

import UIKit

class MenuVC: BaseVC {
    let layout = UICollectionViewFlowLayout()
    var typeSelect: [String] = ["Popular","New Release", "Recommendations", "Luong Nam","Minh Anh","Hot Deal", "Lua chon khac","Popular","New Release", "Recommendations", "Luong Nam","Minh Anh","Hot Deal", "Lua chon khac"]
    
    var cellWidth: CGFloat = 20.0 // Biến để lưu trữ chiều rộng ban đầu

    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        layout.scrollDirection = .horizontal // Thiết lập scrollDirection là .horizontal để trượt ngang
        collectionView.collectionViewLayout = layout
//        layout.itemSize.width = 200
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        let nib = UINib(nibName: "TypeCell", bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: "TypeCell")
    }

}
extension MenuVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return typeSelect.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TypeCell", for: indexPath) as? TypeCell else {return UICollectionViewCell()}
        let t = typeSelect.itemAtIndex(index: indexPath.row) ?? ""
        cell.bindData(s: t)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let t = typeSelect.itemAtIndex(index: indexPath.row) ?? ""
        let newCellWidth = cellWidth + CGFloat(t.count * 11)
        return CGSize(width: newCellWidth, height: 44)
    }
    

}
