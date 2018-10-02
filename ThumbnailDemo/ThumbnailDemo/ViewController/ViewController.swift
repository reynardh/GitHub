

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var cvImages: UICollectionView!
    
    var arrArtObjects: [Artobjects] = []
    
    var isLoadMore = true
    
    //MARK: View LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        getThumbnails()
    }
    
    //MARK: Webservice call
    
    func getThumbnails() {
        APICall.sharedInstance.callWebServiceWith(viewController: self, url: "\(CULTURE)/collection?key=\(API_KEY)&ps=\(RECORDS_PER_PAGE)&format=json", method: HTTPMethod.get) { (response) in
            if let responseObj = response {
                let imageRes = Mapper<GetImagesRes>().map(JSON: responseObj as! [String : Any])
                if let artObject = imageRes?.artObjects {
                    self.arrArtObjects = artObject
                    self.cvImages.reloadData()
                } else {
                    self.displayNoDataFound()
                }
            } else {
                self.displayNoDataFound()
            }
        }
    }
    
    func displayNoDataFound() {
        NoDataFoundView.showNodataFoundPopup(view: self.view)
    }
    
    //MARK: Other Methods

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return isLoadMore ? self.arrArtObjects.count + 1 : arrArtObjects.count
        return self.arrArtObjects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == self.arrArtObjects.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LoadingCell", for: indexPath)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
            cell.setThumbnail(artObj: self.arrArtObjects[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = (self.view.frame.size.width - 10) / 2
        return CGSize(width: cellWidth - 10, height: cellWidth - 10)
    }
}

