//
//  UIImageView+Extension.swift
//  OpenWeather
//
//  Created by Ekrem TAŞKIRAN on 21.11.2019.
//  Copyright © 2019 Ekrem TAŞKIRAN. All rights reserved.
//

import UIKit

extension UIImageView {
  convenience init(image: UIImage, contentMode: UIView.ContentMode) {
    self.init(image: image)
    self.contentMode = contentMode
  }
}
