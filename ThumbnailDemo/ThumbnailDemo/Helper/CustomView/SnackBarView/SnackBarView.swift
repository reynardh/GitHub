

import UIKit

typealias snackBarActionHandler = () -> Void

class SnackBarView: UIView {
    
    var actionHandler: snackBarActionHandler?
    
    @IBOutlet weak var vwBackground: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnAction: UIButton!
    @IBOutlet weak var actionButtonWidthConstraint: NSLayoutConstraint!
    
    var bgColor: UIColor = UIColor.black
    var titleColor: UIColor = UIColor.white
    var actionColor: UIColor = UIColor.white
    var backgroundAlpha: CGFloat = 1
    var messageAlignment: NSTextAlignment = NSTextAlignment.left
    
    var bannerWindow: UIWindow?
    
    enum Direction: Int {
        case Top = 0
        case Bottom
    }
    var direction: Direction = Direction.Top
    
    enum Duration: Int {
        case Short = 0
        case Long
        case Infinite
        case Shortest
    }
    var duration: Duration = Duration.Short
    
    private static var snackbarViewHelper = SnackBarView.loadFromNibNamed(nibNamed: "SnackBarView") as! SnackBarView
    class var sharedHelper: SnackBarView{
        return snackbarViewHelper
    }
    
    private class func loadFromNibNamed(nibNamed: String, bundle : Bundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
    
    private func showSnackbar(message: String, actionTitle: String, actionHandler: snackBarActionHandler?) {
        self.actionHandler = actionHandler
        
        if let _ = actionHandler {
            self.btnAction.isHidden = false
        } else {
            self.btnAction.isHidden = true
        }
        
        self.setupSnackbar()
        
        self.frame = CGRect(x: 0, y: self.frame.size.height * -1, width: UIScreen.main.bounds.size.width, height: self.frame.size.height)
        
        self.lblTitle.text = message
        self.btnAction.setTitle(actionTitle, for: UIControlState.normal)
        
        if bannerWindow == nil {
            bannerWindow = UIWindow()
            bannerWindow!.windowLevel = UIWindowLevelStatusBar + 1
            bannerWindow!.backgroundColor = UIColor.clear
        }
        if self.direction == SnackBarView.Direction.Top {
            self.frame = CGRect(x: 0, y: self.frame.size.height * -1, width: UIScreen.main.bounds.size.width, height: self.frame.size.height)
            bannerWindow!.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: self.frame.size.height)
        } else {
            self.frame = CGRect(x: 0, y: self.frame.size.height, width: UIScreen.main.bounds.size.width, height: self.frame.size.height)
            bannerWindow!.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height - self.frame.size.height, width: UIScreen.main.bounds.size.width, height: self.frame.size.height)
        }
        
        bannerWindow!.isHidden = false
        bannerWindow!.addSubview(self)
        
        if self.direction == SnackBarView.Direction.Top {
            let frame = self.frame
            let origin = CGPoint(x: 0, y: -frame.height)
            self.frame = CGRect(origin: origin, size: frame.size)
            
            // Show appearing animation, schedule calling closing selector after completed
            UIView.animate(withDuration: 0.5, animations: {
                let frame = self.frame
                self.frame = frame.offsetBy(dx: 0, dy: frame.height)
                }, completion: { (finished) in
                    if self.duration == Duration.Short {
                        self.perform(#selector(SnackBarView.hideSnackBar), with: nil, afterDelay: 4)
                    } else if self.duration == Duration.Long {
                        self.perform(#selector(SnackBarView.hideSnackBar), with: nil, afterDelay: 5)
                    } else if self.duration == Duration.Shortest {
                        self.perform(#selector(SnackBarView.hideSnackBar), with: nil, afterDelay: 0.6)
                    }
                    
            })
        } else {
            let frame = self.frame
            let origin = CGPoint(x: 0, y: frame.height)
            self.frame = CGRect(origin: origin, size: frame.size)
            
            // Show appearing animation, schedule calling closing selector after completed
            UIView.animate(withDuration: 0.5, animations: {
                let frame = self.frame
                self.frame = frame.offsetBy(dx: 0, dy: -frame.height)
                }, completion: { (finished) in
                    if self.duration == Duration.Short {
                        self.perform(#selector(SnackBarView.hideSnackBar), with: nil, afterDelay: 2)
                    } else if self.duration == Duration.Long {
                        self.perform(#selector(SnackBarView.hideSnackBar), with: nil, afterDelay: 5)
                    } else if self.duration == Duration.Shortest {
                        self.perform(#selector(SnackBarView.hideSnackBar), with: nil, afterDelay: 0.6)
                    }
                    
            })
        }
    }
    
    func setupSnackbar() {
//        self.backgroundColor = bgColor
        vwBackground.backgroundColor = bgColor
        vwBackground.alpha = backgroundAlpha
        lblTitle.textColor = titleColor
        lblTitle.textAlignment = messageAlignment
        btnAction.setTitleColor(actionColor, for: UIControlState.normal)
    }
    
    @objc func hideSnackBar() {
        if self.direction == SnackBarView.Direction.Top {
            UIView.animate(withDuration: 5, animations: { () -> Void in
                self.frame.origin.y = self.frame.size.height * -1
            }) { (isComplete) -> Void in
                UIApplication.shared.isStatusBarHidden = false
                self.removeFromSuperview()
            }
        } else {
            UIView.animate(withDuration: 1, animations: { () -> Void in
                self.frame.origin.y = self.frame.size.height
            }) { (isComplete) -> Void in
                UIApplication.shared.isStatusBarHidden = false
                self.removeFromSuperview()
            }
        }
        bannerWindow?.removeFromSuperview()
        bannerWindow = nil
        
    }
    
    class func displaySnackBar(message: String, actionTitle: String, ColorBg: UIColor, duration: SnackBarView.Duration?, direction: SnackBarView.Direction = Direction.Top, actionHandler: snackBarActionHandler?) {
        
        SnackBarView.sharedHelper.bgColor = ColorBg
        SnackBarView.sharedHelper.backgroundAlpha = 1
        SnackBarView.sharedHelper.titleColor = UIColor.white
        SnackBarView.sharedHelper.actionColor = UIColor.white
        SnackBarView.sharedHelper.direction = direction
        
        if let durationTemp = duration {
            SnackBarView.sharedHelper.duration = durationTemp
        } else {
            SnackBarView.sharedHelper.duration = SnackBarView.Duration.Infinite
        }
        SnackBarView.sharedHelper.showSnackbar(message: message, actionTitle: actionTitle, actionHandler: actionHandler)
    }
        
    //MARK: Action Method
    
    @IBAction func btnActionTapped(sender: UIButton) {
        hideSnackBar()
        actionHandler!()
    }
    
    open fileprivate(set) var isAnimating = false
    open fileprivate(set) var isDragging = false
    
    @IBAction func swipeUpRecognized(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .ended:
            self.isDragging = false
            if frame.origin.y < 0 {
                self.hide(completion: nil)
            }
            break
            
        case .began:
            self.isDragging = true
            break
            
        case .changed:
            
            guard let superview = self.superview else {
                return
            }
            
            guard let gestureView = gesture.view else {
                return
            }
            
            let translation = gesture.translation(in: superview)
            // Figure out where the user is trying to drag the view.
            let newCenter = CGPoint(x: superview.bounds.size.width / 2,
                                    y: gestureView.center.y + translation.y)
            
            // See if the new position is in bounds.
            if (newCenter.y >= (-1 * self.frame.size.height / 2) && newCenter.y <= self.frame.size.height / 2) {
                gestureView.center = newCenter
                gesture.setTranslation(CGPoint.zero, in: superview)
            }
            
            break
            
        default:
            break
        }
    }
    
    public func hide(completion: (() -> ())?) {
        
        guard !self.isDragging else {
//            self.dismissTimer = nil
            return
        }
        
        if self.superview == nil {
            isAnimating = false
            return
        }
        
        // Case are in animation of the hide
        if (isAnimating) {
            return
        }
        isAnimating = true
        
        // Invalidate timer auto close
//        self.dismissTimer = nil
        
        /// Show animation
        UIView.animate(withDuration: 1, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            
            var frame = self.frame
            frame.origin.y -= frame.size.height
            self.frame = frame
            
        }) { (finished) in
            
            self.removeFromSuperview()
            UIApplication.shared.delegate?.window??.windowLevel = UIWindowLevelNormal
            
            self.isAnimating = false
            
            completion?()
            
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
