import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    static var reuseID = "CollectionViewCell"
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "plus")?.withRenderingMode(.alwaysOriginal).withTintColor(.white)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var divider: UIView = {
        let temp = UIView()
        temp.backgroundColor = .systemGray2
        temp.clipsToBounds = true
        temp.layer.cornerRadius = 1
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    override var isSelected: Bool {
        didSet {
            taptic(select: isSelected)
            if isSelected {
                show()
            } else {
                hide()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    private func setupUI() {
        self.backgroundColor = .darkGray
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.height / 2
        
        addSubview(titleLabel)
        addSubview(imageView)
        addSubview(divider)
    }
    
    private func show() {
        UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseInOut) {
            self.backgroundColor = .systemOrange
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            self.divider.alpha = 0
            self.imageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        } completion: { _ in
            UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseInOut) {
                self.transform = .identity
                self.imageView.transform = .identity
                self.imageView.image = UIImage(systemName: "checkmark")?.withRenderingMode(.alwaysOriginal).withTintColor(.white)
            }
        }
    }
    
    private func hide() {
        UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseInOut) {
            self.backgroundColor = .darkGray
            self.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
            self.divider.alpha = 1
            self.imageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        } completion: { _ in
            UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseInOut){
                self.transform = .identity
                self.imageView.transform = .identity
                self.imageView.image = UIImage(systemName: "plus")?.withRenderingMode(.alwaysOriginal).withTintColor(.white)
            }
        }
    }
    
    private func taptic(select: Bool) {
        if select {
            let taptic = UIImpactFeedbackGenerator(style: .light)
            taptic.prepare()
            taptic.impactOccurred()
        } else {
            let taptic = UIImpactFeedbackGenerator(style: .soft)
            taptic.prepare()
            taptic.impactOccurred()
        }
    }
    
    func configure(title: String) {
        self.titleLabel.text = title
    }
    
    override func layoutSubviews() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor, constant: 0),
            imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 4.0 / 2.0),
            
            divider.topAnchor.constraint(equalTo: self.topAnchor, constant: 11),
            divider.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            divider.trailingAnchor.constraint(equalTo: self.imageView.leadingAnchor, constant: -7),
            divider.widthAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
