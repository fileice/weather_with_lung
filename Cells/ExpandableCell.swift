//
//  ExpandableCell.swift
//  weather_with_Lung
//
//  Created by CHIOU LI-SHIAU on 2019/9/27.
//  Copyright © 2019 CHIOU LI-SHIAU. All rights reserved.
//

import UIKit

class ExpandableCell: UICollectionViewCell, Expandable {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblComfort: UILabel!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblParameter: UILabel!
    
    private var initialFrame: CGRect?
    private var initialCornerRadius: CGFloat?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureAll()
        
    }
    
    // MARK: - Configuration
    
    private func configureAll() {
        configureCell()
    }
    
    private func configureCell() {
        self.contentView.backgroundColor = .white
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.masksToBounds = true
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = self.contentView.layer.cornerRadius
    }
    
    // MARK: - Showing/Hiding Logic
    
    func hide(in collectionView: UICollectionView, frameOfSelectedCell: CGRect) {
        initialFrame = self.frame
        
        let currentY = self.frame.origin.y
        let newY: CGFloat
        
        if currentY < frameOfSelectedCell.origin.y {
            let offset = frameOfSelectedCell.origin.y - currentY
            newY = collectionView.contentOffset.y - offset
        } else {
            let offset = currentY - frameOfSelectedCell.maxY
            newY = collectionView.contentOffset.y + collectionView.frame.height + offset
        }
        
        self.frame.origin.y = newY
        
        layoutIfNeeded()
    }
    
    func show() {
        self.frame = initialFrame ?? self.frame
        
        initialFrame = nil
        
        layoutIfNeeded()
    }
    
    // MARK: - Expanding/Collapsing Logic
    
    func expand(in collectionView: UICollectionView) {
        initialFrame = self.frame
        initialCornerRadius = self.contentView.layer.cornerRadius
        
        self.contentView.layer.cornerRadius = 0
        self.frame = CGRect(x: 0, y: collectionView.contentOffset.y, width: collectionView.frame.width, height: collectionView.frame.height)
        
        layoutIfNeeded()
    }
    
    func collapse() {
        self.contentView.layer.cornerRadius = initialCornerRadius ?? self.contentView.layer.cornerRadius
        self.frame = initialFrame ?? self.frame
        
        initialFrame = nil
        initialCornerRadius = nil
        
        layoutIfNeeded()
    }
    
    func displayWeatherInCell(using viewModel: WeatherViewModel) {
        let dsteString = viewModel.date
        let date = dsteString.split(separator: " ")
        let stringDate = date[0]
    
        lblTitle.text = viewModel.title
        lblDate.text = String(stringDate)
        lblComfort.text = viewModel.comfort
        lblParameter.text = viewModel.parameter
        lblTemp.text = viewModel.temperature + "℃"
    }
    
}
