//
//  DependancyControllers.swift
//  RxSwiftFactory
//
//  Created by Jonathan French on 25/04/2019.
//

import UIKit

public class CenterDependencyContainer {
  
  public init(appDependencyContainer: AppDependencyContainer){
    appDependencyContainer.sharedAppViewModel.setSeedData()
  }
  
  public func makeCenterDependancyContainer() -> CenterDependencyContainer {
    return CenterDependencyContainer(appDependencyContainer: AppDependencyContainer())
  }
  
  public func makeCenterViewController() -> CenterViewController {
     return CenterViewController(viewModelFactory: self)
    //return UIStoryboard.centerViewController()!
  }
  
  public func makeCenterViewModel() -> CenterViewModel {
    print("makeCenterViewModel")    
    return CenterViewModel()
  }
}

extension CenterDependencyContainer: CenterViewModelFactory {
}
//extension UIStoryboard {
//  static func centerViewController() -> CenterViewController? {
//    return mainStoryboard().instantiateViewController(withIdentifier: "CenterViewController") as? CenterViewController
//  }
//}
