//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import UIKit

public class Label: UILabel {

    // MARK: - Properties

    public private(set) var style: Style?

    // MARK: - Setup

    public init(style: Style) {
        super.init(frame: .zero)
        self.style = style
        setup()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        isAccessibilityElement = true

        accessibilityLabel = text
        font = style?.font
        textColor = .label
    }
}

// MARK: - Style

extension Label {
    public enum Style {
        case title1
        case title2
        case title3
        case body
        case bodyStrong
        case detail

        var font: UIFont {
            switch self {
            case .title1: return UIFont.title1
            case .title2: return UIFont.title2
            case .title3: return UIFont.title3
            case .body: return UIFont.body
            case .bodyStrong: return UIFont.bodyStrong
            case .detail: return UIFont.detail
            }
        }

        var padding: UIEdgeInsets {
            return UIEdgeInsets(top: lineSpacing, left: 0, bottom: 0, right: 0)
        }

        var lineSpacing: CGFloat {
            switch self {
            case .title1: return font.pointSize * 0.5
            case .title2: return font.pointSize * 0.5
            case .title3: return font.pointSize * 0.5
            default: return 0
            }
        }
    }
}

