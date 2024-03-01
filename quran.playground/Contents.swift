import Foundation
struct QuranResponse: Codable {
    let translation_eng: String
    let content: String //arabic
}
enum QuranError: Error {
    case invalidRange
    case networkError(Error)
    case invalidResponse
    case parsingError(Error)
}
func specificVerse(surahNumber: Int, verseNumber: Int) async throws -> QuranResponse {
    let headers = [
        "X-RapidAPI-Key": "05826406d6msh37c7156f2232f2cp1e109fjsn3e5b2d5afdf1",
        "X-RapidAPI-Host": "al-quran1.p.rapidapi.com"
    ]
    let request = NSMutableURLRequest(url: NSURL(string: "https://al-quran1.p.rapidapi.com/\(surahNumber)/\(verseNumber)")! as URL,
                                      cachePolicy: .useProtocolCachePolicy,
                                      timeoutInterval: 10.0)
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers
    let session = URLSession.shared
    let (data, response) = try await session.data(for: request as URLRequest)
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        throw QuranError.invalidRange
    }
    do {
        let decoder = JSONDecoder()
    return try decoder.decode(QuranResponse.self, from: data)
    } catch {
        throw QuranError.parsingError(error)
    }
    return nil
}
    let verse = try await specificVerse(surahNumber: 2, verseNumber: 2)
    print(verse.content)

