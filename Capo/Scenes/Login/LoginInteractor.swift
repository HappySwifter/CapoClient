//
//  LoginInteractor.swift
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

protocol LoginBusinessLogic
{
    func login(request: Login.Something.Request)
}

protocol LoginDataStore
{
    var registerCredentials: Credentials? { get set }
}

class LoginInteractor: LoginBusinessLogic, LoginDataStore
{
    var presenter: LoginPresentationLogic?
    var worker: LoginWorker?
    var registerCredentials: Credentials? {
        didSet {
            if let registerCredentials = registerCredentials {
                let req = Login.Something.Request(credentials: registerCredentials)
                login(request: req)
            }
        }
    }
    
    func login(request: Login.Something.Request) {

        let loginMut = LoginMutation(email: request.credentials.email, password: request.credentials.password)
        apollo.client.perform(mutation: loginMut) { res, error in
            presentGraph(errors: res?.errors, error: error)
            guard let data = res?.data else { return }
            if let token = data.loginUser?.string,
                let userPayload = data.loginUser?.user?.fragments.userPayload {
                let user = User.saveUser(data: userPayload)
                CurrentUser.save(user: user, token: token)
                let res = Login.Something.Response(user: user)
                self.presenter?.presentLoginedUser(response: res)
            }
        }

    }
}
