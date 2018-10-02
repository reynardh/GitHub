import Foundation

class GetImagesRes: Mappable {

	var elapsedMilliseconds: Int?
	var facets: [Facets]?
	var countFacets: Countfacets?
	var artObjects: [Artobjects]?
	var count: Int?



    required init? (map: Map) {
        mapping	(map: map)
	}

	func mapping(map: Map) {
		elapsedMilliseconds <- map["elapsedMilliseconds"]
		facets <- map["facets"]
		countFacets <- map["countFacets"]
		artObjects <- map["artObjects"]
		count <- map["count"]
	}

}
