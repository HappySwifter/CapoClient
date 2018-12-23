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
    func fetchUser(request: UserProfile.FetchUser.Request)
    func updateUser(request: UserProfile.UpdateUser.Request)
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
    
    func fetchUser(request: UserProfile.FetchUser.Request) {
        if let user = CurrentUser.getUser() {
            present(user: user)
        } else {
            assert(false, "user is not logged in")
        }
        
    }
    
    func updateUser(request: UserProfile.UpdateUser.Request) {
        let mut = UpdateUserMutation(name: request.name, imagePath: request.userProfileImage)
        apollo.client.perform(mutation: mut) { [weak self] (res, error) in
            presentGraph(errors: res?.errors, error: error)
            guard let data = res?.data else { return }
            if let userPayload = data.updateUser?.fragments.userPayload {
                let user = User.saveUser(data: userPayload)
                self?.present(user: user)
            }
        }
    }
    
    func present(user: User) {
        let res = UserProfile.FetchUser.Response(user: user)
        presenter?.presentUser(response: res)
    }
}
