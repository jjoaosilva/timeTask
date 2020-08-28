//
//  OnboardingViewController.swift
//  TimeTask
//
//  Created by José João Silva Nunes Alves on 19/08/20.
//  Copyright © 2020 José João Silva Nunes Alves. All rights reserved.
//

import UIKit

// swiftlint:disable line_length force_cast

class OnboardingViewController: UIViewController {

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0

        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: OnboardingCollectionViewCell.reuseIdentifier)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isPagingEnabled = true
        collection.showsHorizontalScrollIndicator = false

        return collection
    }()

    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.hidesForSinglePage = true
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.pageIndicatorTintColor = .systemGray
        pageControl.currentPageIndicatorTintColor = .label
        return pageControl
    }()

    private var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
        }
    }

    private var onBoards = [Onboard]()

    init(onboard: [Onboard] = Onboard.mockOnboard()) {
        super.init(nibName: nil, bundle: nil)
        pageControl.numberOfPages = onboard.count
        self.onBoards = onboard
    }

    required init?(coder: NSCoder) {
        super.init(nibName: nil, bundle: nil)
        let onboard: [Onboard] = Onboard.mockOnboard()
        pageControl.numberOfPages = onboard.count
        self.onBoards = onboard
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        constructView()
        setupLayout()
    }

    private func constructView() {
        self.view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self

        self.view.addSubview(pageControl)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor),

            pageControl.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20),
            pageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }

    func nextPage() {
        if currentPage < onBoards.count - 1 {
            currentPage += 1
            collectionView.scrollToItem(at: IndexPath(row: currentPage, section: 0), at: .centeredHorizontally, animated: true)
        } else {
            presentNewScreen()
        }
    }

    func presentNewScreen() {
        UserDefaults.standard.set(1, forKey: "hasSeenOnboard")
        let destinity = TabBarController()
        destinity.modalPresentationStyle = .fullScreen

        self.present(destinity, animated: true, completion: nil)
    }
}

extension OnboardingViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onBoards.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.reuseIdentifier, for: indexPath) as! OnboardingCollectionViewCell
        cell.setup(onBoard: onBoards[indexPath.row], action: nextPage, skip: presentNewScreen)
        return cell
    }

     func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
           currentPage = indexPath.row
       }

       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return UIScreen.main.bounds.size
       }
}
