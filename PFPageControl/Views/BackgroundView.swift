//
//  BackgroundView.swift
//  PFPageControl
//
//  Created by Ivan Ferencak on 19.03.2021..
//

import UIKit

class BackgroundView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.systemBackground.withAlphaComponent(0.5)
    }
    
    override var frame: CGRect {
        didSet {
            layer.cornerRadius = frame.height / 2
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
