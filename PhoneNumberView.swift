//
//  PhoneNumberView.swift
//  ALW
//
//  Created by Ahsan Khalil on 22/03/2021.
//

import UIKit
import FlagPhoneNumber

protocol PhoneNumberViewDelegate {
    func presentCountryListViewController(viewController: UIViewController)
}

class PhoneNumberView: ReusableUIView {
    static let nibName = "PhoneNumberView"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var flagPhoneNumberTextField: FPNTextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    var delegate: PhoneNumberViewDelegate?
    
    func configure(inputTitleLable:String, defaultCountry: FPNCountryCode = .SA, countrySelectionMode: FPNTextField.FPNDisplayMode = .list, flagSize: CGSize = CGSize(width: 50, height: 50)) {
        titleText = inputTitleLable
        flagPhoneNumberTextField.configure(defaultCountry: defaultCountry, displayMode: countrySelectionMode, flagSize: flagSize)
    }
    
    func getNumber() -> String? {
        return flagPhoneNumberTextField.getFormattedPhoneNumber(format: FPNFormat.E164)
    }
    
    func isValidPhoneNumber() -> Bool {
        return flagPhoneNumberTextField.isValidPhoneNumber()
    }
    
    @IBInspectable var titleText: String = "" {
        didSet {
            titleLabel.text = titleText
        }
    }
    
    var errorText: String = "" {
        didSet {
            errorLabel.text = errorText
        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        setupView()
        
        flagPhoneNumberTextField.layer.borderWidth = 1
        flagPhoneNumberTextField.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        flagPhoneNumberTextField.layer.cornerRadius = 6
        flagPhoneNumberTextField.delegate = self
        errorLabel.text = ""
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: PhoneNumberView.nibName, bundle: bundle)
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
    
    
    @IBAction func onFocusInInputText(_ sender: FPNTextField) {
        errorText = ""
    }
    
    @IBAction func onFoucusOutInputText(_ sender: FPNTextField) {
        errorText = ""
        if sender.text!.isEmpty {
            errorLabel.text = "Phone Number cannot be empty"
        } else if !sender.isValidPhoneNumber() {
            errorLabel.text = "Please Enter Valid Phone Number"
        }
    }
}

extension PhoneNumberView: FPNTextFieldDelegate {
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        flagPhoneNumberTextField.updatePlaceHolder(countryCode: code)
    }
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        if isValid {
            if textField.isMobileNumberType() {
                print("valid case")
            } else {
                print("not required case")
            }
        } else {
            print("not valid case")
        }
    }
    
    func fpnDisplayCountryList() {
        if let delegate = delegate {
            delegate.presentCountryListViewController(viewController: flagPhoneNumberTextField.getCountryListController())
        }
    }
}
