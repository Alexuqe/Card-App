    //
    //  ViewController.swift
    //  Card App
    //
    //  Created by Sasha on 30.12.24.
    //

import UIKit

final class CardViewController: UIViewController {

        //MARK: Outlets
    private let buttonStackView = UIStackView()
    private lazy var cardbackgroundView = addBackground()
    private lazy var cardImageView = addPhotoCard(name: card[cardIndex].photo)
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

        constraintsUI()
    }

        //MARK: Configure UI
    func configureCardBackground() {
        view.addSubview(cardbackgroundView)
    }

    func configureAvatarImage() {
        cardbackgroundView.addSubview(avatarImageView)
    }

    func configureTitleImage() {
        cardbackgroundView.addSubview(titleLabel)
    }

    func configurePhotoCard() {
        cardbackgroundView.addSubview(cardImageView)
    }

    func configureLikeImageView() {
        cardbackgroundView.addSubview(likeImageView)
    }

    func configureCommentImageView() {
        cardbackgroundView.addSubview(commentImageView)
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


        rightButton.addTarget(self, action: #selector(done), for: .touchUpInside)
        leftButton.addTarget(self, action: #selector(deletePhoto), for: .touchUpInside)
    }


        //MARK: Actions Buttons
    @objc func done () {
        nextCard()
    }

    @objc func deletePhoto() {
        deleteCard()
    }

        //MARK: Setup Actions Buttons
    func nextCard() {
        if cardIndex < card.count - 1 {
            cardIndex += 1
            updateUI()
        } else {
            cardIndex = card.count - 1
        }
    }

    func deleteCard() {
        if cardIndex > 0 {
            cardIndex -= 1
            deleteUI()
        } else {
            cardIndex = 0
        }
    }

        //MARK: Create New UI
    func updateUI() {
        let currentPhoto = card[cardIndex].photo
        let currentTitle = card[cardIndex].title

        let newViews = createNewViews(photo: currentPhoto, title: currentTitle)
        addNewViewsToBackground(views: newViews)
        setupConstraints(for: newViews)
        animateCardTransition(newViews: newViews)
    }

        //MARK: Delete New UI
    func deleteUI() {
        let currentPhoto = card[cardIndex].photo
        let currentTitle = card[cardIndex].title
        let deleteViews = createNewViews(photo: currentPhoto, title: currentTitle)
        animateRemoveCard(newViews: deleteViews)
        addNewViewsToBackground(views: deleteViews)
        setupConstraints(for: deleteViews)
    }


        //MARK: Setups New UI
    func createNewViews(photo: String, title: String) -> (avatar: UIImageView, title: UILabel, photo: UIImageView) {
        let newTitle = addTitle(string: title)
        let newPhoto = addPhotoCard(name: photo)
        let newAvatar = addImage(name: photo)

        return (newAvatar, newTitle, newPhoto)
    }

    func addNewViewsToBackground(views: (avatar: UIImageView, title: UILabel, photo: UIImageView)) {
        cardbackgroundView.addSubview(views.avatar)
        cardbackgroundView.addSubview(views.title)
        cardbackgroundView.addSubview(views.photo)
    }

    func setupConstraints(for views: (avatar: UIImageView, title: UILabel, photo: UIImageView)) {
        NSLayoutConstraint.activate([
            // Avatar constraints
            views.avatar.topAnchor.constraint(
                equalTo: cardbackgroundView.topAnchor,
                constant: 16),
            views.avatar.leadingAnchor.constraint(
                equalTo: cardbackgroundView.leadingAnchor,
                constant: 16),
            views.avatar.heightAnchor.constraint(
                equalToConstant: avatarSize),
            views.avatar.widthAnchor.constraint(
                equalTo: avatarImageView.heightAnchor),

            // Title constraints
            views.title.leadingAnchor.constraint(
                equalTo: avatarImageView.trailingAnchor,
                constant: 15),
            views.title.centerYAnchor.constraint(
                equalTo: avatarImageView.centerYAnchor),

            // Photo constraints
            views.photo.topAnchor.constraint(
                equalTo: avatarImageView.bottomAnchor, constant: 15),
            views.photo.leadingAnchor.constraint(
                equalTo: cardbackgroundView.leadingAnchor),
            views.photo.trailingAnchor.constraint(
                equalTo: cardbackgroundView.trailingAnchor),
            views.photo.heightAnchor.constraint(
                equalToConstant: heightPhoto)
        ])
    }

    func animateCardTransition(newViews: (avatar: UIImageView, title: UILabel, photo: UIImageView)) {
        [newViews.avatar, newViews.title, newViews.photo].forEach { view in
            view.transform = CGAffineTransform(
                translationX: self.view.bounds.width,
                y: 0)
        }

        UIView.transition(with: view, duration: 0.3, options: .curveEaseIn, animations: {
            [self.avatarImageView, self.titleLabel, self.cardImageView].forEach { view in
                view.transform = CGAffineTransform(
                    translationX: -self.view.bounds.width,
                    y: 0)
            }

            [newViews.avatar, newViews.title, newViews.photo].forEach { view in
                view.transform = .identity
            }
        }) { _ in
            self.avatarImageView = newViews.avatar
            self.cardImageView = newViews.photo
            self.titleLabel = newViews.title
        }
    }

    func animateRemoveCard(newViews: (avatar: UIImageView, title: UILabel, photo: UIImageView)) {
        [newViews.avatar, newViews.title, newViews.photo].forEach { view in
            view.transform = CGAffineTransform(translationX: -self.view.bounds.width, y: 0)
        }

        UIView.transition(with: view, duration: 0.3, options: .curveEaseIn, animations: {
            [self.avatarImageView, self.titleLabel, self.cardImageView].forEach { view in
                view.transform = CGAffineTransform(translationX: self.view.bounds.width, y: 0)
            }

            [newViews.avatar, newViews.title, newViews.photo].forEach { view in
                view.transform = .identity
            }
        }) { _ in
            self.avatarImageView.removeFromSuperview()
            self.cardImageView.removeFromSuperview()
            self.titleLabel.removeFromSuperview()

            self.avatarImageView = newViews.avatar
            self.cardImageView = newViews.photo
            self.titleLabel = newViews.title

            self.setupConstraints(for: (self.avatarImageView, self.titleLabel, self.cardImageView))
            self.view.layoutIfNeeded()
        }
    }




        //MARK: UI Helper

    func addBackground() -> UIView {
        {
            $0.backgroundColor = .systemGray5
            $0.layer.cornerRadius = cornerRadius
            $0.clipsToBounds = true
            $0.translatesAutoresizingMaskIntoConstraints = false

            return $0
        }(UIView())
    }

    func addPhotoCard(name: String) -> UIImageView {
        {
            $0.image = UIImage(named: card[cardIndex].photo)
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
            $0.translatesAutoresizingMaskIntoConstraints = false

            return $0
        }(UIImageView())
    }

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
    func constraintsUI() {
        constraintsBackgroundView()
        constraintsAvatarImage()
        constraintsTitleImage()
        constraintsPhotoCard()
        constraintsLikeImage()
        constraintsCommentImageView()
        constraintsButtonStackView()
    }

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

