import Foundation

public struct Log {
    public enum Level: String {
        case debug = "DBG"
        case warn  = "WRN"
        case error = "ERR"
    }

    // MARK: - Static properties

    public static var logPrefix: String? {
        didSet { formattedPrefix = "[\(logPrefix)]" }
    }

    private static var formattedPrefix: String = ""

    // MARK: - Private properties

    private let owner: AnyObject

    // MARK: - Init

    public init(for owner: AnyObject) {
        self.owner = owner
    }

    // MARK: - Public methods

    public func log(_ level: Level, _ message: String) {
        let className = String(describing: type(of: owner))
        print("[][\(level.rawValue)][\(className)] \(message)")
    }

    public func log(_ message: String) {
        log(.debug, message)
    }
}
