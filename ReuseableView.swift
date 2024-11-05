//
//  ReuseableView.swift
//  ALW
//
//  Created by Ahsan Khalil on 22/03/2021.
//

import UIKit

@IBDesignable class ReusableUIView: UIView {
    // MARK: - Properties
        @IBInspectable
        var color: UIColor = .clear {
            didSet {
                self.backgroundColor = color
            }
        }
        
        @IBInspectable
        var cornerRadius: CGFloat = 0 {
            didSet {
                self.layer.cornerRadius = cornerRadius
            }
        }
        
        @IBInspectable
        var shadowColor: UIColor = .clear {
            didSet {
                self.layer.shadowColor = shadowColor.cgColor
            }
        }
        
        @IBInspectable
        var shadowRadius: CGFloat = 0 {
            didSet {
                self.layer.shadowRadius = shadowRadius
            }
        }
        
        @IBInspectable
        var shadowOpacity: Float = 0 {
            didSet {
                self.layer.shadowOpacity = shadowOpacity
            }
        }
        
        @IBInspectable
        var borderWidth: CGFloat = 0 {
            didSet {
                self.layer.borderWidth = borderWidth
            }
        }
        
        @IBInspectable
        var borderColor: UIColor = .clear {
            didSet {
                self.layer.borderColor = borderColor.cgColor
            }
        }
    
    func setupView() {
        self.backgroundColor = color
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = shadowOpacity
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
}
