import UIKit

public extension UICollectionView {
    func register(_ cellClass: UICollectionViewCell.Type) {
        register(cellClass.self, forCellWithReuseIdentifier: String(describing: cellClass))
    }

    func registerNib(_ cellClass: UICollectionViewCell.Type) {
        let name = String(describing: cellClass)
        register(UINib(nibName: name, bundle: nil), forCellWithReuseIdentifier: name)
    }

    func dequeue<T>(_ cellClass: T.Type, for indexPath: IndexPath) -> T where T: UICollectionViewCell {
        return dequeueReusableCell(withReuseIdentifier: String(describing: cellClass), for: indexPath) as! T
    }
}
