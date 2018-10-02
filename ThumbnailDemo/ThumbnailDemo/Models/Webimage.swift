import Foundation

class Webimage: Mappable {

	var height: Int?
	var offsetPercentageY: Int?
	var width: Int?
	var offsetPercentageX: Int?
	var url: String?
	var guid: String?



    required init? (map: Map) {
        mapping	(map: map)
	}

	func mapping(map: Map) {
		height <- map["height"]
		offsetPercentageY <- map["offsetPercentageY"]
		width <- map["width"]
		offsetPercentageX <- map["offsetPercentageX"]
		url <- map["url"]
		guid <- map["guid"]
	}

}
