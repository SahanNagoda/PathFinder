//
//  PickingQtyView.swift
//  PathFinder
//
//  Created by Sahan Nagodavithana on 4/26/24.
//

import UIKit

@IBDesignable
class PickingQtyView: UIView {
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var textField: UITextField!

    var count: Int = 0 {
        didSet {
            if textField != nil {
                if !didEnterValue {
                    textField.text = String(count)
                }
            }
        }
    }
    var orderedQty: String = "6"
    var beginEditingViewCompletion: (() -> Void)?
    var onChangeCompletion: ((Int) -> Void)?
    var didEnterValue = false

    let nibName = "PickingQtyXib"

    // MARK: - Initialisation
    override init(frame: CGRect) {
        super.init(frame: frame)
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let view = loadViewFromNib()
        guard let view = view else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }

    // MARK: - UI Setup
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

// Custom Methods
extension PickingQtyView {
    @objc private func plusLongPress(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            textField.text = orderedQty
            count = Int(orderedQty)!
            onChangeCompletion?(count)
        }
    }

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

// MARK: IBActions
extension PickingQtyView {
    @IBAction func plusClicked(_ sendeR: UIButton) {
        increment()
    }

    @IBAction func minusClicked(_ sender: UIButton) {
        decrement()
    }
}

