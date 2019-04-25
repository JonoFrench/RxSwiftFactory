

import UIKit
import RxSwift
import RxCocoa

public class CenterViewController: NiblessViewController {
  
  var delegate: CenterViewControllerDelegate?
  let viewModel:CenterViewModel
  
  let disposeBag = DisposeBag()

  
  init(viewModelFactory: CenterViewModelFactory) {
    self.viewModel = viewModelFactory.makeCenterViewModel()
    super.init()
  }
  
  public override func loadView() {
    print("CenterViewContoller loadView")
    
    view = CenterRootView(viewModel: viewModel)
    self.title = "RxSwift Factory"
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Puppies", style: .plain, target: self, action: #selector(puppiesTapped))
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Kitties", style: .plain, target: self, action: #selector(kittiesTapped))
    
    viewModel.animal.asObservable().subscribe(onNext: {
      let view = self.view as! CenterRootView
      view.imageNameLabel.text = $0.title
      view.imageCreatorLabel.text = $0.creator
      view.imageView.image = UIImage(data: ($0.image?.animalImage as Data?)!)
    }, onError: nil, onCompleted: {print("completed")}, onDisposed: {print("disposed")})
      .disposed(by: disposeBag)
    
  }
  
  // MARK: Button actions
  @objc func kittiesTapped() {
    delegate?.toggleLeftPanel()
  }
  
  @objc func puppiesTapped() {
    delegate?.toggleRightPanel()
  }
}

protocol CenterViewControllerDelegate {
  func toggleLeftPanel()
  func toggleRightPanel()
  func collapseSidePanels()
}

extension CenterViewController: SidePanelViewControllerDelegate {
  func didSelectAnimal(_ animal: Animals) {
    viewModel.animal.accept(animal)
    delegate?.collapseSidePanels()
  }
}

protocol CenterViewModelFactory {  
  func makeCenterViewModel() -> CenterViewModel
}
