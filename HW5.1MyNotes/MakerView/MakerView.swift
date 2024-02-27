//
//  MakerView.swift
//  HW5.1MyNotes
//
//  Created by Alisher Sultanov on 24/2/24.
//

import Foundation
import UIKit

class MakerView {
    
    static let shared = MakerView()
    
    func makerImageView(image: String) -> UIImageView {
        let view = UIImageView()
        view.image = UIImage(named: image)
        view.contentMode = .scaleAspectFill
        return view
    }
    
    func makerStackView(axis: NSLayoutConstraint.Axis = .vertical, backgroundColor: UIColor) -> UIStackView {
        let view = UIStackView()
        view.axis = axis
        view.backgroundColor = backgroundColor
        view.spacing = 0.5
        view.distribution = .fillEqually
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }
    
    func makerSearchBar(placeholder: String) -> UISearchBar {
        let view = UISearchBar()
        view.placeholder = placeholder
        view.layer.cornerRadius = 10
        return view
    }
    
    func makerLabel(text: String, textColor: UIColor = .black, numberOfLines: Int, textAlignment: NSTextAlignment = .left, font: UIFont) -> UILabel {
        let view = UILabel()
        view.text = text
        view.textColor = textColor
        view.numberOfLines = numberOfLines
        view.textAlignment = textAlignment
        view.font = font
        return view
    }
    
    func makerButton(title: String? = nil, for state: UIControl.State = .normal,
                     imageName: String? = nil, for: UIControl.State = .normal,
                     backgroundColor: UIColor, cornerRadius:
                     CGFloat, tintColor: UIColor) -> UIButton {
        let view = UIButton(type: .system)
        view.setTitle(title, for: state)
        view.setImage(imageName != nil ? UIImage(named: imageName!) : nil, for: .normal)
        view.backgroundColor = backgroundColor
        view.layer.cornerRadius = cornerRadius
        view.tintColor = tintColor
        return view
    }
    
    func makerView(backgroundColor: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = backgroundColor
        view.clipsToBounds = true
        return view
    }
}
