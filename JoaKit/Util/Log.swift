import Foundation

public struct Log {
    public enum Level: String {
        case debug = "DBG"
        case warn  = "WRN"
        case error = "ERR"
    }

    // MARK: - Static properties

    public static var logPrefix: String? {
        didSet {
            if let prefix = logPrefix {
                formattedPrefix = "[\(prefix)]"
            } else {
                formattedPrefix = ""
            }
        }
    }

    private static var formattedPrefix: String = ""

    // MARK: - Private properties

    private let owner: AnyObject
    private let ownerClassName: String

    // MARK: - Init

    public init(for owner: AnyObject) {
        self.owner = owner
        self.ownerClassName = String(describing: type(of: owner))
    }

    // MARK: - Public methods

    public func log(_ level: Level, _ message: String) {
        print("\(Self.formattedPrefix)[\(level.rawValue)][\(ownerClassName)] \(message)")
    }

    public func log(_ message: String) {
        log(.debug, message)
    }
}
