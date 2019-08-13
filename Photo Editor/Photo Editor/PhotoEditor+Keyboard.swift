//
//  PhotoEditor+Keyboard.swift
//  Pods
//
//  Created by Mohamed Hamed on 6/16/17.
//
//

import Foundation
import UIKit

extension PhotoEditorViewController {
    
    @objc func keyboardDidShow(notification: NSNotification) {
        if isTyping {
            doneButton.isHidden = false
            colorPickerView.isHidden = false
            hideToolbar(hide: true)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        isTyping = false
        doneButton.isHidden = true
        hideToolbar(hide: false)
    }
    
    @objc func keyboardWillChangeFrame(_ notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
            if (endFrame?.origin.y)! >= UIScreen.main.bounds.size.height {
                self.colorPickerViewBottomConstraint?.constant = 0.0
            } else {
                var bottomPadding : CGFloat = 0
                if #available(iOS 11.0, *) , let window = UIApplication.shared.keyWindow {
                    if window.safeAreaInsets.bottom > 0 {
                        bottomPadding = window.safeAreaInsets.bottom / 2
                    }
                }
                
                if let _  = endFrame {
                    self.colorPickerViewBottomConstraint?.constant = endFrame!.size.height - bottomPadding
                } else {
                    self.colorPickerViewBottomConstraint?.constant = 0
                }
            }
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }

}
