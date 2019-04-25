
import UIKit
import QuartzCore
import CoreData

enum SlideOutState {
  case bothCollapsed
  case leftPanelExpanded
  case rightPanelExpanded
}

public class ContainerViewController: NiblessViewController {
  
  var centerNavigationController: RxSwiftFactoryNavigationController!
  var viewModel: AppViewModel!
  var centerViewController: CenterViewController!
  var currentState: SlideOutState = .bothCollapsed {
    didSet {
      let shouldShowShadow = currentState != .bothCollapsed
      showShadowForCenterViewController(shouldShowShadow)
    }
  }
  var leftViewController: SidePanelViewController?
  var rightViewController: SidePanelViewController?
  let centerPanelExpandedOffset: CGFloat = 90
  
  public init(viewModel: AppViewModel,navigationController:RxSwiftFactoryNavigationController,leftPanelViewControllerFactory: @escaping() -> SidePanelViewController, rightPanelViewControllerFactory: @escaping() -> SidePanelViewController) {
    super.init()

    self.viewModel = viewModel
    viewModel.setSeedData()
    
    self.centerNavigationController = navigationController
    self.centerViewController = navigationController.visibleViewController as? CenterViewController

    self.leftViewController = leftPanelViewControllerFactory()
    self.rightViewController = rightPanelViewControllerFactory()

    self.leftViewController?.delegate = self.centerViewController
    self.rightViewController?.delegate = self.centerViewController
    self.centerViewController.delegate = self
    
    self.view.addSubview(self.centerNavigationController.view)
    self.addChild(self.centerNavigationController)
    
    centerNavigationController.didMove(toParent: self)
    let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
    centerNavigationController.view.addGestureRecognizer(panGestureRecognizer)
  }
  
}

extension ContainerViewController: UIGestureRecognizerDelegate {
  @objc func handlePanGesture(_ recognizer: UIPanGestureRecognizer){
    let gestureIsDraggingFromLeftToRight = (recognizer.velocity(in: view).x > 0)
    switch recognizer.state {
    case .began:
      if currentState == .bothCollapsed {
        if gestureIsDraggingFromLeftToRight {
          addLeftPanelViewController()
        } else {
          addRightPanelViewController()
        }
        showShadowForCenterViewController(true)
      }
    case .changed:
      if let rview = recognizer.view {
        rview.center.x = rview.center.x + recognizer.translation(in: view).x
        recognizer.setTranslation(CGPoint.zero, in: view)
      }
    case .ended:
      if let _ = leftViewController,
        let rview = recognizer.view {
        let hasMovedGreaterThanHalfway = rview.center.x > view.bounds.size.width
        animateLeftPanel(shouldExpand: hasMovedGreaterThanHalfway)
      } else if let _ = rightViewController,
        let rview = recognizer.view {
        let hasMovedGreaterThanHalfway = rview.center.x < 0
        animateRightPanel(shouldExpand: hasMovedGreaterThanHalfway)
      }
      
    default:
      break
    }
  }
}

extension ContainerViewController: CenterViewControllerDelegate {
  func toggleLeftPanel() {
    let notAlreadyExpanded = (currentState != .leftPanelExpanded)
    
    if notAlreadyExpanded {
      addLeftPanelViewController()
    }
    
    animateLeftPanel(shouldExpand: notAlreadyExpanded)
    
  }
  
  func addLeftPanelViewController() {
    guard leftViewController != nil else { return }
    //addFullScreen(childViewController: leftViewController!)
    addChildSidePanelController(leftViewController!)
  }
  
  func animateLeftPanel(shouldExpand: Bool) {
    if shouldExpand {
      currentState = .leftPanelExpanded
      animateCenterPanelXPosition(targetPosition: centerNavigationController.view.frame.width - centerPanelExpandedOffset)
    } else {
      animateCenterPanelXPosition(targetPosition: 0) { _ in
        self.currentState = .bothCollapsed
        self.leftViewController?.view.removeFromSuperview()
        //self.leftViewController = nil
      }
    }
  }
  
  func toggleRightPanel() {
    let notAlreadyExpanded = (currentState != .rightPanelExpanded)

    if notAlreadyExpanded {
      addRightPanelViewController()
    }
    
    animateRightPanel(shouldExpand: notAlreadyExpanded)
  }
  
  func addRightPanelViewController() {
    guard rightViewController != nil else { return }

    //addFullScreen(childViewController: rightViewController!)
    addChildSidePanelController(rightViewController!)

  }
  
  func animateRightPanel(shouldExpand: Bool) {
    if shouldExpand {
      currentState = .rightPanelExpanded
      animateCenterPanelXPosition(targetPosition: -centerNavigationController.view.frame.width + centerPanelExpandedOffset)
    } else {
      animateCenterPanelXPosition(targetPosition: 0) { _ in
        self.currentState = .bothCollapsed
        self.rightViewController?.view.removeFromSuperview()
        //self.rightViewController = nil
      }
    }
  }
  
  
  func collapseSidePanels() {
    switch currentState {
    case .rightPanelExpanded:
      toggleRightPanel()
    case .leftPanelExpanded:
      toggleLeftPanel()
    case .bothCollapsed:
      break
    }
  }
  
  func animateCenterPanelXPosition(targetPosition: CGFloat, completion: ((Bool) -> Void)? = nil) {
  UIView.animate(withDuration: 0.5,
                 delay: 0,
                 usingSpringWithDamping: 0.8,
                 initialSpringVelocity: 0,
                 options: .curveEaseInOut,
                 animations: {
                  self.centerNavigationController.view.frame.origin.x = targetPosition
    },
                 completion: completion)
    
  }
  
  func addChildSidePanelController(_ sidePanelController: SidePanelViewController) {
    //addFullScreen(childViewController: sidePanelController)
    sidePanelController.view.frame = view.frame
    view.insertSubview(sidePanelController.view, at: 0)
    addChild(sidePanelController)
    sidePanelController.didMove(toParent: self)
  }
  
  func showShadowForCenterViewController(_ shouldShowShadow: Bool) {
    if shouldShowShadow {
      centerNavigationController.view.layer.shadowOpacity = 0.8
    } else {
      centerNavigationController.view.layer.shadowOpacity = 0.0
    }
  }

}

protocol ContainerViewModelFactory {
  
  func makeContainerViewModel() -> ContainerViewModel
}
