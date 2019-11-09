import UIKit

public extension UITableView {
    func register(_ cellClass: UITableViewCell.Type) {
        register(cellClass.self, forCellReuseIdentifier: String(describing: cellClass))
    }

    func registerNib(_ cellClass: UITableViewCell.Type) {
        let name = String(describing: cellClass)
        register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: name)
    }

    func dequeue<T>(_ cellClass: T.Type, for indexPath: IndexPath) -> T where T: UITableViewCell {
        return dequeueReusableCell(withIdentifier: String(describing: cellClass), for: indexPath) as! T
    }
}
