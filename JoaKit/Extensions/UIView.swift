import UIKit

public extension UIView {
    convenience init(withAutoLayout autoLayout: Bool) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = !autoLayout
    }

    func dropShadow(color: UIColor, opacity: Float = 0.5, offset: CGSize = CGSize.zero, radius: CGFloat = 10.0) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.rasterizationScale = UIScreen.main.scale
    }

    func fillInSuperview() {
        fillInSuperview(insets: .none)
    }

    func fillInSuperview(margins: Double) {
        fillInSuperview(insets: UIEdgeInsets(all: margins))
    }

    func fillInSuperview(margins: CGFloat) {
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

    func removeAllConstraints() {
        // All credits to marchinram @ StackOverflow:
        // https://stackoverflow.com/a/30491911
        var _superview = superview

        while let superview = _superview {
            for constraint in superview.constraints {
                if let first = constraint.firstItem as? UIView, first == self {
                    superview.removeConstraint(constraint)
                }

                if let second = constraint.secondItem as? UIView, second == self {
                    superview.removeConstraint(constraint)
                }
            }

            _superview = superview.superview
        }

        removeConstraints(constraints)
    }
}
