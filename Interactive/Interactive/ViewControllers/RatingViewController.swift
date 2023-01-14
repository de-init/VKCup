import UIKit
import Lottie

class RatingViewController: InteractiveViewController {
    
    //MARK: - Properties
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 10
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        stack.addGestureRecognizer(pan)
        stack.addGestureRecognizer(tap)
        return stack
    }()
    
    private let labelText: UILabel = {
        let label = UILabel()
        label.text = "Reader review"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .center
        label.textColor = UIColor(hex: 0xF4F3EE)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let splashAnimation: LottieAnimationView = {
        let view = LottieAnimationView(name: "Splash")
        view.contentMode = .scaleAspectFit
        view.loopMode = .playOnce
        view.frame.size = CGSize(width: 500, height: 500)
        return view
    }()
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xE5E5E5).withAlphaComponent(0.15)
        view.clipsToBounds = true
        view.layer.cornerRadius = 30
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let starsCount: Int = 5
    private var selectedRate = 0
    private let horizontalInset: CGFloat = 30
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Helpers methods
    @objc private func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        let location = sender.location(in: self.stackView)
        switch sender.state {
        case .began, .changed:
            let starWidth = stackView.bounds.width / CGFloat(starsCount)
            let rate = Int(location.x / starWidth) + 1
            
            if rate != self.selectedRate && rate < 6 {
                self.selectedRate = rate
            }
            stackView.arrangedSubviews.forEach({ subview in
                guard let star = subview as? UIImageView else { return }
                star.isHighlighted = star.tag <= rate
            })
        case .ended:
            let center = stackView.arrangedSubviews[selectedRate - 1].center.x
            splashAnimation.center = CGPoint(x: center + horizontalInset, y: view.bounds.midY)
            animatePlay()
            splashAnimation.play(fromFrame: 20, toFrame: 45)
        default:
            break
        }
    }
    
    @objc private func handleTapGesture(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: stackView)
        let starWidth = stackView.bounds.width / CGFloat(starsCount)
        let rate = Int(location.x / starWidth) + 1
        
        if rate != self.selectedRate {
            self.selectedRate = rate
        }
        
        stackView.arrangedSubviews.forEach { subview in
            guard let starImageView = subview as? UIImageView else {
                return
            }
            starImageView.isHighlighted = starImageView.tag <= rate
        }
        let center = stackView.arrangedSubviews[selectedRate - 1].center.x
        splashAnimation.center = CGPoint(x: center + horizontalInset, y: view.bounds.midY)
        animatePlay()
        splashAnimation.play(fromFrame: 20, toFrame: 45)
    }
    
    private func animatePlay() {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut) {
            self.stackView.arrangedSubviews[self.selectedRate - 1].transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        } completion: { _ in
            self.stackView.arrangedSubviews[self.selectedRate - 1].transform = .identity
        }
    }
    
    //MARK: - Configure UI
    private func configureUI() {
        createStars()
        view.backgroundColor = .black
        view.addSubview(backgroundView)
        view.addSubview(splashAnimation)
        view.addSubview(stackView)
        view.addSubview(labelText)
    }
    
    private func createStars() {
        for i in 1...starsCount {
            let star = makeStar()
            star.tag = i
            stackView.addArrangedSubview(star)
        }
    }
    
    private func makeStar() -> UIImageView {
        let imageView = UIImageView(image: UIImage(named: "Unfilled_Star"), highlightedImage: UIImage(named: "Filled_Star"))
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    //MARK: - Configure Layout
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: horizontalInset),
            stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -horizontalInset),
            stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 40),
            
            backgroundView.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor, constant: -10),
            backgroundView.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor, constant: 10),
            backgroundView.heightAnchor.constraint(equalToConstant: 70),
            backgroundView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            
            labelText.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            labelText.bottomAnchor.constraint(equalTo: self.backgroundView.topAnchor, constant: -20)
        ])
    }
}
