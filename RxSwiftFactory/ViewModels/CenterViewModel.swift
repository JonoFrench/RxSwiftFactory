//
//  CenterViewModel.swift
//  RxSwiftFactory
//
//  Created by Jonathan French on 25/04/2019.
//

import Foundation
import RxSwift
import RxCocoa
import CoreData

public class CenterViewModel {
  
  var animal: BehaviorRelay<Animals> = BehaviorRelay(value: Animals())
  let disposeBag = DisposeBag()

  public init() {
    
    print("CenterViewModel Init")
//    let appDelegate = UIApplication.shared.delegate as? AppDelegate
//    let managedContext = appDelegate!.persistentContainer.viewContext
//
//    let fetch: NSFetchRequest<Animals> = Animals.fetchRequest()
//    let res = try? managedContext.fetch(fetch)
//    animal = BehaviorRelay(value: res![0])
  }
}

