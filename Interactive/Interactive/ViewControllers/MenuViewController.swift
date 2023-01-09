import UIKit

class MenuViewController: UIViewController {
    
    //MARK: - Property
    private var collectionView: UICollectionView!
    
    private let interactive = Interactive.all

    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        setupNavigationBar()
        configureCollectionView()
    }
    
    //MARK: - Configure UI
    private func setupNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navBarAppearance.backgroundColor = .black
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = "Interactive"
        
        self.navigationController?.navigationBar.standardAppearance = navBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    private func configureCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 4
        flowLayout.minimumLineSpacing = 4
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(InteractiveCollectionViewCell.self, forCellWithReuseIdentifier: InteractiveCollectionViewCell.reuseID)
        
        view.addSubview(collectionView)
    }
    
    //MARK: - viewWillLayoutSubviews
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
}
//MARK: - UICollectionViewDelegate

extension MenuViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.isHighlighted = true
        let item = interactive[indexPath.item]
        let viewController = item.type.init()
        viewController.title = item.name
        navigationController?.pushViewController(viewController, animated: true)
        viewController.navigationController?.navigationBar.tintColor = item.color
    }
}
//MARK: - UICollectionViewDataSource

extension MenuViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interactive.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InteractiveCollectionViewCell.reuseID, for: indexPath) as? InteractiveCollectionViewCell else { return UICollectionViewCell() }
        let item = interactive[indexPath.item]
        cell.configure(title: item.name, image: item.image)
        return cell
    }
}
//MARK: - UICollectionViewDelegateFlowLayout

extension MenuViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.bounds.width, height: 70)
    }
}
