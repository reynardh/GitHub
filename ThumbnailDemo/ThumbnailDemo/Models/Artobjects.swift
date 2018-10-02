import Foundation

class Artobjects: Mappable {

	var title: String?
	var objectNumber: String?
	var id: String?
	var links: Links?
	var principalOrFirstMaker: String?
	var longTitle: String?
	var webImage: Webimage?
	var headerImage: Headerimage?
	var permitDownload: Int?
	var productionPlaces: [String]?
	var hasImage: Bool?
	var showImage: Bool?



    required init? (map: Map) {
        mapping	(map: map)
	}

	func mapping(map: Map) {
		title <- map["title"]
		objectNumber <- map["objectNumber"]
		id <- map["id"]
		links <- map["links"]
		principalOrFirstMaker <- map["principalOrFirstMaker"]
		longTitle <- map["longTitle"]
		webImage <- map["webImage"]
		headerImage <- map["headerImage"]
		permitDownload <- map["permitDownload"]
		productionPlaces <- map["productionPlaces"]
		hasImage <- map["hasImage"]
		showImage <- map["showImage"]
	}

}
