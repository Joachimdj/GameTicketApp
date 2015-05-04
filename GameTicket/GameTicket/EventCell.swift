//
//  colvwCell.swift
//  CollectionViewTute


import UIKit

class EventCell: UICollectionViewCell {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBOutlet var imgCell: UIImageView!
    @IBOutlet var lblCell: UILabel!
    @IBOutlet weak var Date: UILabel!
    
    
       override init(frame: CGRect) {
        super.init(frame: frame)
        
        imgCell = UIImageView(frame: CGRect(x: 0, y: 06, width: frame.size.width, height: frame.size.height*2/3))
        imgCell.contentMode = UIViewContentMode.ScaleAspectFit
        contentView.addSubview(imgCell)
        
        let textFrame = CGRect(x: 0, y: 32, width: frame.size.width, height: frame.size.height/3)
        lblCell = UILabel(frame: textFrame)
        lblCell.font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize())
        lblCell.textAlignment = .Center
        
        contentView.addSubview(lblCell)
    }
} 