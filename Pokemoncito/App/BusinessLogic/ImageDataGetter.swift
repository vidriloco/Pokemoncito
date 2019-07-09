//
//  ImageGetter.swift
//  Pokemoncito
//
//  Created by Alejandro on 7/6/19.
//  Copyright © 2019 Kalakmul. All rights reserved.
//

import Foundation

class ImageDataGetter: ResourceGetter {
    
    private let queue = DispatchQueue(label: "ImageDataGetter::SynchronizedAccess")
    private let dispatchQueue: DispatchQueue
    
    private var _tasks = [URLSessionTask]()
    private var tasks : [URLSessionTask] {
        var copyOfTasks = [URLSessionTask]()
        
        queue.async {
            copyOfTasks = self._tasks
        }
        
        return copyOfTasks
    }

    init(qualityOfService: DispatchQoS) {
        self.dispatchQueue = DispatchQueue.init(label: "ImageDataGetter::DispatchQueue", qos: qualityOfService)
    }
    
    func download(fromURL url: String, completion: @escaping (Data) -> Void) {
        dispatchQueue.async {
            
            guard self.tasks.index(where: { $0.originalRequest?.url?.absoluteString == url }) == nil else {
                return
            }

            // check for nil url
            guard let urlResource = URL(string: url) else {
                return
            }
            
            let task = URLSession.shared.dataTask(with: urlResource) { [weak self] (data, response, error) in
                
                guard let self = self else { return }

                self.dismissTask(withURL: url)

                if let data = data {
                    completion(data)
                } else {
                    self.download(fromURL: url, completion: completion)
                }
            }
            task.resume()
            self._tasks.append(task)
        }
    }
    
    private func indexForTask(withURL url: String) -> Int? {
        guard let taskIndex = tasks.index(where: { $0.originalRequest?.url?.absoluteString == url }) else {
            return nil
        }
        
        return taskIndex
    }
    
    func dismissTask(withURL url: String, markAsCancelled: Bool = false) {
        guard let taskIndex = indexForTask(withURL: url) else {
            return
        }
        
        _tasks.remove(at: taskIndex)
        
        if markAsCancelled {
            let task = tasks[taskIndex]
            task.cancel()
        }
    }
}
