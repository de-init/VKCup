import UIKit

struct Interactive {
    var name: String
    var image: UIImage!
    var color: UIColor
    var type: InteractiveViewController.Type
}

extension Interactive {
    public static var all: [Interactive] {
        return [
            Interactive(name: "Quiz", image: UIImage(named: "Quiz"), color: UIColor(hex: 0xA3C4F3), type: QuizViewController.self),
            Interactive(name: "Matching", image: UIImage(named: "Matching"), color: UIColor(hex: 0xF3746B), type: MatchingViewController.self),
            Interactive(name: "DragAndDrop", image: UIImage(named: "DragAndDrop"), color: UIColor(hex: 0x14A7FF), type: DragAndDropViewController.self),
            Interactive(name: "FillForm", image: UIImage(named: "FillForm"), color: UIColor(hex: 0x744ABD), type: FillFormViewController.self),
            Interactive(name: "Rating", image: UIImage(named: "Rating"), color: UIColor(hex: 0xFFD06A), type: RatingViewController.self)
        ]
    }
}
