//
//  RoundedCornerView.swift
//  Prework
//
//  Created by Rupin Jairaj on 11/01/22.
//

import UIKit

@IBDesignable
class RoundedCornerView: UIStackView {

    // if cornerRadius variable is set/changed, change the corner radius of the UIView
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
}
