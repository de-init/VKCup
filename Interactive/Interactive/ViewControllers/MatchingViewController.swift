import UIKit

class MatchingViewController: InteractiveViewController {
    
    //MARK: - Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Matching items"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .left
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var leftStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 8
        stack.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var rightStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 8
        stack.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private var heightStackView: CGFloat {
        CGFloat(view.bounds.height / 3)
    }
    
    private var widthStackView: CGFloat {
        CGFloat(view.bounds.width / 2)
    }
    
    private let dict: [Int : String] = [0 : "Тропосфера", 1 : "Стратосфера", 2 : "Мезосфера", 3 : "Термосфера"]
    private var keys: [Int] = []
    private var values: [String] = []
    private var senderValue: String?
    private var senderKey: Int!
    private var leftLastIndex = 0
    private var rightLastIndex = 0
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        creatingArrays()
        configureUI()
        setupStackViews()
    }
    
    //MARK: - Configure UI
    private func configureUI() {
        view.backgroundColor = .black
        view.addSubview(titleLabel)
        view.addSubview(rightStackView)
        view.addSubview(leftStackView)
    }
    
    private func setupStackViews() {
        createLeftStackViewItems(stackView: leftStackView, titles: values)
        createRightStackViewItems(stackView: rightStackView, titles: keys)
    }
    
    //MARK: -  Helpers methods
    private func creatingArrays() {
        var temp: [Int] = []
        for (key, value) in dict {
            temp.append(key)
            values.append(value)
        }
        keys = temp.sorted(by: { $1 > $0 })
    }
    
    //MARK: - Handle tap
    @objc private func handleTap(_ sender: CustomGesture) {
        if let opView = sender.view {
            animateSelection(view: opView)
        }
        let tapDirection = sender.location(in: view).x
        if tapDirection < view.bounds.midX {
            senderValue = sender.string
            if let a = sender.view?.tag {
                leftLastIndex = a
            }
            sender.view?.backgroundColor = UIColor(hex: 0xA8DADC)
        } else {
            let int = (sender.string as NSString).integerValue
            senderKey = int
            if let z = sender.view?.tag {
                rightLastIndex = z
            }
            sender.view?.backgroundColor = UIColor(hex: 0xA8DADC)
        }
        
        if senderValue != nil && senderKey != nil {
            if senderValue == dict[senderKey] {
                leftStackView.arrangedSubviews[leftLastIndex].isUserInteractionEnabled = false
                rightStackView.arrangedSubviews[rightLastIndex].isUserInteractionEnabled = false
                correctAnimation(firstView: leftStackView.arrangedSubviews[leftLastIndex], secondView:
                                    rightStackView.arrangedSubviews[rightLastIndex])
                senderKey = nil
                senderValue = nil
            } else {
                leftStackView.arrangedSubviews[leftLastIndex].backgroundColor = UIColor(hex: 0xE63946)
                rightStackView.arrangedSubviews[rightLastIndex].backgroundColor = UIColor(hex: 0xE63946)
                incorrectAnimation(on: leftStackView.arrangedSubviews[leftLastIndex])
                incorrectAnimation(on: rightStackView.arrangedSubviews[rightLastIndex])
                DispatchQueue.delay(delay: 0.3) {
                    self.leftStackView.arrangedSubviews[self.leftLastIndex].backgroundColor = .black
                    self.rightStackView.arrangedSubviews[self.rightLastIndex].backgroundColor = .black
                }
                senderKey = nil
                senderValue = nil
            }
        }
    }
    
    //MARK: - Animations
    private func animateSelection(view: UIView) {
        let feedback = UIImpactFeedbackGenerator(style: .light)
        feedback.prepare()
        UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseInOut) {
            view.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        } completion: { _ in
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut) {
                view.transform = .identity
            }
        }
    }
    
    private func correctAnimation(firstView: UIView, secondView: UIView) {
        let feedback = UINotificationFeedbackGenerator()
        feedback.notificationOccurred(.success)
        feedback.prepare()
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut) {
            firstView.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
            firstView.backgroundColor = UIColor(hex: 0x588157)
            secondView.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
            secondView.backgroundColor = UIColor(hex: 0x588157)
        } completion: { _ in
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut) {
                firstView.transform = .identity
                secondView.transform = .identity
            }
        }
    }
    
    private func incorrectAnimation(on onView: UIView) {
        let feedback = UINotificationFeedbackGenerator()
        feedback.notificationOccurred(.error)
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: onView.center.x - 5, y: onView.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: onView.center.x + 5, y: onView.center.y))
        onView.layer.add(animation, forKey: "position")
    }
    
    //MARK: - Layout
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            
            leftStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            leftStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            leftStackView.heightAnchor.constraint(equalToConstant: heightStackView),
            leftStackView.widthAnchor.constraint(equalToConstant: widthStackView),
            
            rightStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            rightStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            rightStackView.heightAnchor.constraint(equalToConstant: heightStackView),
            rightStackView.widthAnchor.constraint(equalToConstant: widthStackView)
        ])
    }
}

//MARK: - Extension
extension MatchingViewController {
    func createLeftStackViewItems(stackView: UIStackView, titles: [String]) {
        for i in titles {
            // Label
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 30, weight: .medium)
            label.text = i
            label.textAlignment = .center
            label.textColor = UIColor(hex: 0xfaedcd)
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            label.adjustsFontSizeToFitWidth = true
            label.sizeToFit()
            // View
            let view = UIView()
            view.backgroundColor = .black
            view.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(label)
            view.addCornerRadiusAndBorder(label.bounds.height / 2, border: 2)
            // Constraints
            view.heightAnchor.constraint(equalToConstant: label.frame.height + 30).isActive = true
            view.widthAnchor.constraint(equalToConstant: label.frame.width + 20).isActive = true
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
            // Adding
            stackView.addArrangedSubview(view)
            // Gesture
            let tap = CustomGesture.init(target: self, action: #selector(handleTap(_:)))
            tap.string = i
            view.addGestureRecognizer(tap)
        }
        
        for i in 1...leftStackView.arrangedSubviews.count - 1 {
            leftStackView.arrangedSubviews[i].tag = i
        }
    }
    
    func createRightStackViewItems(stackView: UIStackView, titles: [Int]) {
        for i in titles {
            // Label
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 30, weight: .medium)
            label.text = "\(i)"
            label.textAlignment = .center
            label.textColor = UIColor(hex: 0xFAEDCD)
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            label.sizeToFit()
            // View
            let view = UIView()
            view.backgroundColor = .black
            view.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(label)
            view.addCornerRadiusAndBorder(label.bounds.width, border: 2)
            // Constraints
            view.heightAnchor.constraint(equalToConstant: label.frame.height + 30).isActive = true
            view.widthAnchor.constraint(equalToConstant: label.frame.width + 30).isActive = true
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            // Adding
            stackView.addArrangedSubview(view)
            // Gesture
            let tap = CustomGesture.init(target: self, action: #selector(handleTap(_:)))
            tap.string = "\(i)"
            view.addGestureRecognizer(tap)
        }
        for i in 1...rightStackView.arrangedSubviews.count - 1 {
            rightStackView.arrangedSubviews[i].tag = i
        }
    }
}
