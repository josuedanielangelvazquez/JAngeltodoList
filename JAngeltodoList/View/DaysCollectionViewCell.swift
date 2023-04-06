//
//  DaysCollectionViewCell.swift
//  JAngeltodoList
//
//  Created by MacBookMBA6 on 03/04/23.
//

import UIKit

class DaysCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var daycellcolor: UIView!
    
    @IBOutlet weak var ViewCell: UIView!
    @IBOutlet weak var StackCell: UIStackView!
    @IBOutlet weak var mounthlbl: UILabel!
    @IBOutlet weak var daylbl: UILabel!
    @IBOutlet weak var stack2cell: UIStackView!
    @IBOutlet weak var view1stack: UIView!
    @IBOutlet weak var view2stack: UIView!
    
    @IBOutlet weak var viewstack3: UIView!
    override func awakeFromNib() {
        
        super.awakeFromNib()
        viewstack3.layer.cornerRadius = 40
        view2stack.layer.cornerRadius = 40
        view1stack.layer.cornerRadius = 40
        stack2cell.layer.cornerRadius = 40
        ViewCell.layer.cornerRadius = 40
        ViewCell.layer.cornerRadius = 40

    }
 
    

}
