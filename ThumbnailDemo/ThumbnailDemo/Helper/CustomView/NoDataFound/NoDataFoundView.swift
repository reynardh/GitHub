
import UIKit

public class NoDataFoundView: UIView {

    @IBOutlet weak var ivNoDataFound: UIImageView!
    @IBOutlet weak var lblNoDataFoundTitle: UILabel!
    @IBOutlet weak var lblNoDataFoundMessage: UILabel!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    
    public var titleFont: UIFont?
    public var titleFontColor: UIColor?
    public var messageFont: UIFont?
    public var messageFontColor: UIColor?
    public var noDataImageHeight: CGFloat?
    
    var noDataFoundTitle: String?
    var noDataFoundMessage: String?
    var noDataFoundImage: UIImage?
    
    private static var noDataFoundView = NoDataFoundView.loadFromNibNamed(nibNamed: "NoDataFoundView") as! NoDataFoundView
    
    public class var sharedHelper: NoDataFoundView{
        return noDataFoundView
    }
    
    private class func loadFromNibNamed(nibNamed: String, bundle : Bundle? = Bundle(for: NoDataFoundView.self)) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
    
    public class func showNodataFoundPopup(view: UIView) {
        
        NoDataFoundView.sharedHelper.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        NoDataFoundView.sharedHelper.tag = 101
        
        noDataFoundView.lblNoDataFoundTitle.text = "No Data Found"
        noDataFoundView.lblNoDataFoundMessage.text = "No data available."
        noDataFoundView.ivNoDataFound.image = #imageLiteral(resourceName: "NoDataFound")
        
        NoDataFoundView.setFontStyleAndColor()

        view.addSubview(NoDataFoundView.sharedHelper)
    }
    
    public class func hideNodataFoundPopup() {
        // uncomment if your view is embeded in navigation controller
        //        self.superview!.viewController()?.navigationController?.navigationBar.userInteractionEnabled = true
        NoDataFoundView.sharedHelper.removeFromSuperview()
    }
    
    public static func setFontStyleAndColor() {
        if let titleFont = noDataFoundView.titleFont {
            noDataFoundView.lblNoDataFoundTitle.font = titleFont
        }
        if let titleFontColor = noDataFoundView.titleFontColor {
            noDataFoundView.lblNoDataFoundTitle.textColor = titleFontColor
        }
        if let messageFont = noDataFoundView.messageFont {
            noDataFoundView.lblNoDataFoundMessage.font = messageFont
        }
        if let messageFontColor = noDataFoundView.messageFontColor {
            noDataFoundView.lblNoDataFoundMessage.textColor = messageFontColor
        }
        if let imageHeight = noDataFoundView.noDataImageHeight {
            noDataFoundView.imageHeightConstraint.constant = imageHeight
        }
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
