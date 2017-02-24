import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

let api = DeezerAPI.Shared

api.requestUrl(String: "http://api.deezer.com/user/5/playlists"){
    playlist in
    for elem in playlist{
        print(elem)
    }
}