//
//  DPodcast+CoreDataClass.swift
//  PodcastsApp
//
//  Created by Tiara H on 29/10/22.
//
//

import Foundation
import CoreData


public class DPodcast: NSManagedObject {
    
    // func to save object into Core Data
    class func save(_ podcast: Podcast, at context: NSManagedObjectContext) {
        let request: NSFetchRequest<DPodcast> = DPodcast.fetchRequest()
        request.predicate = NSPredicate(format: "trackId_ = \(podcast.trackId)")
        
        let entity: DPodcast
        if let dPodcast = try? context.fetch(request).first {
            entity = dPodcast
        } else {
            let dPodcast = NSEntityDescription.entity(forEntityName: "DPodcast", in: context)!
            entity = NSManagedObject(entity: dPodcast, insertInto: context) as! DPodcast
        }
        
        entity.trackId_ = Int64(podcast.trackId)
        entity.trackName = podcast.trackName
        entity.trackCount_ = Int16(podcast.trackCount)
        entity.artistsName = podcast.artistName
        entity.artwork = podcast.artworkUrl600
        entity.feedUrl = podcast.feedUrl
        entity.isFavorited = true
        
        try? context.save()
        
    }
    
    // func to catch all the Podcast data
    class func fetch(in context: NSManagedObjectContext) -> [Podcast] {
        let request: NSFetchRequest<DPodcast> = DPodcast.fetchRequest()
        request.predicate = NSPredicate(format: "isFavorited = \(true)")
        let podcasts = (try? context.fetch(request)) ?? []
        return podcasts //.sorted { $0.trackId < $1.trackId }
    }
    
    // func to fetch track ID that had been favorite
    class func fetch(trackID: Int, at context: NSManagedObjectContext) -> Podcast? {
        let request: NSFetchRequest<DPodcast> = DPodcast.fetchRequest()
        request.predicate = NSPredicate(format: "trackId_ = \(trackID) AND isFavorited = \(true)")
        return try? context.fetch(request).first
    }
    
    // func to delete the entity
    class func delete(trackId: Int, at context: NSManagedObjectContext) {
        if let entity = DPodcast.fetch(trackID: trackId, at: context) as? DPodcast {
//            context.delete(entity as! NSManagedObject)
            entity.isFavorited = false
            
            try? context.save()
        }
    }
}

// implement protocol to help return Podcast
extension DPodcast: Podcast {
    var trackId: Int {
        return Int(trackId_)
    }
    
    var trackCount: Int {
        return Int(trackCount_)
    }
    
    var artistName: String {
        return artistsName
    }
    
    var artworkUrl600: String {
        return artwork
    }
    
}
