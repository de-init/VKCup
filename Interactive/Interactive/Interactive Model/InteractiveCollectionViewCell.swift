import UIKit

class InteractiveCollectionViewCell: UICollectionViewCell {
    
    static var reuseID = "InteractiveCollectionViewCell"
    
    private let arrowImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "Arrow")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var interactiveName: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var interactiveImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white.withAlphaComponent(0.15)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.addSubview(arrowImageView)
        self.addSubview(interactiveName)
        self.addSubview(interactiveImage)
    }
    
    func configure(title: String, image: UIImage) {
        self.interactiveName.text = title
        self.interactiveImage.image = image
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            interactiveImage.heightAnchor.constraint(equalToConstant: 45),
            interactiveImage.widthAnchor.constraint(equalToConstant: 45),
            interactiveImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            interactiveImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            
            interactiveName.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            interactiveName.leadingAnchor.constraint(equalTo: self.interactiveImage.trailingAnchor, constant: 20),
            
            arrowImageView.heightAnchor.constraint(equalToConstant: 20),
            arrowImageView.widthAnchor.constraint(equalToConstant: 20),
            arrowImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            arrowImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }
}
