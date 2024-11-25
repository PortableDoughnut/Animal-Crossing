//
//  Villager.swift
//  Animal Crossing
//
//  Created by Gwen Thelin on 11/25/24.
//

import Foundation

struct Villager: Decodable {
	var name: String
	var species: String
	var personality: String
	var birthMonth: String
	var imageURL: URL
	
	enum CodingKeys: String, CodingKey {
		case name
		case species
		case personality
		case birthMonth = "birthday_month"
		case imageURL = "image_url"
	}
}
