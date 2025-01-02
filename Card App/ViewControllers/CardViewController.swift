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
    private var cardImageView = UIImageView()
    private let buttonStackView = UIStackView()
    private lazy var titleLabel = addTitle(string: card[cardIndex].title)
    private lazy var rightButton = addButton(image: "checkmark")
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
    private let sizeButton: CGFloat = 80
    private var heightPhoto: CGFloat = 0

        // MARK: - View Life Cycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.backgroundColor = .systemGray6
        heightPhoto = view.bounds.height / 2
        setupUI()
    }


}

    //MARK: Private Methods
private extension CardViewController {

        //MARK: Update UI
    func setupUI() {
        configureCardBackground()
        configureAvatarImage()
        configurePhotoCard()
        configureTitleImage()
        configureLikeImageView()
        configureCommentImageView()
        configureButtonStackView()
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


    func configureButtonStackView() {
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        buttonStackView.alignment = .fill
        buttonStackView.spacing = 10
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.addArrangedSubview(leftButton)
        buttonStackView.addArrangedSubview(rightButton)

        view.addSubview(buttonStackView)

        constraintsButtonStackView()

        rightButton.addTarget(self, action: #selector(done), for: .touchUpInside)
    }


    //MARK: Actions

    @objc func done () {
//        nextCard()
    }



    func nextCard() {
        cardIndex += 1
        if cardIndex < card.count - 1 {
            updateUI()
        } else {
            return
        }
    }

    func updateUI() {
        let currentPhoto = card[cardIndex].photo
        let currentTitle = card[cardIndex].title

        let newPhoto = addImage(name: currentPhoto)
        let newTitle = addTitle(string: currentTitle)

        cardbackgroundView.addSubview(newPhoto)
        cardbackgroundView.addSubview(newTitle)


        newPhoto.transform = CGAffineTransform(
            translationX: cardbackgroundView.bounds.width,
            y: 0)
        newTitle.transform = CGAffineTransform(
            translationX: cardbackgroundView.bounds.width,
            y: 0)

        UIView.transition(with: view, duration: 0.3,options: .curveEaseIn , animations: {
            self.cardImageView.transform = CGAffineTransform(translationX: -self.cardbackgroundView.bounds.width, y: 0)
            self.titleLabel.transform = CGAffineTransform(translationX: -self.cardbackgroundView.bounds.width, y: 0)

            newPhoto.transform = .identity
            newTitle.transform = .identity
        }) { _ in
            self.cardImageView = newPhoto
            self.titleLabel = newTitle
        }


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

    func addTitle(string: String) -> UILabel {
        {
            $0.text = string
            $0.font = UIFont.systemFont(ofSize: 20, weight: .regular)
            $0.textColor = .black
            $0.textAlignment = .center
            $0.minimumScaleFactor = 0.5
            $0.adjustsFontSizeToFitWidth = true
            $0.adjustsFontForContentSizeCategory = true
            $0.translatesAutoresizingMaskIntoConstraints = false
            return $0
        }(UILabel())
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
                pointSize: 25,
                weight: .regular
            )

            $0.configuration = configure
            $0.configurationUpdateHandler = { button in
                switch button.state {
                    case .highlighted:
                        button.layer.cornerRadius = button.bounds.height / 2
                        button.backgroundColor = .systemGray.withAlphaComponent(0.2)
                    default:
                        button.backgroundColor = .clear
                }
            }

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

    func constraintsButtonStackView() {
        NSLayoutConstraint.activate([
            buttonStackView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            buttonStackView.leadingAnchor.constraint(
                equalTo: cardbackgroundView.leadingAnchor),
            buttonStackView.trailingAnchor.constraint(equalTo: cardbackgroundView.trailingAnchor),
            buttonStackView.heightAnchor.constraint(equalToConstant: sizeButton)
        ])
    }






}


#Preview {
    let view = CardViewController()
    view
}

