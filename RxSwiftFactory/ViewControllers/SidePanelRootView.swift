

import UIKit
import RxSwift
import RxCocoa

public class SidePanelRootView: NiblessView {

  let disposeBag = DisposeBag()
  var delegate: SidePanelViewControllerDelegate?
  let viewModel: SidePanelViewModel
  
  let tableView:UITableView = {
    let tableView = UITableView()
    tableView.allowsSelection = true
    return tableView
  }()
  
  let imageView:UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = ContentMode.scaleAspectFill
    imageView.clipsToBounds = true
    return imageView
  }()
  
  init(frame: CGRect = .zero,
       viewModel: SidePanelViewModel) {
    self.viewModel = viewModel
    super.init(frame: frame)
  }
  
  public override func didMoveToWindow() {
    super.didMoveToWindow()
    guard hierarchyNotReady else {
      return
    }
    imageView.image = viewModel.headerImage
    enum CellIdentifiers {
      static let AnimalCell = "AnimalCellCode"
    }


    backgroundColor = .white
    constructHierarchy()
    activateConstraints()

    tableView.register(viewModel.cellType, forCellReuseIdentifier: CellIdentifiers.AnimalCell)
    
    tableView.tableFooterView = UIView()
    viewModel.animals.asObservable().bind(to:tableView.rx.items(cellIdentifier: CellIdentifiers.AnimalCell,cellType: viewModel.cellType)) { _, animal, cell in
      cell.configureForAnimal(animal)
      }
      .disposed(by: disposeBag)
    
        tableView.rx.modelSelected(Animals.self)
        .subscribe(onNext: {
          self.delegate?.didSelectAnimal($0)
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        .disposed(by: disposeBag)
    
    hierarchyNotReady = false
  }
  
  func constructHierarchy() {
    addSubview(imageView)
    addSubview(tableView)
  }
  
  func activateConstraints() {
    activateConstraintsImageView()
    activateConstraintsTableView()
  }
  
  func activateConstraintsImageView() {
    imageView.translatesAutoresizingMaskIntoConstraints = false
    let top = imageView.topAnchor.constraint(equalTo: topAnchor)
    let height = imageView.heightAnchor.constraint(equalToConstant: 126)
    let left = imageView.leftAnchor.constraint(equalTo: leftAnchor)
    let right = imageView.rightAnchor.constraint(equalTo: rightAnchor)
    NSLayoutConstraint.activate([top,height,left,right])
  }
  
  func activateConstraintsTableView() {
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    let top = tableView.topAnchor.constraint(equalTo: imageView.bottomAnchor)
    let bottom = tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
    let left = tableView.leftAnchor.constraint(equalTo: leftAnchor)
    let right = tableView.rightAnchor.constraint(equalTo: rightAnchor)

    NSLayoutConstraint.activate([top,bottom,left,right])
  }
  
  func configureViewAfterLayout() {
  
    print("SidePaneRootView configureViewAfterLayout")

  }
  
  
}



