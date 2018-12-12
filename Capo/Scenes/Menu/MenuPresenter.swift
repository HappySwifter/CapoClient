//
//  MenuPresenter.swift
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

protocol MenuPresentationLogic
{
  func presentSomething(response: Menu.Something.Response)
}

class MenuPresenter: MenuPresentationLogic
{
  weak var viewController: MenuDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: Menu.Something.Response)
  {
    let viewModel = Menu.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}