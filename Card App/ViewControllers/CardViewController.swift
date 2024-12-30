    //
    //  ViewController.swift
    //  Card App
    //
    //  Created by Sasha on 30.12.24.
    //

import UIKit

final class CardViewController: UIViewController {

        //MARK: Outlets
    private let cardbackgroundView = UIView()
    private let cardImageView = UIImageView()
    private lazy var avatarImageView = addImage(name: "bannana")
    private lazy var likeImageView = addImage(name: "heart")
    private lazy var commentImageView = addImage(name: "message")
    private let titleLabel = UILabel()

        //MARK: Private Properties
    private var card = Card.addCard()
    private var cardIndex = 0
    private var cornerRadius: CGFloat = 40

        // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        updateUI()
    }


}

    //MARK: Private Methods
private extension CardViewController {

        //MARK: Update UI
    func updateUI() {
        configureCardBackground()
        configureAvatarImage()
        configurePhotoCard()
        configureTitleImage()
    }

        //MARK: Configure UI
    func configureCardBackground() {
        cardbackgroundView.backgroundColor = .systemGray5
        cardbackgroundView.layer.cornerRadius = cornerRadius
        cardbackgroundView.clipsToBounds = true
        cardbackgroundView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(cardbackgroundView)
        constraintsBackgroundView()
    }

    func configureAvatarImage() {
        cardbackgroundView.addSubview(avatarImageView)
        constraintsAvatarImage()
    }

    func configurePhotoCard() {
        cardImageView.image = UIImage(named: card[cardIndex].photo)
        cardImageView.layer.cornerRadius = cornerRadius - 16
        cardImageView.contentMode = .scaleAspectFill
        cardImageView.clipsToBounds = true
        cardImageView.translatesAutoresizingMaskIntoConstraints = false
        cardbackgroundView.addSubview(cardImageView)

        constraintsPhotoCard()
    }

    func configureTitleImage() {
        titleLabel.text = card[cardIndex].title
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.minimumScaleFactor = 0.5
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        cardbackgroundView.addSubview(titleLabel)

        constraintsTitleImage()
    }

    //MARK: UI Helper

    func addImage(name: String) -> UIImageView {
        {
            $0.image = UIImage(named: name)
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
            $0.frame.size = CGSize(width: 40, height: 40)
            $0.layer.cornerRadius = $0.frame.height / 2
            $0.translatesAutoresizingMaskIntoConstraints = false
            return $0
        }(UIImageView())
    }


        //MARK: Constraints
    func constraintsBackgroundView() {
        NSLayoutConstraint.activate([
            cardbackgroundView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 20),
            cardbackgroundView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 20),
            cardbackgroundView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -20)
        ])
    }

    func constraintsAvatarImage() {
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: cardbackgroundView.topAnchor, constant: 16),
            avatarImageView.leadingAnchor.constraint(equalTo: cardbackgroundView.leadingAnchor, constant: 16),
            avatarImageView.heightAnchor.constraint(equalToConstant: 40),
            avatarImageView.widthAnchor.constraint(equalToConstant: 40)
        ])
    }

    func constraintsPhotoCard() {
        NSLayoutConstraint.activate([
            cardImageView.topAnchor.constraint(
                equalTo: avatarImageView.bottomAnchor, constant: 10),
            cardImageView.leadingAnchor.constraint(
                equalTo: cardbackgroundView.leadingAnchor),
            cardImageView.trailingAnchor.constraint(
                equalTo: cardbackgroundView.trailingAnchor),
            cardImageView.heightAnchor.constraint(
                equalTo: cardImageView.widthAnchor,
                multiplier: 1.4)
        ])
    }

    func constraintsTitleImage() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: cardImageView.bottomAnchor,
                constant: 20),
            titleLabel.leadingAnchor.constraint(
                equalTo: cardImageView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(
                equalTo: cardImageView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(
                equalTo: cardbackgroundView.bottomAnchor,
                constant: -30)
        ])
    }





}


#Preview {
    let view = CardViewController()
    view
}

