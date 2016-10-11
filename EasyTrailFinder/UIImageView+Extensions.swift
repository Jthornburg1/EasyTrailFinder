//
//  UIImageView+Extensions.swift
//  EasyTrailFinder
//
//  Created by Jon Thornburg on 10/5/16.
//  Copyright © 2016 Jon Thornburg. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func downloadImageFrom(urlString: String, completion: @escaping () -> Void) {
        if let imgUrl = URL(string: urlString) {
            let request = URLRequest(url: imgUrl)
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request) { (data, response, error) in
                if error != nil {
                    print(error?.localizedDescription)
                    DispatchQueue.main.async(execute: {
                        self.image = UIImage(named: "default")
                        completion()
                    })
                } else {
                    if let httpResponse = response as? HTTPURLResponse {
                        if httpResponse.statusCode == 200 || httpResponse.statusCode == 201 {
                            print("success")
                            if let data = data {
                                DispatchQueue.main.async(execute: {
                                    print("download completed: \(imgUrl.lastPathComponent)")
                                    self.image = UIImage(data: data)
                                    completion()
                                })
                            }
                        }
                    }
                }
            }
            dataTask.resume()
        } else {
            self.image = nil
        }
    }
}
