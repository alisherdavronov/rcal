//
//  ViewController.swift
//  rcal
//
//  Created by Олимхон Маматкулов on 12/03/2018.
//  Copyright © 2018 Олимхон Маматкулов. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    let date = Date()
    let calendar = Calendar.current
    var numberOfDays = 0
    var numberOfEmptyDays = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adjustCellWidth()
        calcDays()
    }
    
    func calcDays() {
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let days = calendar.range(of: .day, in: .month, for: date)

        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = 1
        
        let first = calendar.date(from: components)
        
        let weekday = calendar.component(.weekday, from: first!)
        
        let empty = (weekday - 2 + 7) % 7

        numberOfDays = days!.count
        numberOfEmptyDays = empty
    }
    
    func adjustCellWidth() {
        let width = (view.frame.size.width - 30) / 7
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize.width = width
    }
}

extension ViewController : UICollectionViewDelegate {
}

extension ViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfEmptyDays + numberOfDays
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Cell
        let i = indexPath.item - numberOfEmptyDays
        cell.label.text = i < 0 ? "" : String(i + 1)
        if indexPath.item % 7 > 4 {
            cell.label.textColor = .red
        }
        return cell
    }
    
}


