import UIKit
import Lottie

class SecondViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Cпасибо!\nНастраиваем Ваши рекомендации"
        label.textAlignment = .center
        label.numberOfLines = 3
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var animationView: LottieAnimationView = {
        let anim = LottieAnimationView(name: "Mark")
        anim.contentMode = .scaleAspectFill
        anim.loopMode = .playOnce
        anim.translatesAutoresizingMaskIntoConstraints = false
        return anim
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        animate()
    }
    
    private func configureUI() {
        view.addSubview(animationView)
        view.addSubview(titleLabel)
    }
    
    private func animate() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.animationView.play(toFrame: 60) { _ in
                UIView.animate(withDuration: 1.4, delay: 0, options: .curveLinear) {
                    self.titleLabel.alpha = 1
                }
            }
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        NSLayoutConstraint.activate([
            animationView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -50),
            animationView.heightAnchor.constraint(equalToConstant: 200),
            animationView.widthAnchor.constraint(equalToConstant: 200),
            
            titleLabel.topAnchor.constraint(equalTo: self.animationView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
        ])
    }
}
