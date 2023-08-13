import Foundation

class SongFetcher {
    private let port =  "49.213.238.75:8002"

//    "127.0.0.1:8002"

    func fetchSong(artist: String?, music_ID: String?, completion: @escaping (Result<URL, Error>) -> Void) {
        
//        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//        let fileURL = documentsDirectory.appendingPathComponent("\(musicID).mp3")
//        FileManager.default.fileExists(atPath: fileURL.path)
//
        let url = makeSafeURL(from:"http://\(port)/api/songs/\(artist!)/\(music_ID!)/")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                let error = NSError(domain: "SongFetcher", code: -1, userInfo: nil)
                completion(.failure(error))
                return
            }
            if let fileURL = self.saveSongData( music_ID: music_ID, data) {
                completion(.success(fileURL))
            } else {
                let error = NSError(domain: "SongFetcher", code: -1, userInfo: nil)
                completion(.failure(error))
            }
        }

        task.resume()
    }

    private func saveSongData(music_ID: String?, _ data: Data) -> URL? {
        let tempDirectory = FileManager.default.temporaryDirectory
        let fileURL = tempDirectory.appendingPathComponent("\(music_ID!).mp3")
        do {
            try data.write(to: fileURL)
            return fileURL
        } catch {
            print("Error saving song data:", error)
            return nil
        }
    }
    
    func fetchImage(artist: String?, music_ID: String?, completion: @escaping (Result<URL, Error>) -> Void) {
        let imageUrl = URL(string:"http://\(port)/api/img/\(artist!)/\(music_ID!)/")!
        let task = URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                let error = NSError(domain: "SongFetcher", code: -1, userInfo: nil)
                completion(.failure(error))
                return
            }

            if let fileURL = self.saveImageData(music_ID: music_ID, data) {
                completion(.success(fileURL))
            } else {
                let error = NSError(domain: "SongFetcher", code: -1, userInfo: nil)
                completion(.failure(error))
            }
        }

        task.resume()
    }

    private func saveImageData(music_ID: String?, _ data: Data) -> URL? {
        let tempDirectory = FileManager.default.temporaryDirectory
        let fileURL = tempDirectory.appendingPathComponent("\(music_ID!).jpg")
        do {
            try data.write(to: fileURL)
            return fileURL
        } catch {
            print("Error saving image data:", error)
            return nil
        }
    }
}
