//
//  Search.swift
//  StoreSearch
//
//  Created by Permi on 2018/5/23.
//  Copyright © 2018 Permi. All rights reserved.
//

import Foundation

typealias SearchComplete = (Bool) -> Void

class Search {
    
    enum State {
        case noSearchedYet
        case loading
        case noResult
        case results([SearchResult])
    }
    
    enum Category: Int {
        case all = 0
        case music = 1
        case software = 2
        case ebooks = 3
        
        var type: String {
            switch self {
            case .all:
                return ""
            case .music:
                return "musicTrack"
            case .software:
                return "software"
            case .ebooks:
                return "ebook"
            }
        }
    }
    
    private(set) var state: State = .noSearchedYet
    private var dataTask: URLSessionDataTask? = nil
    
    
    func performSearch(for text: String, category: Category, completion: @escaping SearchComplete) {
        if !text.isEmpty {
            dataTask?.cancel()
            state = .loading
            
            let url = itunesURL(searchText: text, category: category)
            let session = URLSession.shared
            dataTask = session.dataTask(with: url, completionHandler: { (data, response, error) in
                var success = false
                var newState = State.noSearchedYet
                if let error = error as NSError?, error.code == -999 {
                    return
                }
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data {
                    var searchResults = self.parse(data: data)
                    if searchResults.isEmpty {
                        newState = .noResult
                    }else {
                        searchResults.sort(by: <)
                        newState = .results(searchResults)
                    }
                    success = true
                }
                DispatchQueue.main.async {
                    self.state = newState
                    completion(success)
                }
            })
            dataTask?.resume()
        }
    }
    
    private func itunesURL(searchText: String, category: Category) -> URL {
        let encodeText = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let kind = category.type
        let urlStr = String(format: "https://itunes.apple.com/search?term=%@&limit=200&entity=%@", encodeText, kind)
        let url = URL(string: urlStr)
        return url!
    }
    private func parse(data: Data) -> [SearchResult] {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(ResultArray.self, from: data)
            return result.results
        } catch {
            print("JSON Error! \(error.localizedDescription)")
            return []
        }
    }
}
