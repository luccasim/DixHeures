import Foundation

public class HttpClient {

    public func requestTrack(_ tracks: String, callback: @escaping ([Track]) -> Void)
    {
        if let url = URL(string: tracks){
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: request){
                data, response, error in
                if let d = data {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                            var res = [Track]()
                            if let track = json["data"] as? [NSDictionary]{
                                for elem in track {
                                    let title = elem["title"] as? String ?? "@NoValue"
                                    let link = elem["link"] as? String ?? "@NoValue"
                                    res.append(Track(Name: title, Url: link))
                                }
                                callback(res)
                            }
                        }
                    }
                    catch let err {
                        print(err)
                    }
                }
            }
            task.resume()
        }
    }
    
    public func request(urlString add: String, callback: @escaping ([Playlist]) -> Void)
    {
        if let url = URL(string: add) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: request)
            {
                data, response, error in
                if let d = data
                {
                    do
                    {
                        if let json = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                        {
                            var res = [Playlist]()
                            if let data = json["data"] as? [NSDictionary] {
                                for elem in data {
                                    let title = elem["title"] as? String ?? "@NoValue"
                                    let tracklist = elem["tracklist"] as? String ?? "@NoValue"
                                    let imageURl = elem["picture"] as? String ?? "@NoValue"
                                    let nb_track = elem["nb_tracks"] as? Int ?? -1
                                    let creationDate = elem["creation_date"] as? String ?? "@NoValue"
                                    var creator = "unknow"
                                    if let owner = elem["creator"] as? NSDictionary{
                                        creator = owner["name"] as? String ?? "@Novalue"
                                    }
                                    let newPlaylist = Playlist(Title: title, Tracklist: tracklist, UrlImage: imageURl, Creator: creator, Date: creationDate, number: nb_track)
                                    res.append(newPlaylist)
                                }
                                DispatchQueue.main.async {callback(res)}
                            }
                        }
                    }
                    catch let err {print(err)}
                }
            }
            task.resume()
        }
    }
}
