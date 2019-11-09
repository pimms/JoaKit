// Thanks to FINN.no's FinniversKit
// https://github.com/finn-no/FinniversKit
// FinniversKit is licensed under the Apache 2.0 License.
//
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import UIKit

/***
 * Example Usage, courtesy of FinniversKit:
 *
 *      override func viewDidLoad() {
 *          super.viewDidLoad()
 *          NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
 *      }
 *
 *      func handleKeyboard(_ notification: Notification) {
 *          guard let keyboardInfo = KeyboardNotificationInfo(notification) else { return }
 *          let keyboardIntersection = keyboardInfo.keyboardFrameEndIntersectHeight(inView: wrapperView)
 *          if keyboardIntersection > 0 {
 *              let wrapperBottomOffset = keyboardIntersection + windowSafeAreaInsets.bottom
 *              wrapperViewBottomConstraint.constant = -wrapperBottomOffset
 *              UIView.animateAlongsideKeyboard(keyboardInfo: keyboardInfo) { [weak self] in
 *                  self?.view.layoutIfNeeded()
 *              }
 *          }
 *      }
 */

public struct KeyboardNotificationInfo {
    public enum KeyboardAction {
        case willShow
        case willHide
    }

    public let animationOptions: UIView.AnimationOptions
    public let animationDuration: Double
    public let frameStart: CGRect?
    public let frameEnd: CGRect?
    public let action: KeyboardAction

    public init?(_ notification: Notification) {
        guard let keyboardAction = notification.keyboardNotificationAction, let userInfo = notification.userInfo else { return nil }
        action = keyboardAction

        if let animationCurve = userInfo[UIWindow.keyboardAnimationCurveUserInfoKey] as? NSNumber {
            animationOptions = UIView.AnimationOptions(rawValue: animationCurve.uintValue)
        } else {
            animationOptions = []
        }

        animationDuration = (userInfo[UIWindow.keyboardAnimationDurationUserInfoKey] as? Double) ?? 0
        frameStart = userInfo[UIWindow.keyboardFrameBeginUserInfoKey] as? CGRect
        frameEnd = userInfo[UIWindow.keyboardFrameEndUserInfoKey] as? CGRect
    }

    /// Calculate the total intersection between the keyboard and a view. The value returned
    /// will be between 0 and whatever intersection occurs. This is in case the user has
    /// an iPad with an external keyboard connected, which would've returned a negative value.
    public func keyboardFrameEndIntersectHeight(inView view: UIView) -> CGFloat {
        guard let frameEnd = frameEnd else { return 0 }
        let frameInWindow = view.convert(view.bounds, to: nil)
        let intersection = frameEnd.intersection(frameInWindow)
        let safeInsetBottom: CGFloat = view.safeAreaInsets.bottom

        let viewMaxY = frameInWindow.origin.y + frameInWindow.height
        let keyboardMaxY = frameEnd.origin.y + frameEnd.height
        let outOfBoundsHeight = max(0, viewMaxY - keyboardMaxY)

        return max(0, intersection.height + outOfBoundsHeight - safeInsetBottom)
    }
}

// MARK: - Private extensions

private extension Notification {
    var keyboardNotificationAction: KeyboardNotificationInfo.KeyboardAction? {
        switch self.name {
        case UIResponder.keyboardWillHideNotification:
            return .willHide
        case UIResponder.keyboardWillShowNotification:
            return .willShow
        default:
            return nil
        }
    }
}

// MARK: - UIView

public extension UIView {
    class func animateAlongsideKeyboard(keyboardInfo: KeyboardNotificationInfo, animations: @escaping () -> Void, completion: ((Bool) -> Void)? = nil) {
        let animationDuration = keyboardInfo.animationDuration
        let animationOptions = keyboardInfo.animationOptions

        animate(withDuration: animationDuration, delay: 0, options: animationOptions, animations: animations, completion: completion)
    }

    class func animateAlongsideKeyboard(keyboardInfo: KeyboardNotificationInfo, animations: @escaping () -> Void) {
        animateAlongsideKeyboard(keyboardInfo: keyboardInfo, animations: animations, completion: nil)
    }
}

