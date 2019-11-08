import UIKit

public extension UIEdgeInsets {
    static var none: UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    init(all value: CGFloat) {
        self.init(top: value, left: value, bottom: value, right: value)
    }

    init(all value: Double) {
        self.init(all: CGFloat(value))
    }
}
