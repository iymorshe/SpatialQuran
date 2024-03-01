import Foundation
let versesPerChapter = [
    0, 7, 286, 200, 176, 120, 165, 206, 75, 129, 109, 123, 111, 43, 52, 99, 128, 111,
    110, 98, 135, 112, 78, 118, 64, 77, 227, 93, 88, 69, 60, 34, 30, 73, 54, 45,
    83, 182, 88, 75, 85, 54, 53, 89, 59, 37, 35, 38, 29, 18, 45, 60, 49, 62, 55,
    78, 96, 29, 22, 24, 13, 14, 11, 11, 18, 12, 12, 30, 52, 52, 44, 28, 28, 20,
    56, 40, 31, 50, 40, 46, 42, 29, 19, 36, 25, 22, 17, 19, 26, 30, 20, 15, 21,
    11, 8, 8, 19, 5, 8, 8, 11, 11, 8, 3, 9, 5, 4, 7, 3, 6, 3, 5, 4, 5, 6
]
let surahNames = [
    "", "Al-Fatihah", "Al-Baqarah", "Aal-E-Imran", "An-Nisa'", "Al-Ma'idah", "Al-An'am",
    "Al-A'raf", "Al-Anfal", "At-Tawbah", "Yunus", "Hud", "Yusuf", "Ar-Ra'd", "Ibrahim",
    "Al-Hijr", "An-Nahl", "Al-Isra", "Al-Kahf", "Maryam", "Ta-Ha", "Al-Anbiya", "Al-Hajj",
    "Al-Mu'minun", "An-Nur", "Al-Furqan", "Ash-Shu'ara", "An-Naml", "Al-Qasas", "Al-Ankabut",
    "Ar-Rum", "Luqman", "As-Sajda", "Al-Ahzab", "Saba", "Fatir", "Ya-Sin", "As-Saffat",
    "Sad", "Az-Zumar", "Ghafir", "Fussilat", "Ash-Shura", "Az-Zukhruf", "Ad-Dukhan",
    "Al-Jathiyah", "Al-Ahqaf", "Muhammad", "Al-Fath", "Al-Hujurat", "Qaf", "Adh-Dhariyat",
    "At-Tur", "An-Najm", "Al-Qamar", "Ar-Rahman", "Al-Waqi'a", "Al-Hadid", "Al-Mujadila",
    "Al-Hashr", "Al-Mumtahina", "As-Saff", "Al-Jumu'ah", "Al-Munafiqun", "At-Taghabun",
    "At-Talaq", "At-Tahrim", "Al-Mulk", "Al-Qalam", "Al-Haaqqa", "Al-Ma'arij", "Nuh",
    "Al-Jinn", "Al-Muzzammil", "Al-Muddathir", "Al-Qiyama", "Al-Insan", "Al-Mursalat",
    "An-Naba'", "An-Nazi'at", "'Abasa", "At-Takwir", "Al-Infitar", "Al-Mutaffifin",
    "Al-Inshiqaq", "Al-Buruj", "At-Tariq", "Al-A'la", "Al-Ghashiyah", "Al-Fajr",
    "Al-Balad", "Ash-Shams", "Al-Lail", "Ad-Duha", "Ash-Sharh", "At-Tin", "Al-'Alaq",
    "Al-Qadr", "Al-Bayyina", "Az-Zalzala", "Al-'Adiyat", "Al-Qari'a", "At-Takathur",
    "Al-'Asr", "Al-Humaza", "Al-Fil", "Quraish", "Al-Ma'un", "Al-Kawthar", "Al-Kafirun",
    "An-Nasr", "Al-Masad", "Al-Ikhlas", "Al-Falaq", "An-Nas"
]
typealias QuranVerseCompletion = ([String]?) -> Void
struct QuranResponse: Codable {
    let translation_eng: String
    let content: String //arabic
    let verse: Int
    let chapter: Int
    
}
func fetchQuranVerse(start: Int, end: Int, completion: @escaping QuranVerseCompletion) {
    let headers = [
        "X-RapidAPI-Key": "05826406d6msh37c7156f2232f2cp1e109fjsn3e5b2d5afdf1",
        "X-RapidAPI-Host": "al-quran1.p.rapidapi.com"
    ]
    
    // Ensure the start and end are within valid range
    let validStart = max(1, start)
    let validEnd = min(end, 114)
    
    // Select a random chapter within the specified range
    let randomChapter = Int.random(in: start...end)
    let versesInChapter = versesPerChapter[randomChapter]
    let randomVerse = Int.random(in: 1...versesInChapter)
    print("randomChapter: \(randomChapter)")
    print("versesInChapter: \(versesInChapter)")
    print("randomVerse: \(randomVerse)")
    let request = NSMutableURLRequest(url: NSURL(string: "https://al-quran1.p.rapidapi.com/\(randomChapter)/\(randomVerse)")! as URL,
                                      cachePolicy: .useProtocolCachePolicy,
                                      timeoutInterval: 10.0)
    //    let request = NSMutableURLRequest(url: NSURL(string: "https://al-quran1.p.rapidapi.com//1")! as URL,
    //                                      cachePolicy: .useProtocolCachePolicy,
    //                                      timeoutInterval: 10.0)
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers
    
    let session = URLSession.shared
    let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
        var resultList: [String] = []
        
        if let error = error {
            print("Error: \(error)")
            completion(nil)
        } else if let data = data {
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] {
                    if let arabicText = jsonResult["content"] as? String {
                        resultList.append(arabicText)
                    }
                    if let translation = jsonResult["translation_eng"] as? String {
                        resultList.append(translation)
                    }
                    let formattedID = "\(surahNames[randomChapter]) \(randomChapter):\(randomVerse)"
                    resultList.append(formattedID)
                    completion(resultList)
                } else {
                    completion(nil)
                }
            } catch {
                print("JSON Error: \(error)")
                completion(nil)
            }
        }
    }
    dataTask.resume()
}

// ... [Your existing code for versesPerChapter and surahNames] ...
/*func specificVerse(surahNumber: Int, verseNumber: Int) async throws -> QuranResponse {
    let headers = [
        "X-RapidAPI-Key": "05826406d6msh37c7156f2232f2cp1e109fjsn3e5b2d5afdf1",
        "X-RapidAPI-Host": "al-quran1.p.rapidapi.com"
    ]
    let request = NSMutableURLRequest(url: NSURL(string: "https://al-quran1.p.rapidapi.com/\(surahNumber+1)/\(verseNumber)")! as URL,
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
}
*/
enum QuranError: Error {
    case invalidRange
    case networkError(Error)
    case invalidResponse
    case parsingError(Error)
}

func nextQuranVerse(surahNumber: Int, verseNumber: Int, completion: @escaping QuranVerseCompletion) {
    let headers = [
        "X-RapidAPI-Key": "05826406d6msh37c7156f2232f2cp1e109fjsn3e5b2d5afdf1",
        "X-RapidAPI-Host": "al-quran1.p.rapidapi.com"
    ]
    
    // Ensure the surahNumber and verseNumber are within valid range
    guard surahNumber > 0, surahNumber <= versesPerChapter.count,
          verseNumber > 0, verseNumber <= versesPerChapter[surahNumber] else {
        completion(nil)
        return
    }
    
    let request = NSMutableURLRequest(url: NSURL(string: "https://al-quran1.p.rapidapi.com/\(surahNumber+1)/\(verseNumber)")! as URL,
                                      cachePolicy: .useProtocolCachePolicy,
                                      timeoutInterval: 10.0)
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers
    
    let session = URLSession.shared
    let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
        var resultList: [String] = []
        
        if let error = error {
            print("Error: \(error)")
            completion(nil)
        } else if let data = data {
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] {
                    if let arabicText = jsonResult["content"] as? String {
                        resultList.append(arabicText)
                    }
                    if let translation = jsonResult["translation_eng"] as? String {
                        resultList.append(translation)
                    }
                    let formattedID = "\(surahNames[surahNumber]) \(surahNumber):\(verseNumber)"
                    resultList.append(formattedID)
                    completion(resultList)
                } else {
                    completion(nil)
                }
            } catch {
                print("JSON Error: \(error)")
                completion(nil)
            }
        }
    }
    dataTask.resume()
}

func specificQuranVerse(surahNumber: Int, verseNumber: Int, completion: @escaping QuranVerseCompletion) {
    let headers = [
        "X-RapidAPI-Key": "05826406d6msh37c7156f2232f2cp1e109fjsn3e5b2d5afdf1",
        "X-RapidAPI-Host": "al-quran1.p.rapidapi.com"
    ]
    
    // Ensure the surahNumber and verseNumber are within valid range
    guard surahNumber > 0, surahNumber <= versesPerChapter.count,
          verseNumber > 0, verseNumber <= versesPerChapter[surahNumber] else {
        completion(nil)
        return
    }
    
    let request = NSMutableURLRequest(url: NSURL(string: "https://al-quran1.p.rapidapi.com/\(surahNumber)/\(verseNumber)")! as URL,
                                      cachePolicy: .useProtocolCachePolicy,
                                      timeoutInterval: 10.0)
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers
    
    let session = URLSession.shared
    let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
        var resultList: [String] = []
        
        if let error = error {
            print("Error: \(error)")
            completion(nil)
        } else if let data = data {
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] {
                    if let arabicText = jsonResult["content"] as? String {
                        resultList.append(arabicText)
                    }
                    if let translation = jsonResult["translation_eng"] as? String {
                        resultList.append(translation)
                    }
                    let formattedID = "\(surahNames[surahNumber]) \(surahNumber):\(verseNumber)"
                    resultList.append(formattedID)
                    completion(resultList)
                } else {
                    completion(nil)
                }
            } catch {
                print("JSON Error: \(error)")
                completion(nil)
            }
        }
    }
    dataTask.resume()
}
