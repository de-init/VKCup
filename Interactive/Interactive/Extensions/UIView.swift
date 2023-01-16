import UIKit

extension UIView {
    func addCornerRadiusAndBorder(_ radius: CGFloat, border: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
        layer.borderWidth = border
        layer.borderColor = UIColor(hex: 0xFAEDCD).cgColor
    }
}

