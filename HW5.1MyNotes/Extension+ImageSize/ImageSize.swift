//
//  ImageSize.swift
//  HW5.1MyNotes
//
//  Created by Alisher Sultanov on 9/3/24.
//

import UIKit

extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
