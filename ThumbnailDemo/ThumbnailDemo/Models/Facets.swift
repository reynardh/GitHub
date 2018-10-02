import Foundation

class Facets: Mappable {

	var name: String?
	var facets: [Facets]?
	var prettyName: Int?
	var otherTerms: Int?



    required init? (map: Map) {
        mapping	(map: map)
	}

	func mapping(map: Map) {
		name <- map["name"]
		facets <- map["facets"]
		prettyName <- map["prettyName"]
		otherTerms <- map["otherTerms"]
	}

}
