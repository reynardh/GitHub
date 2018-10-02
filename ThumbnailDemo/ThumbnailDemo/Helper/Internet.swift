

import UIKit
import Reachability

// check network rechability
let internetReachability = Reachability.init()

public class Internet: NSObject {
        
    private static var internetShared = Internet()
    public class var sharedHelper: Internet{
        return internetShared
    }
    
    public var isInternetConnected:Bool = true
    
    override init() {
        super.init()
        startMonitoringInternet()
    }
    
    // MARK: Reachability Methods
    
    func startMonitoringInternet() {
        internetReachability?.whenReachable = { reachability in
            self.isInternetConnected = true
        }
        internetReachability?.whenUnreachable = { reachability in
            self.isInternetConnected = false
        }
        try! internetReachability?.startNotifier()
        
        // Initial reachability check
        if (internetReachability?.isReachable)! {
            isInternetConnected = true
        } else {
            isInternetConnected = false
        }
    }
    
    deinit {
        // stop reachbility notifier if view will disappear
        internetReachability?.stopNotifier()
    }
}



