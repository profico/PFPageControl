//
//  DotView.swift
//  PFPageControl
//
//  Created by Ivan Ferencak on 19.03.2021..
//

import UIKit

class DotView: PageItem {
    
    override init(diameter: CGFloat) {
        super.init(frame: CGRect(x: 0, y: 0, width: diameter, height: diameter))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var frame: CGRect {
        didSet {
            layer.cornerRadius = min(frame.width, frame.height) / 2
        }
    }
    
    override func changeColor(color: UIColor, withAnimation: Bool = false) {
        
        UIView.animate(withDuration: withAnimation ? 0.25 : 0) {
            self.backgroundColor = color
        }
        
    }
}
