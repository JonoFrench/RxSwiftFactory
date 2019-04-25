//
//  SidePanelViewModel.swift
//  RxSwiftFactory
//
//  Created by Jonathan French on 25/04/2019.
//

import Foundation
import RxSwift
import RxCocoa

public class SidePanelViewModel {
  
  //var sharedAppViewModel: AppViewModel
  
  var animals: BehaviorRelay<[Animals]> = BehaviorRelay(value: [])
  var cellType = AnimalCell.self
  var headerImage = UIImage.init(imageLiteralResourceName: "ID-100137")
  
  public init() {
    //self.sharedAppViewModel = sharedAppViewModel
    print("SidePanelViewModel init")
  }
}
