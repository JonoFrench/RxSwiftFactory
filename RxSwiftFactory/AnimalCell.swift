
import UIKit



class AnimalCell: UITableViewCell {
  var hierarchyNotReady:Bool = true
  
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  

  
  public override func didMoveToWindow() {
    super.didMoveToWindow()
    guard hierarchyNotReady else {
      return
    }
    backgroundColor = .white
    constructHierarchy()
    activateConstraints()
    hierarchyNotReady = false
  }
  
  let animalImageView:UIImageView = {
    let animalImageView = UIImageView(frame: CGRect.zero)
    animalImageView.contentMode = ContentMode.scaleAspectFill
    animalImageView.clipsToBounds = true
    return animalImageView
  }()
  
  let imageNameLabel:UILabel = {
    let imageNameLabel = UILabel()
    imageNameLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
    return imageNameLabel
  }()
  
  let imageCreatorLabel:UILabel = {
    let imageCreatorLabel = UILabel()
    imageCreatorLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
    return imageCreatorLabel
  }()
  
  func configureForAnimal(_ animal: Animals) {
    animalImageView.image = UIImage(data: (animal.thumbnail as Data?)!)
    imageNameLabel.text = animal.title
    imageCreatorLabel.text = animal.creator
  }
  
  func constructHierarchy() {
    addSubview(animalImageView)
    addSubview(imageNameLabel)
    addSubview(imageCreatorLabel)
  }
  
  func activateConstraints() {
  }

}

protocol ActivateCellConstraints : AnimalCell {
  func activateConstraints()
}

final class LeftCell: AnimalCell,ActivateCellConstraints {
  
  override func activateConstraints() {
    activateConstraintsImageView()
    activateConstraintsImageName()
    activateConstraintsImageCreator()
  }
  
  func activateConstraintsImageView() {
    animalImageView.translatesAutoresizingMaskIntoConstraints = false
    let top = animalImageView.topAnchor.constraint(equalTo: topAnchor)
    let bottom = animalImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
    let left = animalImageView.leftAnchor.constraint(equalTo: leftAnchor)
    let width = animalImageView.widthAnchor.constraint(equalToConstant: 85.0)
    NSLayoutConstraint.activate([top,bottom,left,width])
  }
  
  func activateConstraintsImageName() {
    imageNameLabel.translatesAutoresizingMaskIntoConstraints = false
    let top = imageNameLabel.topAnchor.constraint(equalTo: topAnchor)
    let bottom = imageNameLabel.bottomAnchor.constraint(equalTo: imageCreatorLabel.topAnchor,constant: 6.0)
    let leading = imageNameLabel.leadingAnchor.constraint(equalTo: animalImageView.trailingAnchor,constant: 8.0)
    let right = imageNameLabel.rightAnchor.constraint(equalTo: rightAnchor)
    NSLayoutConstraint.activate([top,bottom,leading,right])
  }
  
  func activateConstraintsImageCreator() {
    imageCreatorLabel.translatesAutoresizingMaskIntoConstraints = false
    let leading = imageCreatorLabel.leadingAnchor.constraint(equalTo: imageNameLabel.leadingAnchor)
    let bottom = imageCreatorLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
    let right = imageCreatorLabel.rightAnchor.constraint(equalTo: rightAnchor)
    NSLayoutConstraint.activate([leading,bottom,right])
  }
}

final class RightCell: AnimalCell,ActivateCellConstraints {
  
  override func activateConstraints() {
    activateConstraintsImageView()
    activateConstraintsImageName()
    activateConstraintsImageCreator()
  }
  
  func activateConstraintsImageView() {
    animalImageView.translatesAutoresizingMaskIntoConstraints = false
    let top = animalImageView.topAnchor.constraint(equalTo: topAnchor)
    let bottom = animalImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
    let right = animalImageView.rightAnchor.constraint(equalTo: rightAnchor)
    let width = animalImageView.widthAnchor.constraint(equalToConstant: 85.0)
    NSLayoutConstraint.activate([top,bottom,right,width])
  }
  
  func activateConstraintsImageName() {
    imageNameLabel.textAlignment = .right
    imageNameLabel.translatesAutoresizingMaskIntoConstraints = false
    let top = imageNameLabel.topAnchor.constraint(equalTo: topAnchor)
    let bottom = imageNameLabel.bottomAnchor.constraint(equalTo: imageCreatorLabel.topAnchor,constant: 6.0)
    let trailing = imageNameLabel.trailingAnchor.constraint(equalTo: animalImageView.leadingAnchor,constant: -8.0)
    let left = imageNameLabel.leftAnchor.constraint(equalTo: leftAnchor)
    NSLayoutConstraint.activate([top,bottom,trailing,left])
  }
  
  func activateConstraintsImageCreator() {
    imageCreatorLabel.textAlignment = .right
    imageCreatorLabel.translatesAutoresizingMaskIntoConstraints = false
    let trailing = imageCreatorLabel.trailingAnchor.constraint(equalTo: imageNameLabel.trailingAnchor)
    let bottom = imageCreatorLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
    let left = imageCreatorLabel.leftAnchor.constraint(equalTo: leftAnchor)
    NSLayoutConstraint.activate([trailing,bottom,left])
  }
}
