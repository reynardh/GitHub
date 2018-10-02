import Alamofire
import MBProgressHUD

public typealias HttpResponseHandler = (_ responseData: Any?) -> Void
public typealias Params = Dictionary<String, Any>?

public class APICall  {
    
    var viewController: UIViewController?
    var URL: String?
    var method: HTTPMethod?
    var wsParams: [String: Any]!
    
    var completionHandler: HttpResponseHandler?
    
    //MARK: Shared Instance
    public static let sharedInstance : APICall = {
        let instance = APICall()
        return instance
    }()
    
    private var backgroundManager:SessionManager = {
        return SessionManager(configuration: URLSessionConfiguration.background(withIdentifier: "com.ThumbnailTest"))
    }()
    
    public func callWebServiceWith(viewController: UIViewController, url: String, method: HTTPMethod, completionHandler: HttpResponseHandler!) {
        self.viewController = viewController
        self.completionHandler = completionHandler
        self.URL = WS_BASE_URL + url
        self.method = method
        
        self.makeAPICall()
    }
    
    private func makeAPICall() {
        
        if Internet.sharedHelper.isInternetConnected {

            self.viewController!.showProgressInView(currentView: self.viewController!.view)
    
            var parameterEncoding: ParameterEncoding = JSONEncoding.default
            if self.method == HTTPMethod.get {
                parameterEncoding = URLEncoding.queryString
            }
            backgroundManager.request(self.URL!, method: self.method!, parameters: self.wsParams, encoding: parameterEncoding, headers: nil)
                
                .responseJSON { response in
                    self.handleMainResponse(response: response)
            }
            
        } else {
            NoInternetConnectionView.showNoInternetView(view: self.viewController!.view, noInternetHandler: {
                self.makeAPICall()
            })
        }
    }
    
    func handleMainResponse(response: DataResponse<Any>) {
        // Hide progress view
        self.viewController!.hideProgressInView(currentView: self.viewController!.view)
        
        switch response.result {
        case .success( _):
            self.handleSuccessBlock(response: response)
            break
        case .failure(let error):
            self.handleFailureBlock(response: response, error: error)
            break
        }
    }
    
    func handleSuccessBlock(response: DataResponse<Any>) {
        if let _ = response.response {
            completionHandler!(response.result.value)
        }
    }
    
    func handleFailureBlock(response: DataResponse<Any>, error: Error) {
        if error._code == NSURLErrorTimedOut {
            NoInternetConnectionView.showTimeoutView(view: self.viewController!.view, timeoutHandler: {
                self.makeAPICall()
            })
        } else {
            if let _ = response.response {
                SnackBarView.displaySnackBar(message: "Something went wrong. Please try again later.", actionTitle: "", ColorBg: UIColor.red, duration: SnackBarView.Duration.Short, actionHandler: {
                })
            }
        }
    }
}
