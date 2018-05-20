//
//  SearchResult.swift
//  StoreSearch
//
//  Created by Permi on 2018/5/7.
//  Copyright © 2018 Permi. All rights reserved.
//

import Foundation

class ResultArray: Codable {
    var resultCount: Int = 0
    var results = [SearchResult]()
}

class SearchResult: Codable, CustomStringConvertible {
    var kind: String?
    var artistName = ""
    var trackName: String?
    var trackPrice: Double?
    var trackViewUrl: String?
    var collectionName: String?
    var collectionPrice: Double?
    var collectionViewUrl: String?
    var itemPrice: Double?
    var itemGenre: String?
    var bookGenre: [String]?
    var currency = ""
    var imageSmall = ""
    var imageLarge = ""
    
    enum CodingKeys:String, CodingKey {
        case imageSmall = "artworkUrl60"
        case imageLarge = "artworkUrl100"
        case itemGenre = "primaryGenreName"
        case bookGenre = "genres"
        case itemPrice = "price"
        case artistName, kind, currency
        case trackName, trackPrice, trackViewUrl
        case collectionName, collectionPrice, collectionViewUrl
    }
    
    var name: String {
        return trackName ?? collectionName ?? ""
    }
    
    var storeUrl: String {
        return trackViewUrl ?? collectionViewUrl ?? ""
    }
    
    var price: Double {
        return trackPrice ?? collectionPrice ?? itemPrice ?? 0.0
    }
    
    var genre: String {
        if let genre = itemGenre {
            return genre
        } else if let genres = bookGenre {
            return genres.joined(separator: ", ")
        }
        return ""
    }
    
    var type: String {
        let kind = self.kind ?? "audiobook"
        switch kind {
        case "album": return "Album"
        case "audiobook": return "Audio Book"
        case "book": return "Book"
        case "ebook": return "E-Book"
        case "feature-movie": return "Movie"
        case "music-video": return "Music Video"
        case "podcast": return "Podcast"
        case "software": return "App"
        case "song": return "Song"
        case "tv-episode": return "TV Episode"
        default: break
        }
        return "Unknown"
    }
    var description: String {
        return "Kind: \(kind ?? "") TrackName: \(name), ArtistName: \(artistName)"
    }
    
}

func <(lhs: SearchResult, rhs: SearchResult) -> Bool {
    return lhs.name.localizedStandardCompare(rhs.name) == .orderedAscending
}
