import UIKit

public extension UIView {
    func fillInSuperview() {
        fillInSuperview(insets: .none)
    }

    func fillInSuperview(margins: Double) {
        fillInSuperview(insets: UIEdgeInsets(all: margins))
    }

    func fillInSuperview(insets: UIEdgeInsets) {
        guard let superview = superview else { return }

        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.left),
            topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -insets.right),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -insets.bottom),
        ])
    }
}
