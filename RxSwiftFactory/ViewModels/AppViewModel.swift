//
//  AppViewModel.swift
//  RxSwiftFactory
//
//  Created by Jonathan French on 25/04/2019.
//

import Foundation
import CoreData
import UIKit

public class AppViewModel {
  var managedContext: NSManagedObjectContext!
  var appDelegate: AppDelegate!
  public init() {
    print("AppViewModel Init")
    //appDelegate = UIApplication.shared.delegate as! AppDelegate
    //setSeedData()
  }
  
  
  func setSeedData(){
    appDelegate = UIApplication.shared.delegate as? AppDelegate
    managedContext = appDelegate.persistentContainer.viewContext
    
    let fetch: NSFetchRequest<Animals> = Animals.fetchRequest()
    fetch.predicate = NSPredicate(format: "title != nil")
    let count = try! managedContext.count(for: fetch)
    
    if count > 0 {
      return
    }
    
    for animal in Animal.allCats() {
      
      let newAnimal = Animals(context: managedContext)
      
      newAnimal.title = animal.title
      newAnimal.creator = animal.creator
      newAnimal.type = "Cat"
      newAnimal.thumbnail = imageScaledToHeight(animal.image!, height: 80)
      
      let imageObject = Images(context: managedContext)
      let imageData = animal.image!.jpegData(compressionQuality: 1.0) as NSData?
      print("image")
      //imageObject.animals = newAnimal
      imageObject.animalImage = imageData
      newAnimal.image = imageObject
      print("Saving \(newAnimal)")
      try! managedContext.save()
    }

    
    for animal in Animal.allDogs() {
      
      let newAnimal = Animals(context: managedContext)
      newAnimal.title = animal.title
      newAnimal.creator = animal.creator
      newAnimal.type = "Dog"
      newAnimal.thumbnail = imageScaledToHeight(animal.image!, height: 80)
      let imageObject = Images(context: managedContext)
      let imageData = animal.image!.jpegData(compressionQuality: 1.0) as NSData?
        print("image")
      //imageObject.animals = newAnimal
      imageObject.animalImage = imageData
      newAnimal.image = imageObject
       print("Saving \(newAnimal)")
      try! managedContext.save()
    }

    
  }
  
  func imageScaledToHeight(_ image: UIImage, height: CGFloat) -> NSData {
    
    let oldHeight = image.size.height
    let scaleFactor = height / oldHeight
    let newWidth = image.size.width * scaleFactor
    let newSize = CGSize(width: newWidth, height: height)
    let newRect = CGRect(x: 0, y: 0, width: newWidth, height: height)
    
    UIGraphicsBeginImageContext(newSize)
    image.draw(in: newRect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage!.jpegData(compressionQuality: 0.8)! as NSData
  }
  
}
