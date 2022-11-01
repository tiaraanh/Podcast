//
//  SearchResponse.swift
//  PodcastsApp
//
//  Created by Tiara H on 26/10/22.
//

import Foundation

// response
struct SearchResponse: Decodable {
    let count: Int
    let results: [Podcast]
    
    // keys in JSON will be map into the variable of resultcount
    enum CodingKeys: String, CodingKey {
        case count = "resultCount"
        case results
    }
    
    // conductor input with decoder
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        count = try container.decodeIfPresent(Int.self, forKey: .count) ?? 0
        results = try container.decodeIfPresent([Podcast_].self, forKey: .results) ?? []
    }
}
