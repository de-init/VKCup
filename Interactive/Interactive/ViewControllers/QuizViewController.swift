import UIKit

class QuizViewController: InteractiveViewController {
    
    //MARK: - Properties
    private var collectionView: UICollectionView!
    
    private var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var numberOf: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = .lightGray
        label.text = "Вопрос 1/\(questions.count)"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var questions = Question.list
    private var index: Int = 0
    private var count = 1 {
        didSet {
            numberOf.text = "Вопрос \(count)/\(questions.count)"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .vertical
        flow.minimumInteritemSpacing = 10
        flow.minimumLineSpacing = 10
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flow)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: QuestionCollectionViewCell.reuseID, bundle: nil), forCellWithReuseIdentifier: QuestionCollectionViewCell.reuseID)
        
        containerView.addSubview(collectionView)
    }
    
    private func configureUI() {
        view.backgroundColor = .black
        
        containerView.addSubview(numberOf)
        view.addSubview(containerView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50),
            containerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            containerView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -80),
            containerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            
            numberOf.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 20),
            numberOf.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: self.numberOf.bottomAnchor, constant: 30),
            collectionView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -180),
            collectionView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor)
        ])
    }
}

//MARK: - UICollectionViewDelegate
extension QuizViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if index < questions.count - 1 {
            index += 1
            count += 1
            collectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .bottom, animated: true)
            guard let cell = collectionView.cellForItem(at: indexPath) as? QuestionCollectionViewCell else { return }
            [cell.answerView_1, cell.answerView_2, cell.answerView_3, cell.answerView_4].forEach({ $0?.backgroundColor = UIColor(hex: 0xE5EAF0) })
        }
    }
}

//MARK: - UICollectionViewDataSource
extension QuizViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuestionCollectionViewCell.reuseID, for: indexPath) as? QuestionCollectionViewCell else { return UICollectionViewCell() }
        let item = questions[indexPath.item]
        cell.configure(question: item.question, answer1: item.answer_1, answer2: item.answer_2, answer3: item.answer_3, answer4: item.answer_4)
        cell.correctAnswer = item.correctAnswer
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension QuizViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
