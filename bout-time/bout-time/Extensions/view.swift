//
//  view.swift
//  bout-time
//
//  Created by Elena Meneghini on 14/08/2018.
//  Copyright © 2018 Elena Meneghini. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func applyBasicStyle() {
        // layer.cornerRadius = 8
        roundCorners(corners: [.topLeft, .bottomLeft], radius: 4)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.05
        layer.shadowOffset = CGSize(width: 0, height: 15)
        layer.shadowRadius = 4
        layer.masksToBounds = true
    }
}
