

import Foundation
import MBProgressHUD
import UIKit

extension UIViewController {
    
    open override func awakeFromNib() {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }

    // MARK: MBProgressHUD Methods
    
    public func showProgressInView(currentView: UIView!) {
        MBProgressHUD.showAdded(to: currentView, animated: true)
    }
    
    public func hideProgressInView(currentView: UIView!) {
        MBProgressHUD.hide(for: currentView, animated: true)
    }
}
