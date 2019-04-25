//
//  DependancyControllers.swift
//  RxSwiftFactory
//
//  Created by Jonathan French on 25/04/2019.
//

import UIKit

public class SidePanelDependencyContainer {
  
  public init(containerDependencyContainer: ContainerDependancyContainer){
    
  }
  
//  public func makeSidePanelDependancyContainer() -> SidePanelDependencyContainer {
//    return SidePanelDependencyContainer(containerDependencyContainer:ContainerDependancyContainer())
//  }
  
  public func makeSidePanelViewController() -> SidePanelViewController {
    print("makeSidePanelViewController")

    return SidePanelViewController(viewModelFactory: self)
    //return UIStoryboard.sidePanelViewController(identifier:identifier)!
  }
  
  public func makeSidePanelViewModel() -> SidePanelViewModel {
    print("makeSidePanelViewModel")

    return SidePanelViewModel()
  }
  
}

extension SidePanelDependencyContainer: SidePanelViewModelFactory {
}

//extension UIStoryboard {
//  static func sidePanelViewController(identifier: String) -> SidePanelViewController? {
//    return mainStoryboard().instantiateViewController(withIdentifier: identifier) as? SidePanelViewController
//  }

//}
