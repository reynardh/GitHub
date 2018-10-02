import Foundation

class Links: Mappable {

	var web: String?
	var selfLinks: String?



    required init? (map: Map) {
        mapping	(map: map)
	}

	func mapping(map: Map) {
		web <- map["web"]
		selfLinks <- map["self"]
	}

}
