//
//  ViewController.swift
//  NBC_4W_Caculator
//
//  Created by 황석현 on 11/11/24.
//

import UIKit

class ViewController: UIViewController {
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "12345"
        label.textColor = .white
        label.textAlignment = .right
        label.font = .boldSystemFont(ofSize: .init(60))
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(mainLabel)
        setupView()
    }
    
    private func setupView() {
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            mainLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            mainLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            mainLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
        
    }
    
}

