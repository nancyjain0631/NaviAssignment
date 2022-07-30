//
//  ClosedPRViewModel.swift
//  NaviAssignment1
//
//  Created by Nancy Jain on 30/07/22.
//

import Foundation

class ClosedPRViewModel {
    
    var apiService = ApiServices()
    var userDetails = [UserDetails]()
    
    func fetchClosedPR(completion: @escaping () -> ()) {
        apiService.getData(pagination: false) { [weak self] (result) in
            switch result {
            case .success(let listOf):
                self?.userDetails = listOf.reversed()
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if userDetails.count != 0 {
            return userDetails.count
        }
        return 0
    }
    
    func cellForRowAt(indexPath: IndexPath) -> UserDetails {
        return userDetails[indexPath.row]
    }
}
