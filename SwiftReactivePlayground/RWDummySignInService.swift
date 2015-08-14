//
//  RWDummySignInService.swift
//  SwiftReactivePlayground
//
//  Created by Roberto Osorio Goenaga on 8/14/15.
//  http://www.raywenderlich.com/62699/reactivecocoa-tutorial-pt1
//

import UIKit

typealias RWSignInResponse = Bool? -> Void

class RWDummySignInService: NSObject {
    
    func signInWithUsername(username: String, password: String, complete: RWSignInResponse) {
        let delayInSeconds = 2.0
        let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(Double(NSEC_PER_SEC) * delayInSeconds))
        dispatch_after(popTime, dispatch_get_main_queue()) { () -> Void in
            let success = (username == "user") && (password == "password")
            complete(success)
        }
    }
    
}
