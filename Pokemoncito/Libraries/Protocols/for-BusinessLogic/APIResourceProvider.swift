//
//  APIResourceProvider.swift
//  Pokemoncito
//
//  Created by Alejandro on 7/1/19.
//  Copyright © 2019 Kalakmul. All rights reserved.
//

import Foundation

protocol APIResourceDescriptor {
    init(decodable: Decodable)
}

protocol APIResourceProvider {
}

protocol APIResourceProviderDelegate {
    func didFinishRetrieving(resources: [APIResourceDescriptor])
    func failedToRetrieveResources()
}
