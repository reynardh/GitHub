

import UIKit

public typealias NoInternetRefreshHandler = () -> Void

public class NoInternetConnectionView: UIView {
    
    @IBOutlet weak var imgNoInternet: UIImageView!
    @IBOutlet weak var btnTapToRefresh: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var ivRefresh: UIImageView!
    @IBOutlet weak var lblRefreshMessage: UILabel!
    
    var noInternetHandler: NoInternetRefreshHandler?
    
    private static var noInternetConnectionView = NoInternetConnectionView.loadFromNibNamed(nibNamed: "NoInternetConnectionView") as! NoInternetConnectionView
    
    class var noInternetHelper: NoInternetConnectionView{
        return noInternetConnectionView
    }
    
    private class func loadFromNibNamed(nibNamed: String, bundle : Bundle? = Bundle(for: NoInternetConnectionView.self)) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
    
    public class func showTimeoutView(view: UIView, timeoutHandler: @escaping NoInternetRefreshHandler) {
        NoInternetConnectionView.noInternetHelper.lblTitle.text =  "Timeout"
        NoInternetConnectionView.noInternetHelper.lblMessage.text = "Check your internet connection and try again."
        NoInternetConnectionView.noInternetHelper.imgNoInternet.image = #imageLiteral(resourceName: "NoIntenet")
        NoInternetConnectionView.noInternetHelper.lblRefreshMessage.text = "Refresh"
        NoInternetConnectionView.noInternetHelper.ivRefresh.image = #imageLiteral(resourceName: "refresh-button")
        
        NoInternetConnectionView.noInternetHelper.noInternetHandler = timeoutHandler
        NoInternetConnectionView.noInternetHelper.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        
        // uncomment if your view is embeded in navigation controller
        //        view.viewController()?.navigationController?.navigationBar.userInteractionEnabled = false
        view.addSubview(NoInternetConnectionView.noInternetHelper)
    }
    
    public class func showNoInternetView(view: UIView, noInternetHandler: @escaping NoInternetRefreshHandler) {
        
        NoInternetConnectionView.noInternetHelper.lblTitle.text =  "No Internet Connection"
        NoInternetConnectionView.noInternetHelper.lblMessage.text = "Please make sure you are connected to internet."
        NoInternetConnectionView.noInternetHelper.imgNoInternet.image = #imageLiteral(resourceName: "NoIntenet")
        NoInternetConnectionView.noInternetHelper.lblRefreshMessage.text = "Refresh"
        NoInternetConnectionView.noInternetHelper.ivRefresh.image = #imageLiteral(resourceName: "refresh-button")
        
        NoInternetConnectionView.noInternetHelper.noInternetHandler = noInternetHandler
        NoInternetConnectionView.noInternetHelper.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        
        // uncomment if your view is embeded in navigation controller
        //        view.viewController()?.navigationController?.navigationBar.userInteractionEnabled = false
        view.addSubview(NoInternetConnectionView.noInternetHelper)
    }
    
    class func hideNoInternetView() {
        // uncomment if your view is embeded in navigation controller
        //        self.superview!.viewController()?.navigationController?.navigationBar.userInteractionEnabled = true
        NoInternetConnectionView.noInternetHelper.removeFromSuperview()
    }
    
    //MARK: Action Methods
    
    @IBAction func btnRetryTapped(sender: UIButton) {
        NoInternetConnectionView.hideNoInternetView()
        NoInternetConnectionView.noInternetHelper.noInternetHandler!()
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
