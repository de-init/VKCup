import UIKit

class QuestionCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var answerView_1: UIView!
    @IBOutlet weak var answerView_2: UIView!
    @IBOutlet weak var answerView_3: UIView!
    @IBOutlet weak var answerView_4: UIView!
    
    @IBOutlet weak var answerLabel_1: UILabel!
    @IBOutlet weak var answerLabel_2: UILabel!
    @IBOutlet weak var answerLabel_3: UILabel!
    @IBOutlet weak var answerLabel_4: UILabel!
    
    @IBOutlet weak var percentLabel_1: UILabel!
    @IBOutlet weak var percentLabel_2: UILabel!
    @IBOutlet weak var percentLabel_3: UILabel!
    @IBOutlet weak var percentLabel_4: UILabel!
    
    @IBOutlet weak var imageView_1: UIImageView!
    @IBOutlet weak var imageView_2: UIImageView!
    @IBOutlet weak var imageView_3: UIImageView!
    @IBOutlet weak var imageView_4: UIImageView!
    
    //MARK: - Properties
    static let reuseID = "QuestionCollectionViewCell"
    
    var selectedAnswer: ((_ correct: Bool) -> Void)?
    
    var correctAnswer: String!

    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    //MARK: - Configure cell
    func configure(question: String, answer1: String, answer2: String, answer3: String, answer4: String) {
        self.questionLabel.text = question
        self.answerLabel_1.text = answer1
        self.answerLabel_2.text = answer2
        self.answerLabel_3.text = answer3
        self.answerLabel_4.text = answer4
    }

    //MARK: - Configure UI
    private func configureUI() {
        [percentLabel_1, percentLabel_2, percentLabel_3, percentLabel_4].forEach({
            $0?.alpha = 0
            $0?.text = "100%"
        })
        
        [answerView_1, answerView_2, answerView_3, answerView_4].forEach({
            $0?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedOnView(_:))))
            $0?.layer.cornerRadius = 5
            $0?.backgroundColor = UIColor(hex: 0xE5EAF0)
        })
    }
    
    //MARK: - Helper methods
    @objc private func tappedOnView(_ sender: UITapGestureRecognizer) {
        if sender.view == answerView_1 {
            if answerLabel_1.text == correctAnswer {
                correctAnimate(view: answerView_1)
            } else {
                incorrectAnimate(view: answerView_1)
            }
        } else if sender.view == answerView_2 {
            if answerLabel_2.text == correctAnswer {
                correctAnimate(view: answerView_2)
            } else {
                incorrectAnimate(view: answerView_2)
            }
        } else if sender.view == answerView_3 {
            if answerLabel_3.text == correctAnswer {
                correctAnimate(view: answerView_3)
            } else {
                incorrectAnimate(view: answerView_3)
            }
        } else if sender.view == answerView_4 {
            if answerLabel_4.text == correctAnswer {
                correctAnimate(view: answerView_4)
            } else {
                incorrectAnimate(view: answerView_4)
            }
        }
    }
    
    private func correctAnimate(view: UIView) {
        let gerenator = UINotificationFeedbackGenerator()
        gerenator.notificationOccurred(.success)
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut) {
            view.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
            view.backgroundColor = UIColor(hex: 0x99D98C)
            [self.percentLabel_1, self.percentLabel_2, self.percentLabel_3, self.percentLabel_4].forEach({ $0?.alpha = 1 })
        }
    }
    
    private func incorrectAnimate(view: UIView) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut) {
            view.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
            view.backgroundColor = UIColor(hex: 0xEF233C)
            [self.percentLabel_1, self.percentLabel_2, self.percentLabel_3, self.percentLabel_4].forEach({ $0?.alpha = 1 })
        }
    }
}
