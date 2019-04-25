//
//  DependancyControllers.swift
//  RxSwiftFactory
//
//  Created by Jonathan French on 25/04/2019.
//

import UIKit

public class AppDependencyContainer {
  
  let sharedAppViewModel: AppViewModel
  
  public init() {
    

    
  func makeAppViewModel() -> AppViewModel {
    return AppViewModel()
  }
  
    self.sharedAppViewModel = makeAppViewModel()
  }
    
  public func makeContainerViewController() -> ContainerViewController {
    
    let navigationControllerFactory = {
      return self.makeNavigationController(rootView: self.makeCenterViewController())
    }
    
    
    let dependencyContainer = ContainerDependancyContainer(appDependencyContainer: self)
    return dependencyContainer.makeContainerViewController(viewModel: sharedAppViewModel, navigationController: navigationControllerFactory())

  }

  public func makeCenterViewController() -> CenterViewController {
    let dependencyContainer = CenterDependencyContainer(appDependencyContainer: self)
    return dependencyContainer.makeCenterViewController()
  }

  public func makeNavigationController(rootView:NiblessViewController) -> RxSwiftFactoryNavigationController {
    print("makeNavController")
    let rootNavController = RxSwiftFactoryNavigationController(rootViewController:rootView)
    rootNavController.navigationBar.prefersLargeTitles = true
    return rootNavController
  }
  
  public func makeContainerViewModel() -> ContainerViewModel {
    return ContainerViewModel()
  }

//  public func makeCenterViewModel() -> CenterViewModel {
//    return CenterViewModel()
//  }
//
//  public func makeSidePanelViewModel() -> SidePanelViewModel {
//    return SidePanelViewModel(sharedAppViewModel: sharedAppViewModel)
//  }

  
}

extension AppDependencyContainer: ContainerViewModelFactory {}


public extension UIStoryboard {
  static func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: Bundle.main) }
}
