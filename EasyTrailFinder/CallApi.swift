//
//  CallApi.swift
//  EasyTrailFinder
//
//  Created by Jon Thornburg on 10/4/16.
//  Copyright © 2016 Jon Thornburg. All rights reserved.
//

import Foundation

protocol DataCollector {
    func getDataBySearchTerm(term: String, completion: @escaping (_ trails: [Trail]?, _ error: Error?) -> Void)
}

class CallApi: DataCollector {
    
    func getDataBySearchTerm(term: String, completion: @escaping (_ trails: [Trail]?, _ error: Error?) -> Void) {
        let choppedLastEmptySpaceString = term.removeSpaceAtEnd()
        let encodedString = choppedLastEmptySpaceString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let url = URL(string: "https://outdoor-data-api.herokuapp.com/api.json?api_key=d6d33ee90666c461d901c731cc104b79&q[city_cont]=\(encodedString!)")
        let request = URLRequest(url: url!)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription)
                DispatchQueue.main.async(execute: { 
                    completion(nil, error! as Error)
                })
            } else {
                if let httpResponse = response as? HTTPURLResponse {
                    if ((httpResponse.statusCode == 200) || (httpResponse.statusCode == 201)) {
                        print("success")
                        do {
                            let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String : AnyObject]
                            print(json)
                            let dict = json["places"] as! [[String : AnyObject]]
                            var trailMaker = Trail()
                            var trailArray = [Trail]()
                            DispatchQueue.main.async(execute: { 
                                for place in dict {
                                    let newTrail = trailMaker.fromDictionary(dict: place)
                                    trailArray.append(newTrail)
                                    print(trailArray.count)
                                }
                                completion(trailArray, nil)
                            })
                        } catch let error as Error {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
        }
        dataTask.resume()
    }
}
