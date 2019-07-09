//
//  ResourceGetter.swift
//  Pokemoncito
//
//  Created by Alejandro on 7/6/19.
//  Copyright © 2019 Kalakmul. All rights reserved.
//

import Foundation

protocol ResourceGetter {
    func download(fromURL url: String, completion: @escaping (Data) -> Void)
    func dismissTask(withURL url: String, markAsCancelled: Bool)
}
