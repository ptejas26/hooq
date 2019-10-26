//
//  UIView+Extension.swift
//  HooqApp
//
//  Created by Balaji Galave on 26/10/19.
//  Copyright © 2019 Balaji Galave. All rights reserved.
//

import UIKit

extension UIView {
    
    // rounds the view with given parameters
    func round(with cornerRadius: CGFloat, withBorder: Bool = true, borderColor: UIColor, borderWidth: CGFloat = 0) {
        layer.borderWidth = borderWidth
        layer.masksToBounds = false
        layer.cornerRadius = cornerRadius
        if withBorder {
            layer.borderColor = borderColor.cgColor
        }
        clipsToBounds = true
    }
    
    func dropShadow() {
//        contentView.layer.cornerRadius = 2.0;
//        contentView.layer.borderWidth = 1.0;
//        contentView.layer.borderColor = UIColor.clear.cgColor;
//        contentView.layer.masksToBounds = true;

        layer.shadowColor = UIColor.black.cgColor;
        layer.shadowOffset = CGSize(width: 0, height: 2.0);
        layer.shadowRadius = 2.0;
        layer.shadowOpacity = 0.5;
        layer.masksToBounds = false;
    }

    
}
