//
//  ViewController.swift
//  NBC_4W_Caculator
//
//  Created by 황석현 on 11/11/24.
//

import UIKit

class ViewController: UIViewController {
    
    var inputs: String = ""
    var numberInputs: [String] = []
    var symbolInputs: [String] = []
    
    let buttonTitles: [[String]] = [["7", "8", "9", "+"],
                                    ["4", "5", "6", "-"],
                                    ["1", "2", "3", "*"],
                                    ["AC", "0", "=", "/"]]
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .right
        label.font = .boldSystemFont(ofSize: .init(60))
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 배경색 변경
        view.backgroundColor = .black
        // 뷰 생성
        setupView()
    }
    
    /// 뷰들을 세팅하는 함수
    func setupView() {
        setupMainLabel()
        setGridStackView()
    }
    
    /// 입력한 숫자를 표시하는 레이블을 추가하는 함수
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
    
    /// 그리드 스택뷰를 생성하는 함수
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
    
    
    
    /// 수평스택뷰를 추가하는 함수
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
    
    /// 타이틀을 입력받고 입력받은 타이틀에 대해서 색깔을 변경하는 함수
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
    
    /// 버튼이 눌러졌을 때 호출되는 함수
    @objc private func buttonPressed(_ sender: UIButton) {
        let button = sender.titleLabel?.text ?? "Unknown Button"
        handleButtonPressed(button)
        enteringValue()
    }
    
    /// 버튼에 따라 호출할 함수를 판단
    private func handleButtonPressed(_ button: String) {
        switch button {
        case "0"..."9" :
            numberButtonPressed(button)
        case "+" :
            plusButtonPressed()
        case "-" :
            minusButtonPressed()
        case "*" :
            multiplyButtonPressed()
        case "/" :
            divideButtonPressed()
        case "=" :
            equalButtonPressed()
        case "AC" :
            allclearButtonPressed()
        default:
            print("Unknown Button Pressed!")
        }
    }
    
    /// 숫자버튼 터치
    private func numberButtonPressed(_ num: String) {
        print("NumberButtonPressed:\(num)")
        mainLabel.text?.append(num)
        inputs.append(num)
    }
    
    /// 더하기버튼 터치
    private func plusButtonPressed() {
        print("PlusButtonPressed")
        mainLabel.text?.append("+")
        symbolInputs.append("+")
        numberInputs.append(inputs)
        inputs = ""
    }
    
    /// 빼기버튼 터치
    private func minusButtonPressed() {
        print("MinusButtonPressed")
        mainLabel.text?.append("-")
        symbolInputs.append("-")
        numberInputs.append(inputs)
        inputs = ""
    }
    
    /// 곱하기버튼 터치
    private func multiplyButtonPressed() {
        print("MultiplyButtonPressed")
        mainLabel.text?.append("*")
        symbolInputs.append("*")
        numberInputs.append(inputs)
        inputs = ""
    }
    
    /// 나누기버튼 터치
    private func divideButtonPressed() {
        print("DivideButtonPressed")
        mainLabel.text?.append("/")
        symbolInputs.append("/")
        numberInputs.append(inputs)
        inputs = ""
    }
    
    /// 등호버튼 터치
    private func equalButtonPressed() {
        print("EqualButtonPressed")
        symbolInputs.append("=")
        numberInputs.append(inputs)
        runnimgNumbers()
        inputs = ""
        numberInputs = []
        symbolInputs = []
    }
    
    /// 입력된 데이터를 기준으로 연산하는 함수
    private func runnimgNumbers () {
        // 초기 값을 numberInputs의 첫번째 요소로 초기화
        var result = Int(numberInputs[0])!
        for (num, symbol) in zip(self.numberInputs.dropFirst(), self.symbolInputs) {
            if let number = Int(num) {
                switch symbol {
                case "+":
                    result += number
                case "-":
                    result -= number
                case "*":
                    result *= number
                case "/":
                    result /= number
                case "=":
                    print("Running Numbers!")
                default:
                    print("Wrong Process")
                }
            }
        }
        // 결과값은 화면에만 출력
        self.mainLabel.text = String(result)
    }
    
    /// AC버튼 터치
    private func allclearButtonPressed() {
        print("AllclearButtonPressed")
        mainLabel.text = "0"
    }
    
    /// 메인레이블이 "0"이면 return
    /// 만약 메인레이블의 첫 문자가 "0"이면 첫번째 요소 삭제
    private func enteringValue() {
        guard mainLabel.text != "0" else { return }
        if mainLabel.text?.first == "0" {
            mainLabel.text?.remove(at: self.mainLabel.text!.startIndex)
        }
    }
}

