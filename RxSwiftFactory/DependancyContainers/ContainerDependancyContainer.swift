//
//  DependancyControllers.swift
//  RxSwiftFactory
//
//  Created by Jonathan French on 25/04/2019.
//

import UIKit
import CoreData
import RxSwift
import RxCocoa

public class ContainerDependancyContainer {
  
  public init(appDependencyContainer: AppDependencyContainer){
    
  }
  
  public func makeContainerDependancyContainer() -> ContainerDependancyContainer {
    return ContainerDependancyContainer(appDependencyContainer: AppDependencyContainer())
  }

  public func makeContainerViewController(viewModel:AppViewModel, navigationController: RxSwiftFactoryNavigationController) -> ContainerViewController {

    let fetchData = {(animal:String) -> [Animals] in
      let fetch: NSFetchRequest<Animals> = Animals.fetchRequest()
      fetch.predicate = NSPredicate(format: "%K = %@",
                                    argumentArray: [#keyPath(Animals.type),
                                                    animal])
      let animals = try! viewModel.managedContext.fetch(fetch)
      return animals
    }
    
    let leftSidePanelViewControllerFactory = {() -> SidePanelViewController in
      let vc = self.makeSidePanelViewController()
      vc.viewModel.animals = BehaviorRelay(value: fetchData("Cat"))
      vc.viewModel.cellType = LeftCell.self
      vc.viewModel.headerImage = UIImage.init(imageLiteralResourceName: "ID-100113060")

      return vc
    }
   
    let rightSidePanelViewControllerFactory = { () -> SidePanelViewController in
      let vc =  self.makeSidePanelViewController()
      vc.viewModel.animals = BehaviorRelay(value: fetchData("Dog"))
      vc.viewModel.cellType = RightCell.self
      vc.viewModel.headerImage = UIImage.init(imageLiteralResourceName: "ID-100137")

      return vc
    }
    
    let containerViewController =  ContainerViewController(viewModel:viewModel,navigationController: navigationController,leftPanelViewControllerFactory:leftSidePanelViewControllerFactory, rightPanelViewControllerFactory: rightSidePanelViewControllerFactory)
    return containerViewController



  }
  
  public func makeSidePanelViewController() -> SidePanelViewController {
    let dependencyContainer = SidePanelDependencyContainer(containerDependencyContainer: self)
    return dependencyContainer.makeSidePanelViewController()
  }
  

  
}

