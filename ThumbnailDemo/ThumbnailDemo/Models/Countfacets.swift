import Foundation

class Countfacets: Mappable {

	var hasimage: Int?
	var ondisplay: Int?



    required init? (map: Map) {
        mapping	(map: map)
	}

	func mapping(map: Map) {
		hasimage <- map["hasimage"]
		ondisplay <- map["ondisplay"]
	}

}
