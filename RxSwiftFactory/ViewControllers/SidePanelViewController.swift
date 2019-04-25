

import Foundation
import UIKit
import RxSwift
import RxCocoa

public class SidePanelViewController: NiblessViewController {
//  @IBOutlet weak var tableView: UITableView!
  var delegate: SidePanelViewControllerDelegate?
  let viewModel:SidePanelViewModel
  
  let disposeBag = DisposeBag()
  
  
  // MARK: - Methods
  init(viewModelFactory: SidePanelViewModelFactory) {
    self.viewModel = viewModelFactory.makeSidePanelViewModel()
    super.init()
  }
  
  public override func loadView() {
    print("SidePaneViewContoller loadView")

    view = SidePanelRootView(viewModel: viewModel) 
    (view as! SidePanelRootView).delegate = delegate
    
  }

  
  public override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    //(view as! SidePanelRootView).configureViewAfterLayout()
  }
  
}

protocol SidePanelViewControllerDelegate {
  func didSelectAnimal(_ animal: Animals)
}

protocol SidePanelViewModelFactory {
  
  func makeSidePanelViewModel() -> SidePanelViewModel
}
