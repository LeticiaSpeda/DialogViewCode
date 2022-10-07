//
//  ViewController.swift
//  dialog
//
//  Created by Leticia Speda on 12/09/22.
//

import UIKit

final class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let dialog = DialogController()
            self.present(dialog, animated: false)
        }
    }
}


final class DialogController: UIViewController {
    
    //MARK: - UI Components
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(systemName: "xmark"), for: .normal)
        button.titleLabel?.textAlignment = .right
        button.tintColor = .red
        button.addTarget(
            self, action: #selector(buttonDidTapped),
            for: .touchUpInside
        )
        button.enableViewCode()
        return button
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = .zero
        view.enableViewCode()
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constant.titleText
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = Constant.subtitleText
        label.textAlignment = .left
        label.numberOfLines = .zero
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    private lazy var okButton: UIButton = {
        let bc = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        let button = UIButton()
        button.setTitle(Constant.okButtonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.layer.cornerRadius = 7
        button.backgroundColor = bc
        button.addTarget(
            self, action: #selector(buttonDidTapped),
            for: .touchUpInside
        )
        button.enableViewCode()
        return button
    }()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = Constant.stackSpacing
        stack.enableViewCode()
        return stack
    }()
    
    //MARK: - Initializer
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        modalPresentationStyle = .overCurrentContext
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        onViewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showAlert()
    }
    
    //MARK: - Helper
    private func onViewDidLoad() {
        configureAccessibility()
        configureStyle()
        configureHierarchy()
        configureConstraints()
    }
    
    
    private func configureAccessibility() {
        configureCloseButtonAccessibility()
        configureTitleLabelAccessibility()
        configureSubtitleLabelAccessibility()
        configureOkButtonAccessibility()
    }
    
    private func configureCloseButtonAccessibility() {
        closeButton.accessibilityLabel = "Fechar"
        closeButton.accessibilityTraits = .button
    }
    
    private func configureTitleLabelAccessibility() {
        titleLabel.accessibilityLabel = "Ops Algo deu errado"
        titleLabel.accessibilityTraits = .staticText
    }
    
    private func configureSubtitleLabelAccessibility() {
        subtitleLabel.accessibilityLabel = "Em breve estará de volta"
        subtitleLabel.accessibilityTraits = .staticText
    }
    
    private func configureOkButtonAccessibility() {
        okButton.accessibilityLabel = "Ok"
        okButton.accessibilityTraits = .button
    }
    
    
    
    private func configureStyle() {
        view.backgroundColor = .black.withAlphaComponent(.zero)
    }
    
    private func configureHierarchy() {
        mainStack.addArrangedSubview(titleLabel)
        mainStack.addArrangedSubview(subtitleLabel)
        mainStack.addArrangedSubview(okButton)
        
        contentView.addSubview(closeButton)
        contentView.addSubview(mainStack)
        
        view.addSubview(contentView)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Constant.stackVPadding
            ),
            
            closeButton.rightAnchor.constraint(
                equalTo: contentView.rightAnchor,
                constant: -Constant.stackHPadding
            ),
            
            okButton.heightAnchor.constraint(
                equalToConstant: Constant.okButtonHeight
            ),
            
            mainStack.topAnchor.constraint(
                equalTo: closeButton.bottomAnchor,
                constant: Constant.stackVPadding
            ),
            mainStack.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Constant.stackHPadding
            ),
            mainStack.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Constant.stackHPadding
            ),
            contentView.bottomAnchor.constraint(
                equalTo: mainStack.bottomAnchor,
                constant: Constant.stackVPadding
            ),
            
            contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentView.leadingAnchor.constraint(
                lessThanOrEqualTo: view.leadingAnchor,
                constant: Constant.contentHPadding
            ),
            contentView.trailingAnchor.constraint(
                lessThanOrEqualTo: view.trailingAnchor,
                constant: -Constant.contentHPadding
            ),
        ])
    }
    
    private func showAlert() {
        UIView.animate(
            withDuration: Constant.inDuration, delay: Constant.inDelay,
            usingSpringWithDamping: Constant.inDamping,
            initialSpringVelocity: .zero, options: [.curveEaseIn]
        ) { self.configureVisibility(true) }
    }
    
    private func hideAlert() {
        UIView.animate(
            withDuration: Constant.outDuration,
            delay: .zero, options: [.curveEaseOut]
        ) { self.configureVisibility(false) } completion: { didFinish in
            guard didFinish else { return }
            self.dismiss(animated: false)
        }
    }
    
    private func configureVisibility(_ shouldShow: Bool) {
        let alphaValue: CGFloat = shouldShow ? Constant.inAlpha : Constant.outAlpha
        let bgalphaValue: CGFloat = shouldShow ? Constant.inBGAlpha : Constant.outBGAlpha
        let transform: CGFloat = shouldShow ? Constant.inTransform : Constant.outTransform
        contentView.alpha = alphaValue
        contentView.transform = CGAffineTransform(scaleX: transform, y:transform)
        view.backgroundColor = .black.withAlphaComponent(bgalphaValue)
    }
    
    //MARK: - Selector
    @objc private func buttonDidTapped() {
        hideAlert()
    }
    
}

extension UIView {
    func enableViewCode() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}
