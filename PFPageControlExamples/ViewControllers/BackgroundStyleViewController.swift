//
//  StyleExampleViewController.swift
//  PFPageControlExamples
//
//  Created by Ivan Ferencak on 21.03.2021..
//

import UIKit

class BackgroundStyleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 125/255, green: 161/255, blue: 181/255, alpha: 1)
        title = "Background style"
        
        let bgStyle = Example()
        bgStyle.setTitle(title: ".minimal")
        bgStyle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bgStyle)
        
        bgStyle.pfPageControl.backgroundStyle = .minimal
        bgStyle.pfPageControl.numberOfPages = 10
        
        
        let bgStyle2 = Example()
        bgStyle2.setTitle(title: ".prominent")
        bgStyle2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bgStyle2)
        
        bgStyle2.pfPageControl.backgroundStyle = .prominent
        bgStyle2.pfPageControl.numberOfPages = 10
        
        
        let bgStyle3 = Example()
        bgStyle3.setTitle(title: ".automatic")
        bgStyle3.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bgStyle3)
        
        bgStyle3.pfPageControl.backgroundStyle = .automatic
        bgStyle3.pfPageControl.numberOfPages = 10
        
        
        
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
                bgStyle3.heightAnchor.constraint(equalToConstant: 80)
            ]
        )
        
    }

}
