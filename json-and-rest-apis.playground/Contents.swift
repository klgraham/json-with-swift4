// Playground for exploring APIs

import Foundation

struct Owner: Codable {
    var login: String
    var url: String
}

struct Repository: Codable {
    var name: String
    var full_name: String
    var owner: Owner
    var url: String
    var stargazers_count: Int
    var language: String
}

struct GithubResponse: Codable {
    var total_count: Int
    var incomplete_results: Bool
    var items: [Repository]
}

struct GHReposForLanguage {
    private let baseUrl = "https://api.github.com/search/repositories"
    private let starsQuery = "sort=stars&order=desc"
    let language: String
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    init(language: String) {
        self.language = language
    }
    
    var url: String {
        return "\(baseUrl)?q=language:\(language)&\(starsQuery)"
    }
    
    func getMostStarredRepos(maxCount: Int) -> ArraySlice<Repository>? {
        if let queryUrl = URL(string: self.url) {
            if let data = try? Data(contentsOf: queryUrl) {
                if let response = try? decoder.decode(GithubResponse.self, from: data) {
                    return response.items[0..<maxCount]
                }
            }
        }
        
        return nil
    }
}

func printTopRepos(of language: String, maxCount: Int = 10) {
    let query = GHReposForLanguage(language: language)
    if let topRepos = query.getMostStarredRepos(maxCount: 10) {
        print("Language: \(language)\n")
        for repo in topRepos {
            print(repo.name)
        }
        print("\n")
    }
}

printTopRepos(of: "clojure")
printTopRepos(of: "swift")
printTopRepos(of: "scala")
