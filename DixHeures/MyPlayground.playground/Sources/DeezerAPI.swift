//
//  DeezerAPI.swift
//  DixHeures
//
//  Created by Luc CASIMIR on 2/22/17.
//  Copyright © 2017 Luc CASIMIR. All rights reserved.
//

import Foundation

public protocol DeezerAPiDelegate : class {
    func tracklistLoad()
}

public class DeezerAPI {
    public static let Shared = DeezerAPI()
    private let client = HttpClient()
    private let playlistManager = PlaylistManager()
    public var delegate : DeezerAPiDelegate?
    private var trackLoad = false
    
    public var availableTrack : Bool {
        return trackLoad
    }
    
    private init(){}
    
    public var playlists : [Playlist] {
            return playlistManager.getData
    }
    
    private func trackListNotifier()
    {
        compteur += 1
        if compteur >= nbPlaylist {
            DispatchQueue.main.async {self.delegate?.tracklistLoad();self.trackLoad = true}
        }
    }
    
    private var nbPlaylist = 0
    private var compteur = 0
    
    private func requestTracklist(_ tl:[Playlist])
    {
        nbPlaylist = tl.count
        compteur = 0
        for elem in tl {
            client.requestTrack(elem.tracklistUrl) {
                tracks in
                elem.setAvailable()
                elem.setTrackList(newTrackslist: tracks)
                self.trackListNotifier()
            }
        }
    }

    public func requestUrl(String url: String, callback: @escaping ([Playlist])-> Void)
    {
        trackLoad = false
        client.request(urlString: url) {
            playlist in
            self.playlistManager.addPlaylist(newPlaylist: playlist)
            callback(playlist)
            self.requestTracklist(playlist)
        }
    }
}
