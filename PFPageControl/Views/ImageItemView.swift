//
//  ImageView.swift
//  PFPageControl
//
//  Created by Ivan Ferencak on 19.03.2021..
//

import UIKit

class ImageView: PageItem {
    
    private let imageView = UIImageView()
    
    init(diameter: CGFloat, image: UIImage?) {
        super.init(frame: CGRect(x: 0, y: 0, width: diameter*2, height: diameter*2))
        imageView.frame = frame
        imageView.image = image
        addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func changeColor(color: UIColor, withAnimation: Bool = false) {
        
        if withAnimation {
            UIView.animate(withDuration: 0.25) {
                self.imageView.tintColor = color
            }
        } else {
            self.imageView.tintColor = color
        }
        
    }
    
}
