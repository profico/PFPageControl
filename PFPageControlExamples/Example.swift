//
//  Example.swift
//  PFPageControlExamples
//
//  Created by Ivan Ferencak on 21.03.2021..
//

import UIKit
import PFPageControl

class Example: UIView {
    
    var exampleTitle: UILabel!
    var pfPageControl: PFPageControl!
    
    init() {
        super.init(frame: .zero)
        
        exampleTitle = UILabel()
        exampleTitle.textAlignment = .center
        addSubview(exampleTitle)
        
        pfPageControl = PFPageControl()
        addSubview(pfPageControl)
    }
    
    func setTitle(title: String) {
        exampleTitle.text = title
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        exampleTitle.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 24)
        pfPageControl.frame = CGRect(x: bounds.width / 2 - 170 / 2, y: 24, width: 170, height: 50)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
