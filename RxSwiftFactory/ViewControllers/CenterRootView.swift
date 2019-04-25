

import UIKit
import RxSwift
import RxCocoa

public class CenterRootView: NiblessView {
  let viewModel: CenterViewModel
  let disposeBag = DisposeBag()

  
  let imageView:UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = ContentMode.scaleAspectFit
    imageView.clipsToBounds = true
    imageView.image = UIImage.init(imageLiteralResourceName: "ID-10029135")
    return imageView
  }()

  let imageNameLabel:UILabel = {
    let imageNameLabel = UILabel()
    imageNameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    imageNameLabel.text = "Jumping School"
    imageNameLabel.textAlignment = NSTextAlignment.center
    return imageNameLabel
  }()
  
  let imageCreatorLabel:UILabel = {
    let imageCreatorLabel = UILabel()
    imageCreatorLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
    imageCreatorLabel.text = "Vlado"
    imageCreatorLabel.textAlignment = NSTextAlignment.center
    return imageCreatorLabel
  }()
  
  let copyrightLabel:UILabel = {
    let copyrightLabel = UILabel()
    copyrightLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
    copyrightLabel.text = "Images courtesy of FreeDigitalPhotos.net"
    copyrightLabel.textAlignment = NSTextAlignment.center
    return copyrightLabel
  }()
  
  init(frame: CGRect = .zero,
       viewModel: CenterViewModel) {
    print("Center Root View Init")
    self.viewModel = viewModel

    super.init(frame: frame)

//    viewModel.animal?.subscribe(onNext: {print($0)}, onError: nil, onCompleted: {print("complete")}, onDisposed: {print("disposed")})
//    .disposed(by: disposeBag)
    
//    viewModel.animal?.asDriver().do(onNext: {
//      self.imageNameLabel.text = $0.title
//      self.imageCreatorLabel.text = $0.creator
//      let imageData = $0.image?.animalImage as Data?
//      self.imageView.image = UIImage(data: imageData!)
//    }, onCompleted: nil, onSubscribe: nil, onSubscribed: nil, onDispose: nil)

//    viewModel.animal?.asObservable().subscribe({print($0)
//      self.imageNameLabel.text = $0.element?.title
//      self.imageCreatorLabel.text = $0.element?.creator
//      let imageData = $0.element?.image?.animalImage as Data?
//      self.imageView.image = UIImage(data: imageData!)
//
//    })
//    .disposed(by: viewModel.disposeBag)
    
//    viewModel.animal?.asObservable().subscribe(onNext: {
//      self.imageNameLabel.text = $0.title
//      self.imageCreatorLabel.text = $0.creator
//      let imageData = $0.image?.animalImage as Data?
//      self.imageView.image = UIImage(data: imageData!)
//    }, onError: nil, onCompleted: {print("completed")}, onDisposed: {print("disposed")})
//      .disposed(by: disposeBag)
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
  
  func constructHierarchy() {
    addSubview(imageView)
    addSubview(imageNameLabel)
    addSubview(imageCreatorLabel)
    addSubview(copyrightLabel)
  }
  
  func activateConstraints() {
    activateConstraintsImageView()
    activateConstraintsImageNameLabel()
    activateConstraintsImageCreatorLabel()
    activateConstraintsCopyrightLabel()
  }

  
  
  func activateConstraintsImageView() {
    imageView.translatesAutoresizingMaskIntoConstraints = false
    let top = imageView.topAnchor.constraint(equalTo: topAnchor, constant: UIApplication.shared.statusBarFrame.height + 90)
    let height = imageView.heightAnchor.constraint(lessThanOrEqualToConstant: 350)
    let left = imageView.leftAnchor.constraint(equalTo: leftAnchor)
    let right = imageView.rightAnchor.constraint(equalTo: rightAnchor)
    NSLayoutConstraint.activate([top,height,left,right])
  }
  
  func activateConstraintsImageNameLabel() {
    imageNameLabel.translatesAutoresizingMaskIntoConstraints = false
    let top = imageNameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20)
    let center = imageNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
    NSLayoutConstraint.activate([top,center])
  }

  func activateConstraintsImageCreatorLabel() {
    imageCreatorLabel.translatesAutoresizingMaskIntoConstraints = false
    let top = imageCreatorLabel.topAnchor.constraint(equalTo: imageNameLabel.bottomAnchor, constant: 8)
    let center = imageCreatorLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
    NSLayoutConstraint.activate([top,center])
  }

  func activateConstraintsCopyrightLabel() {
    copyrightLabel.translatesAutoresizingMaskIntoConstraints = false
    let bottom = copyrightLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
    let center = copyrightLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
    NSLayoutConstraint.activate([bottom,center])
  }

  
  func configureViewAfterLayout() {
    
    print("CenterRootView configureViewAfterLayout")
    
  }
  
}
