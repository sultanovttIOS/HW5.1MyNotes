//
//  UIColor.swift
//  HW5.1MyNotes
//
//  Created by Alisher Sultanov on 9/3/24.
//

import UIKit

extension UIColor {
    func rgb(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor.init(red: r/255, green: g/61, blue: b/61, alpha: alpha)
    }
}
