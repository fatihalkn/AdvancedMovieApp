import Foundation
import CoreData
import UIKit

class DataManager {
    static let shared = DataManager()
    func saveMovieDetailToCoreData(model: MovieDetail, comletion: @escaping((Result<Void, Error>) -> Void)) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let item = SaveMovie(context: context)
        
        item.orginalTitle = model.originalTitle
        item.id = Int64(model.id!)
        item.overview = model.overview
        item.posterPath = model.posterPath
        item.voteAverage = model.voteAverage ?? 0.0
        item.releaseDate = model.releaseDate
        
        do {
            try context.save()
            comletion(.success(()))
        } catch {
            print(comletion(.failure("failedToSaveData" as! Error)))
        }
    }
    
    func fetchWatchListFromDataBase(completion: @escaping(Result<[SaveMovie],Error>) -> Void ) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return
        }
        let context = appDelegate.persistentContainer.viewContext
        let request: NSFetchRequest<SaveMovie>
        request = SaveMovie.fetchRequest()
        
        do {
            try context.save()
            let movies = try context.fetch(request)
            
            completion(.success(movies))
        } catch {
            completion(.failure("Fail FetchData" as! Error))
        }
    }
    
    
    //MARK: - Delete İtem From LocalStoroge
    
    func deleteWatchListWith(model: SaveMovie, complation: @escaping() -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return
        }
        let context = appDelegate.persistentContainer.viewContext
        context.delete(model)
        
        do {
            try context.save()
            complation()
        } catch {
            
        }
        
    }
    
}


