//
//  UIStackView+Extension.swift
//  OpenWeather
//
//  Created by Ekrem TAŞKIRAN on 22.11.2019.
//  Copyright © 2019 Ekrem TAŞKIRAN. All rights reserved.
//

import UIKit

extension UIStackView {
  convenience init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, alignment: UIStackView.Alignment) {
    self.init(arrangedSubviews: arrangedSubviews)
    self.axis = axis
    self.alignment = alignment
  }
}

@available(iOS 9.0, *)
extension UIStackView {
    
    @discardableResult
    open func withMargins(_ margins: UIEdgeInsets) -> UIStackView {
        layoutMargins = margins
        isLayoutMarginsRelativeArrangement = true
        return self
    }
    
    @discardableResult
    open func padLeft(_ left: CGFloat) -> UIStackView {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins.left = left
        return self
    }
    
    @discardableResult
    open func padTop(_ top: CGFloat) -> UIStackView {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins.top = top
        return self
    }
    
    @discardableResult
    open func padBottom(_ bottom: CGFloat) -> UIStackView {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins.bottom = bottom
        return self
    }
    
    @discardableResult
    open func padRight(_ right: CGFloat) -> UIStackView {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins.right = right
        return self
    }
}
