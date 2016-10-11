//
//  AlertMaker.swift
//  EasyTrailFinder
//
//  Created by Jon Thornburg on 10/4/16.
//  Copyright © 2016 Jon Thornburg. All rights reserved.
//

import Foundation
import UIKit

struct AlertMaker {
    
    static func showAlertWithTitleAndMessage(vc: UIViewController, title: String, message: String, add2ndAction: Bool, firstActionTitle: String, secondActionTitle: String?, completion: ((_ secondActionChosen: Bool?) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action1 = UIAlertAction(title: firstActionTitle, style: .cancel, handler: nil)
        
        var t2 = ""
        if let title2 = secondActionTitle {
            t2 = title2
        }
        let action2 = UIAlertAction(title: t2, style: .default) { (action2) in
            DispatchQueue.main.async(execute: {
                completion!(true)
            })
        }
        alert.addAction(action1)
        if add2ndAction {
            alert.addAction(action2)
        }
        vc.present(alert, animated: true, completion: nil)
    }

}
