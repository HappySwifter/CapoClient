//
//  UserProfileInteractor.swift
//  Capo
//
//  Created by Артем Валиев on 12/12/2018.
//  Copyright (c) 2018 Артем Валиев. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol UserProfileBusinessLogic
{
  func doSomething(request: UserProfile.Something.Request)
}

protocol UserProfileDataStore
{
  //var name: String { get set }
}

class UserProfileInteractor: UserProfileBusinessLogic, UserProfileDataStore
{
  var presenter: UserProfilePresentationLogic?
  var worker: UserProfileWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: UserProfile.Something.Request)
  {
    worker = UserProfileWorker()
    worker?.doSomeWork()
    
    let response = UserProfile.Something.Response()
    presenter?.presentSomething(response: response)
  }
}