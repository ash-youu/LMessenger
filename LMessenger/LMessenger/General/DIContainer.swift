//
//  DIContainer.swift
//  LMessenger
//
//  Created by 유연수 on 9/27/24.
//

import Foundation

class DIContainer: ObservableObject {
    var services: ServiceType
    
    init(services: ServiceType) {
        self.services = services
    }
}
