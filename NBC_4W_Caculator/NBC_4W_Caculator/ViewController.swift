//
//  ViewController.swift
//  NBC_4W_Caculator
//
//  Created by 황석현 on 11/11/24.
//

import UIKit

class ViewController: UIViewController {
    
    let buttonTitles: [[String]] = [["7", "8", "9", "+"],
                                    ["4", "5", "6", "-"],
                                    ["1", "2", "3", "*"],
                                    ["AC", "0", "=", "/"]]
    
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
        setupView()
    }
    
    func setupView() {
        setupMainLabel()
        setGridStackView()
    }
    
    // 입력한 숫자를 표시하는 레이블을 추가하는 함수
    private func setupMainLabel() {
        view.addSubview(mainLabel)
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            mainLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            mainLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            mainLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setGridStackView() {
        var arrangedSubviews: [UIStackView] = []
        
        for row in buttonTitles {
            arrangedSubviews.append(setupHStackView(row))
        }
        
        let gridStackView = UIStackView(arrangedSubviews: arrangedSubviews)
        
        gridStackView.axis = .vertical
        gridStackView.backgroundColor = .black
        gridStackView.spacing = 10
        gridStackView.distribution = .fillEqually
        
        gridStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gridStackView)
        
        NSLayoutConstraint.activate([
            gridStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            gridStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            gridStackView.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 60),
            gridStackView.heightAnchor.constraint(equalToConstant: 350),
            gridStackView.centerXAnchor.constraint(equalTo: super.view.centerXAnchor)
        ])
    }
    
    
    
    // 수평스택뷰를 추가하는 함수
    private func setupHStackView(_ elements: [String]) -> UIStackView {
        var buttons: [UIButton] = []
        
        for item in elements {
            let button = makeButton(item)
            button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
            buttons.append(button)
        }
        
        let stackView = UIStackView(arrangedSubviews: buttons)
        
        stackView.axis = .horizontal
        stackView.backgroundColor = .black
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        
        return stackView
    }
    
    // 타이틀을 입력받고 입력받은 타이틀에 대해서 색깔을 변경하는 함수
    private func makeButton(_ title: String) -> UIButton {
        let button = UIButton()
        
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        if Int(title) != nil {
            button.backgroundColor = UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0)
        } else {
            button.backgroundColor = .orange
        }
        button.frame.size.height = 80
        button.frame.size.width = 80
        button.layer.cornerRadius = 40
        
        return button
    }
    
    @objc private func buttonPressed(_ sender: UIButton) {
        print(sender.titleLabel?.text ?? "Unknown Button")
    }
}

