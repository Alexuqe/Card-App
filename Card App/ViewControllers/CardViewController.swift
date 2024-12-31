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
    private let titleLabel = UILabel()
    private let cardImageView = UIImageView()
    private lazy var rightButton = addButton(image: "tray")
    private lazy var leftButton = addButton(image: "xmark")
    private lazy var avatarImageView = addImage(name: "bannana")
    private lazy var likeImageView = addImage(systemName: "heart")
    private lazy var commentImageView = addImage(systemName: "message")

        //MARK: Data
    private var card = Card.addCard()

        //MARK: Private Properties
    private var cardIndex = 0
    private let cornerRadius: CGFloat = 40
    private let avatarSize: CGFloat = 40
    private let sizeButton: CGFloat = 50
    private var heightPhoto: CGFloat = 0

        // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.backgroundColor = .systemGray6
        heightPhoto = view.bounds.height / 2
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
        configureLikeImageView()
        configureCommentImageView()
        configureLeftButton()
        configureRightButton()
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

    func configureTitleImage() {
        titleLabel.text = card[cardIndex].title
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.minimumScaleFactor = 0.5
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        cardbackgroundView.addSubview(titleLabel)
        constraintsTitleImage()
    }

    func configurePhotoCard() {
        cardImageView.image = UIImage(named: card[cardIndex].photo)
        cardImageView.contentMode = .scaleAspectFill
        cardImageView.clipsToBounds = true
        cardImageView.translatesAutoresizingMaskIntoConstraints = false

        cardbackgroundView.addSubview(cardImageView)
        constraintsPhotoCard()
    }

    func configureLikeImageView() {
        cardbackgroundView.addSubview(likeImageView)
        constraintsLikeImage()
    }

    func configureCommentImageView() {
        cardbackgroundView.addSubview(commentImageView)
        constraintsCommentImageView()
    }

    func configureLeftButton() {
        view.addSubview(leftButton)
        constraintsLeftButton()
    }

    func configureRightButton() {
        view.addSubview(rightButton)
        constraintsRightButton()
    }


    //MARK: UI Helper

    func addImage(name: String) -> UIImageView {
        {
            $0.image = UIImage(named: name)
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
            $0.frame.size = CGSize(width: avatarSize, height: avatarSize)
            $0.layer.cornerRadius = $0.frame.height / 2
            $0.translatesAutoresizingMaskIntoConstraints = false
            return $0
        }(UIImageView())
    }

    func addImage(systemName: String) -> UIImageView {
        {
            $0.image = UIImage(systemName: systemName)
            $0.tintColor = UIColor.darkGray
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
            $0.layer.cornerRadius = $0.frame.height / 2
            $0.translatesAutoresizingMaskIntoConstraints = false
            return $0
        }(UIImageView())
    }

    func addButton(image: String) -> UIButton {
        {
            var configure = UIButton.Configuration.bordered()
            configure.image = UIImage(systemName: image)
            configure.baseForegroundColor = .darkGray
            configure.cornerStyle = .capsule
            configure.background.strokeColor = .darkGray
            configure.baseBackgroundColor = .clear
            configure.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(
                pointSize: 20,
                weight: .regular
            )

            $0.configuration = configure
            $0.translatesAutoresizingMaskIntoConstraints = false

            return $0
        }(UIButton())

    }


        //MARK: Constraints
    func constraintsBackgroundView() {
        NSLayoutConstraint.activate([
            cardbackgroundView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 30),
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
            avatarImageView.topAnchor.constraint(
                equalTo: cardbackgroundView.topAnchor,
                constant: 16),
            avatarImageView.leadingAnchor.constraint(
                equalTo: cardbackgroundView.leadingAnchor,
                constant: 16),
            avatarImageView.heightAnchor.constraint(
                equalToConstant: avatarSize),
            avatarImageView.widthAnchor.constraint(
                equalTo: avatarImageView.heightAnchor)
        ])
    }

    func constraintsTitleImage() {
        NSLayoutConstraint.activate([
                titleLabel.leadingAnchor.constraint(
                    equalTo: avatarImageView.trailingAnchor,
                    constant: 15),
                titleLabel.centerYAnchor.constraint(
                    equalTo: avatarImageView.centerYAnchor)
            ])
    }

    func constraintsPhotoCard() {
        NSLayoutConstraint.activate([
            cardImageView.topAnchor.constraint(
                equalTo: avatarImageView.bottomAnchor, constant: 15),
            cardImageView.leadingAnchor.constraint(
                equalTo: cardbackgroundView.leadingAnchor),
            cardImageView.trailingAnchor.constraint(
                equalTo: cardbackgroundView.trailingAnchor),
            cardImageView.heightAnchor.constraint(
                equalToConstant: heightPhoto)
            ])
    }

    func constraintsLikeImage() {
        NSLayoutConstraint.activate([
                likeImageView.topAnchor.constraint(
                    equalTo: cardImageView.bottomAnchor,
                    constant: 15),
                likeImageView.leadingAnchor.constraint(
                    equalTo: avatarImageView.leadingAnchor),
                likeImageView.widthAnchor.constraint(
                    equalToConstant: avatarSize - 10),
                likeImageView.heightAnchor.constraint(
                    equalTo: likeImageView.widthAnchor),
                likeImageView.bottomAnchor.constraint(
                    equalTo: cardbackgroundView.bottomAnchor,
                    constant: -40)
            ])
    }

    func constraintsCommentImageView() {
        NSLayoutConstraint.activate([
                commentImageView.centerYAnchor.constraint(
                    equalTo: likeImageView.centerYAnchor),
                commentImageView.leadingAnchor.constraint(
                    equalTo: likeImageView.trailingAnchor,
                    constant: 15),
                commentImageView.widthAnchor.constraint(
                    equalTo: likeImageView.widthAnchor,
                    multiplier: 0.9),
                commentImageView.heightAnchor.constraint(
                    equalTo: commentImageView.widthAnchor)
            ])
    }

    func constraintsLeftButton() {
        NSLayoutConstraint.activate([
            leftButton.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            leftButton.leadingAnchor.constraint(
                equalTo: cardbackgroundView.leadingAnchor),
            leftButton.widthAnchor.constraint(
                equalToConstant: sizeButton),
            leftButton.heightAnchor.constraint(
                equalTo: leftButton.widthAnchor)
        ])
    }

    func constraintsRightButton() {
        NSLayoutConstraint.activate([
            rightButton.leadingAnchor.constraint(
                equalTo: leftButton.trailingAnchor,
                constant: 15),
            rightButton.heightAnchor.constraint(equalToConstant: sizeButton),
            rightButton.widthAnchor.constraint(equalToConstant: sizeButton),
            rightButton.bottomAnchor.constraint(equalTo: leftButton.bottomAnchor)


        ])
    }






}


#Preview {
    let view = CardViewController()
    view
}

