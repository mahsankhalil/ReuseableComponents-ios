//
//  InputView.swift
//  ALW
//
//  Created by Ahsan Khalil on 21/03/2021.
//

import UIKit
import DTTextField

protocol InputViewDelegate {
    func setErrorMessage(sender: InputView, inputValue: String) -> String?
    func onValueChange(sender: InputView, inputValue: String)
}

extension InputViewDelegate {
    func onValueChange(sender: InputView, inputValue: String) {
        
    }
}

@IBDesignable
class InputView: ReusableUIView {
    static let nibName = "InputView"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var inputTextField: DTTextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBInspectable var titleText: String = "" {
        didSet {
            titleLabel.text = titleText
        }
    }
    
    @IBInspectable var inputTextPlaceHolder: String = "" {
        didSet {
            inputTextField.placeholder = inputTextPlaceHolder
        }
    }
    
    @IBInspectable var errorText: String = "" {
        didSet {
            errorLabel.text = errorText
        }
    }
    
    @IBInspectable var isProtectedField: Bool = false {
        didSet {
            inputTextField.isSecureTextEntry = isProtectedField
        }
    }
    
    var delegate: InputViewDelegate?
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        setupView()
        
        inputTextField.borderWidth = 1
        inputTextField.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        errorLabel.text = ""
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: InputView.nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func configure(inputLabelTitle: String, inputTextFieldPlaceHolder:String) {
        errorText = ""
        inputTextPlaceHolder = inputTextFieldPlaceHolder
        titleText = inputLabelTitle
    }
    
    @IBAction func onFocusInInputText(_ sender: DTTextField) {
        errorLabel.text = ""
    }
    
    @IBAction func onFoucusOutInputText(_ sender: DTTextField) {
        errorLabel.text = ""
        if let delegate = delegate, let errorMessage = delegate.setErrorMessage(sender: self, inputValue: sender.text ?? "") {
            errorLabel.text = errorMessage
        }
    }
    
    @IBAction func onValueChangeInputText(_ sender: DTTextField) {
        if let delegate = delegate {
            delegate.onValueChange(sender: self,inputValue: sender.text ?? "")
        }
    }
}
