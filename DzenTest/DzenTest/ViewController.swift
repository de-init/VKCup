import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Отметьте то, что вам интересно,\nчтобы настроить Дзен"
        label.numberOfLines = 2
        label.textColor = .systemGray3
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var laterButton: UIButton = {
        let button = UIButton()
        button.configuration = .filled()
        button.configuration?.cornerStyle = .capsule
        button.configuration?.title = "Позже"
        button.configuration?.baseBackgroundColor = .systemGray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var continueButton: UIButton = {
        let button = UIButton()
        var attribute = AttributedString("Продолжить")
        var container = AttributeContainer()
        container.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        attribute.mergeAttributes(container)
        button.configuration = .filled()
        button.configuration?.cornerStyle = .capsule
        button.configuration?.attributedTitle = attribute
        button.configuration?.baseForegroundColor = .black
        button.configuration?.baseBackgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        return button
    }()
    
    private var topGradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor, UIColor.clear.cgColor]
        return layer
    }()
    
    private var bottomGradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [UIColor.clear.cgColor, UIColor.clear.cgColor, UIColor.black.cgColor]
        return layer
    }()
    
    private var collectionView: UICollectionView!
    
    private var dataSource: [String] = ["Юмор", "Еда","Кино", "Рестораны", "Прогулки", "Политика", "Новости", "Автомобили", "Сериалы", "Рецепты", "Работа",
                                        "Отдых", "Спорт", "Политика", "Новости", "Юмор", "Еда", "Кино", "Рестораны", "Прогулки", "Политика", "Новости", "Юмор", "Еда", "Кино"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        setupUI()
        continueAction()
    }
    
    private func setupUI() {
        navigationController?.isNavigationBarHidden = true
        view.addSubview(titleLabel)
        view.addSubview(laterButton)
        view.addSubview(continueButton)
        view.layer.addSublayer(topGradientLayer)
        view.layer.addSublayer(bottomGradientLayer)
    }
    
    private func configureCollectionView() {
        let flowLayout = CustomCollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 8
        flowLayout.minimumLineSpacing = 8
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.allowsMultipleSelection = true
        collectionView.contentInset = UIEdgeInsets(top: 15, left: 0, bottom: 17, right: 0)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseID)
        
        view.addSubview(collectionView)
    }
    
    private func continueAction() {
        let vc = SecondViewController()
        continueButton.addAction(UIAction(handler: { _ in
            vc.modalPresentationStyle = .custom
            vc.transitioningDelegate = self
            self.present(vc, animated: true)
        }), for: .touchUpInside)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: self.laterButton.leadingAnchor, constant: -12),
            
            laterButton.heightAnchor.constraint(equalToConstant: 40),
            laterButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            laterButton.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor, constant: 0),
            
            collectionView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 24),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5),
            collectionView.bottomAnchor.constraint(equalTo: self.continueButton.topAnchor, constant: -20),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            
            continueButton.heightAnchor.constraint(equalToConstant: 80),
            continueButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 82),
            continueButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -82),
            continueButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
        
        topGradientLayer.frame = CGRect(x: self.view.frame.minX, y: self.collectionView.frame.minY, width: self.view.frame.width, height: 60)
        bottomGradientLayer.frame = CGRect(x: self.view.frame.minX, y: self.collectionView.frame.maxY - self.bottomGradientLayer.frame.height, width: self.view.frame.width, height: 60)
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseID, for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        cell.configure(title: dataSource[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.text = dataSource[indexPath.row]
        label.sizeToFit()
        let size = label.frame.size
        return CGSize(width: size.width + 60, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        continueButton.isEnabled = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let items = collectionView.indexPathsForSelectedItems {
            if items.count < 1 {
                self.continueButton.isEnabled = false
            }
        }
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentTransition()
    }
}
