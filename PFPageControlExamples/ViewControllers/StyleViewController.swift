//
//  StyleViewControllerViewController.swift
//  PFPageControlExamples
//
//  Created by Ivan Ferencak on 21.03.2021..
//

import UIKit

class StyleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 125/255, green: 161/255, blue: 181/255, alpha: 1)
        title = "Styling"
        
        let bgStyle = Example()
        bgStyle.setTitle(title: "edgePadding")
        bgStyle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bgStyle)
        
        bgStyle.pfPageControl.backgroundStyle = .prominent
        bgStyle.pfPageControl.edgePadding = 40
        bgStyle.pfPageControl.numberOfPages = 10
        
        
        let bgStyle2 = Example()
        bgStyle2.setTitle(title: "selectedIndicatorScale")
        bgStyle2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bgStyle2)
        
        bgStyle2.pfPageControl.numberOfPages = 10
        bgStyle2.pfPageControl.selectedIndicatorScale = 1.5
        
        
        let bgStyle3 = Example()
        bgStyle3.setTitle(title: "spacing")
        bgStyle3.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bgStyle3)
        
        bgStyle3.pfPageControl.backgroundStyle = .automatic
        bgStyle3.pfPageControl.spacing = 20
        bgStyle3.pfPageControl.numberOfPages = 10
        bgStyle3.pfPageControl.currentPage = 4
        
        
        let bgStyle4 = Example()
        bgStyle4.setTitle(title: "diameter")
        bgStyle4.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bgStyle4)
        
        bgStyle4.pfPageControl.backgroundStyle = .automatic
        bgStyle4.pfPageControl.numberOfPages = 10
        bgStyle4.pfPageControl.diameter = 14
        
        
        
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
                bgStyle3.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                bgStyle3.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                bgStyle3.topAnchor.constraint(equalTo: bgStyle2.bottomAnchor, constant: 20),
                bgStyle3.heightAnchor.constraint(equalToConstant: 80),
                bgStyle4.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                bgStyle4.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                bgStyle4.topAnchor.constraint(equalTo: bgStyle3.bottomAnchor, constant: 20),
                bgStyle4.heightAnchor.constraint(equalToConstant: 80)
            ]
        )
    }

}
