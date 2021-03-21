//
//  ViewController.swift
//  PFPageControlExamples
//
//  Created by Ivan Ferencak on 19.03.2021..
//

import UIKit
import PFPageControl

class ExampleListViewController: UIViewController {

    var tableView: UITableView = UITableView()
    
    var examples: [ExampleType] = [.BackgroundStyle, .Style, .Color, .Images]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Examples"
        
        view.backgroundColor = UIColor(red: 125/255, green: 161/255, blue: 181/255, alpha: 1)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "exampleCell")
        tableView.backgroundColor = .clear
        view.addSubview(tableView)
        
        
        NSLayoutConstraint.activate(
            [
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ]
        )
    }

}

extension ExampleListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return examples.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "exampleCell", for: indexPath)
        cell.textLabel?.text = examples[indexPath.row].rawValue
        cell.backgroundColor = .clear
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch examples[indexPath.row] {
        case .BackgroundStyle:
            let styleVC = BackgroundStyleViewController()
            self.navigationController?.pushViewController(styleVC, animated: true)
        case .Style:
            let styleVC = StyleViewController()
            self.navigationController?.pushViewController(styleVC, animated: true)
        case .Color :
            let styleVC = ColorViewController()
            self.navigationController?.pushViewController(styleVC, animated: true)
        case .Images:
            let styleVC = ImagesViewController()
            self.navigationController?.pushViewController(styleVC, animated: true)
        }
    }
}

public enum ExampleType: String {
    case BackgroundStyle = "Background style example"
    case Style = "Style example"
    case Color = "Color example"
    case Images = "Images example"
}
