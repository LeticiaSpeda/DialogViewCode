//
//  ViewController.swift
//  dialog
//
//  Created by Leticia Speda on 12/09/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    private lazy var xmarkButton: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "xmark")
        img.tintColor = .red
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    
    private lazy var dialogView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private lazy var mainVStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var titleDialog: UILabel = {
        let label = UILabel()
        label.text = "Ops.. Algo deu errado!"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptonDialog: UILabel = {
        let label = UILabel()
        label.text = "Em breve estará de volta"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.numberOfLines = 4
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("OK", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.cornerRadius = 7
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        commonInit()
    }

    
    
    private func commonInit() {
        configureHierarchy()
        configureContraints()
      
    }
    
    private func configureHierarchy() {
        view.addSubview(dialogView)
        dialogView.addSubview(xmarkButton)
        dialogView.addSubview(mainVStack)
        mainVStack.addArrangedSubview(.init())
        mainVStack.addArrangedSubview(titleDialog)
        mainVStack.addArrangedSubview(descriptonDialog)
        mainVStack.addArrangedSubview(closeButton)
    }
    
    private func configureContraints() {
        NSLayoutConstraint.activate([

            dialogView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            dialogView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            dialogView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant:  -30),

            
            xmarkButton.topAnchor.constraint(equalTo: dialogView.topAnchor,constant: 16),
            xmarkButton.trailingAnchor.constraint(equalTo: dialogView.trailingAnchor, constant: -16),
            xmarkButton.heightAnchor.constraint(equalToConstant: 26),
            xmarkButton.widthAnchor.constraint(equalToConstant: 26),
            
            
            mainVStack.topAnchor.constraint(equalTo: xmarkButton.bottomAnchor, constant: 10),
            mainVStack.leadingAnchor.constraint(equalTo: dialogView.leadingAnchor, constant: 16),
            mainVStack.trailingAnchor.constraint(equalTo: dialogView.trailingAnchor, constant: -16),
            mainVStack.bottomAnchor.constraint(equalTo: dialogView.bottomAnchor, constant: -20),

            closeButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
    

}

