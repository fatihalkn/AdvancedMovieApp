//
//  SaveMovie+CoreDataProperties.swift
//  AdvancedMovieApp
//
//  Created by Fatih on 20.01.2024.
//
//

import Foundation
import CoreData


extension SaveMovie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SaveMovie> {
        return NSFetchRequest<SaveMovie>(entityName: "SaveMovie")
    }

    @NSManaged public var backdropPath: String?
    @NSManaged public var id: Int64
    @NSManaged public var orginalTitle: String?
    @NSManaged public var overview: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var voteAverage: Double

}

extension SaveMovie : Identifiable {

}
