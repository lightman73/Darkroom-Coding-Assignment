//
//  GalleryViewController.swift
//  PixelRoom
//
//  Created by Igor Lipovac on 28/02/2021.
//

import UIKit

class GalleryViewController: UIViewController {
    
    enum Constants {
        static let interitemSpacing: CGFloat = 6
        static let sectionSpacing: CGFloat = 16
        static let cellIdentifier = "GalleryCollectionViewCell"
    }

    private let photoDataSource: GalleryDataSource
    private var collectionView: UICollectionView!
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        fatalError("Not implemented. Use `init()`")
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented. Use `init()`")
    }
    
    init() {
        photoDataSource = GalleryDataSource()
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: compositionalLayout())
        setupSubviews()
        setupLayout()
        reloadData()
    }

    // MARK: - Subviews and Layout
    
    private func setupSubviews() {
        title = "Gallery"
        view.backgroundColor = .black
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
        setupActivityIndicator()
        setupCollectionView()
    }
    
    private func setupActivityIndicator() {
        activityIndicator.color = .white
        activityIndicator.alpha = 0
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: Constants.cellIdentifier)
    }
    
    private func setupLayout() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.interitemSpacing),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.interitemSpacing),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor),
        ])
    }
    
    
    private func reloadData() {
        activityIndicator.alpha = 1.0
        activityIndicator.startAnimating()
        photoDataSource.reloadPhotos {
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.alpha = 0
                self.collectionView.reloadData()
            }
        }
    }
    
    // MARK: - UICollectionViewCompositionalLayout functions
    
    func compositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (section: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            switch section {
            case 0:
                return self.buildLayout(itemsPerLine: 2, halfHeight: true, shouldScrollHorizontally: true)
            case 1:
                return self.buildLayout(itemsPerLine: 4, halfHeight: true, shouldScrollHorizontally: true)
            default:
                return self.buildLayout(itemsPerLine: 5)
            }
        }
        return layout
    }
    
    func buildLayout(itemsPerLine: Int, halfHeight: Bool = false, shouldScrollHorizontally: Bool = false) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/CGFloat(itemsPerLine)),
                                              heightDimension: .fractionalHeight(1.0))
        let fullPhotoItem = NSCollectionLayoutItem(layoutSize: itemSize)
        
        fullPhotoItem.contentInsets = NSDirectionalEdgeInsets(top: Constants.interitemSpacing / 2,
                                                              leading: Constants.interitemSpacing / 2,
                                                              bottom: Constants.interitemSpacing / 2,
                                                              trailing: Constants.interitemSpacing / 2)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(1/(CGFloat(itemsPerLine) * (halfHeight ? 2 : 1))))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: fullPhotoItem,
                                                       count: itemsPerLine)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: Constants.sectionSpacing,
                                                        leading: 0,
                                                        bottom: Constants.sectionSpacing,
                                                        trailing: 0)
        section.orthogonalScrollingBehavior = shouldScrollHorizontally ? .continuousGroupLeadingBoundary : .none
        return section
    }
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource

extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return photoDataSource.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoDataSource.numberOfItemsInSection(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = photoDataSource.item(at: indexPath.row, inSection: indexPath.section)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath)
        if let photoCell = cell as? GalleryCollectionViewCell {
            photoCell.configure(with: item.thumbnail)
            return photoCell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = photoDataSource.item(at: indexPath.row, inSection: indexPath.section)
        let editor = PhotoEditorViewController()
        let model = PhotoEditorModel(with: item, photoEditorView: editor)
        editor.setupWithModel(model)
        navigationController?.pushViewController(editor, animated: true)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}
