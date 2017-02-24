import Foundation

public class PlaylistManager {
    private var data = [Playlist]()
    
    public var count : Int {
        return data.count
    }
    
    public var getData : [Playlist] {
        return self.data
    }
    
    public func addPlaylist(newPlaylist playlist:[Playlist])
    {
        data.removeAll()
        data.append(contentsOf: playlist)
    }
    
    public subscript(index: Int) -> Playlist {
        get {
           return data[index]
        }
        set{
            data.insert(newValue, at: index)
        }
    }
}
