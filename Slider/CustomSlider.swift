//
//  CustomSlider.swift
//  Slider
//
//  Created by Egor Mezhin on 09.07.2023.
//

import UIKit

class CustomSlider: UISlider {
    weak var delegate: CustomSliderDelegate?
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        delegate?.sliderFinishedEditing()
    }
}

protocol CustomSliderDelegate: AnyObject {
    func sliderFinishedEditing()
}
