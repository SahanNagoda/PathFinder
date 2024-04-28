//
//  PickingQtyView.swift
//  PathFinder
//
//  Created by Sahan Nagodavithana on 4/26/24.
//

import UIKit

/// A custom view for selecting picking quantity.
@IBDesignable
class PickingQtyView: UIView {
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    
    /// The current count of the picking quantity.
    var count: Int = 0 {
        didSet {
            if textField != nil {
                if !didEnterValue {
                    textField.text = String(count)
                }
            }
        }
    }
    
    /// The maximum allowed value for the picking quantity.
    var maxValue: String = "6"
    
    /// A closure to be executed when editing begins in the text field.
    var beginEditingViewCompletion: (() -> Void)?
    
    /// A closure to be executed when the picking quantity changes.
    var onChangeCompletion: ((Int) -> Void)?
    
    /// A boolean value indicating whether a value has been manually entered in the text field.
    var didEnterValue = false
    
    private let nibName = "PickingQtyXib"
    
    // MARK: - Initialization
    
    /// Initializes the view with a given frame.
    override init(frame: CGRect) {
        super.init(frame: frame)
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    /// Initializes the view from storyboard or xib.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let view = loadViewFromNib()
        guard let view = view else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    // MARK: - UI Setup
    
    /// Prepares the view for interface builder rendering.
    override func prepareForInterfaceBuilder() {
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textField.isUserInteractionEnabled = false
        setTxtValue(String(count))
        
        if plusButton != nil {
            let longPress = UILongPressGestureRecognizer(target: self,
                                                         action: #selector(plusLongPress(gesture:)))
            plusButton.addGestureRecognizer(longPress)
        }
        if minusButton != nil {
            let longPress = UILongPressGestureRecognizer(target: self,
                                                         action: #selector(minusLongPress(gesture:)))
            minusButton.addGestureRecognizer(longPress)
        }
    }
}

// MARK: - Custom Methods
extension PickingQtyView {
    
    /// Handles the long press gesture on the plus button.
    @objc private func plusLongPress(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            textField.text = maxValue
            count = Int(maxValue)!
            onChangeCompletion?(count)
        }
    }
    
    /// Handles the long press gesture on the minus button.
    @objc private func minusLongPress(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            textField.text = "4"
            count = 4
            onChangeCompletion?(count)
        }
    }
    
    private func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        return view
    }
    
    private func increment() {
        if count >= 6 {
            return
        } else if count < 3 {
            count = 3
        }
        count += 1
        setTxtValue(String(count))
        didEnterValue = false
        onChangeCompletion?(count)
    }
    
    private func decrement() {
        if count > 4 {
            count -= 1
        } else {
            count = 4
        }
        setTxtValue(String(count))
        didEnterValue = false
        onChangeCompletion?(count)
    }
    
    private func setTxtValue(_ value: String) {
        textField.text = value
    }
}

// MARK: - IBActions
extension PickingQtyView {
    
    /// Handles the action when the plus button is clicked.
    @IBAction func plusClicked(_ sendeR: UIButton) {
        increment()
    }
    
    /// Handles the action when the minus button is clicked.
    @IBAction func minusClicked(_ sender: UIButton) {
        decrement()
    }
}
