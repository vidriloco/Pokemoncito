//
//  ImageGetter.swift
//  Pokemoncito
//
//  Created by Alejandro on 7/6/19.
//  Copyright © 2019 Kalakmul. All rights reserved.
//

import Foundation

class ImageDataGetter: ResourceGetter {
    
    private let dispatchQueue: DispatchQueue
    private var tasks = [URLSessionTask]()
    
    init(qualityOfService: DispatchQoS) {
        self.dispatchQueue = DispatchQueue.init(label: "ImageDataGetter::DispatchQueue", qos: qualityOfService)
    }
    
    func download(fromURL url: String, completion: @escaping (Data) -> Void) {
        dispatchQueue.async {
            
            guard self.tasks.index(where: { $0.originalRequest?.url?.absoluteString == url }) == nil else {
                return
            }
            print(url)
            // check for nil url
            guard let urlResource = URL(string: url) else {
                return
            }
            
            let task = URLSession.shared.dataTask(with: urlResource) { [weak self] (data, response, error) in
                
                guard let self = self else { return }
                
                if let data = data {
                    completion(data)
                } else {
                    self.download(fromURL: url, completion: completion)
                }
            }
            task.resume()
            self.tasks.append(task)
        }
    }
    
    func cancelDownload(fromURL url: String) {
        guard let taskIndex = tasks.index(where: { $0.originalRequest?.url?.absoluteString == url }) else {
            return
        }
        
        let task = tasks[taskIndex]
        task.cancel()
        tasks.remove(at: taskIndex)
    }
}
