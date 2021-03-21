//
//  ImagesViewController.swift
//  PFPageControlExamples
//
//  Created by Ivan Ferencak on 21.03.2021..
//

import UIKit

class ImagesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 125/255, green: 161/255, blue: 181/255, alpha: 1)
        title = "Images"
        
        let bgStyle = Example()
        bgStyle.setTitle(title: "prefferedIndicatorImage")
        bgStyle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bgStyle)
        
        bgStyle.pfPageControl.currentPageIndicatorTintColor = .red
        bgStyle.pfPageControl.preferredIndicatorImage = UIImage(named: "heart")
        bgStyle.pfPageControl.numberOfPages = 10
        
        
        let bgStyle2 = Example()
        bgStyle2.setTitle(title: "imageForPage")
        bgStyle2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bgStyle2)
        
        bgStyle2.pfPageControl.numberOfPages = 10
        bgStyle2.pfPageControl.currentPage = 7
        bgStyle2.pfPageControl.currentPageIndicatorTintColor = .red
        bgStyle2.pfPageControl.setIndicatorImage(UIImage(named: "heart"), forPage: 6)
        
        
        NSLayoutConstraint.activate(
            [
                bgStyle.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                bgStyle.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                bgStyle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                bgStyle.heightAnchor.constraint(equalToConstant: 80),
                bgStyle2.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                bgStyle2.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                bgStyle2.topAnchor.constraint(equalTo: bgStyle.bottomAnchor, constant: 20),
                bgStyle2.heightAnchor.constraint(equalToConstant: 80),
            ]
        )
    }

}
