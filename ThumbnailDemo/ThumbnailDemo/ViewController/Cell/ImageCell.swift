
import UIKit
import SDWebImage

class ImageCell: UICollectionViewCell {
    
    @IBOutlet weak var ivThumbnail: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    
    func setThumbnail(artObj: Artobjects) {
        if let hasImage = artObj.hasImage, hasImage {
            if let imageUrl = artObj.webImage?.url {
                self.ivThumbnail.sd_setImage(with: URL(string: imageUrl), placeholderImage: #imageLiteral(resourceName: "NoDataFound"), options: SDWebImageOptions.continueInBackground) { (image, error, cacheType, url) in
                    
                }
            }
            if let title = artObj.title {
                self.lblTitle.text = title
            }
        } else {
            self.ivThumbnail.image = #imageLiteral(resourceName: "NoDataFound")
        }
    }
}
