import Foundation

public class Playlist{
    let title : String
    let tracklistUrl : String
    let urlImage : String
    let creator : String
    let date : String
    let nbTrack : Int
    var availableTrackList = false
    var tracklist : [Track]
    
    init(Title title:String, Tracklist tracklist:String, UrlImage urlImage:String, Creator creator:String, Date date:String, number nbTrack:Int)
    {
        self.title = title
        self.tracklistUrl = tracklist
        self.urlImage = urlImage
        self.creator = creator
        let format = DateFormatter()
        format.dateFormat = "YYYY-dd-MM HH:mm:ss"
        if let dateCreation = format.date(from: date) {
            format.dateFormat = "[dd-MM-YYYY]"
            self.date = format.string(from: dateCreation)
        }
        else {
            self.date = date
        }
        self.nbTrack = nbTrack
        self.tracklist = [Track]()
    }
    
    func setAvailable(){
        availableTrackList = true
    }
    
    func setTrackList(newTrackslist tl:[Track]){
        tracklist.append(contentsOf: tl)
    }
}
