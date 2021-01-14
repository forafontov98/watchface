//
//  Gif2LiveService.swift
//  WatchFace
//
//  Created by MacBook on 13.01.2021.
//

import UIKit
import Photos
import MobileCoreServices

protocol IGif2LiveService {
    func start(watchFace: WatchFace, callback: @escaping(Gif2LiveStep) -> Void)
}

class Gif2LiveService: NSObject, IGif2LiveService {

    private let client = HttpClient()

    func start(watchFace: WatchFace, callback: @escaping(Gif2LiveStep) -> Void) {
        
        /// 1: загрузка data из сети по url
        callback(.loading)

        fetchData(url: watchFace.url_mini) { (data) in
                    
            callback(.dataToMov(progress: 0, units: 0))

            /// 2: data -> .mov
            self.convertDataToMovie(data: data) { (progress) in
                callback(.dataToMov(progress: Int(progress.completedUnitCount), units: Int(progress.totalUnitCount)))
                
            } finishCallback: { (result) in
                
                callback(.movToLive(progress: 0.0))
                
                switch result {
                case .success(let videoURL):
                    /// 3: .mov -> live photo
                    self.convertMovieToLive(videoURL: videoURL) { (progress) in
                        callback(.movToLive(progress: progress))

                    } finishCallback: { (live, resources) in
                            
                        callback(.done)
                        /// 4: сохранение live photo
                        self.saveToLibrary(resources)
                    }
                        
                default:
                    break
                }
                
            }
        }
        
    }
    
    /* Загрузка Data из сети по url */
    func fetchData(url: String, callback: @escaping(Data) -> Void) {
        client.getData(url: url) { (data) in
            callback(data)
        }
    }
    
    /* Конвертация Data -> .mov */
    func convertDataToMovie(data: Data, _ progressCallback: @escaping ((Progress) -> Void), finishCallback: @escaping (Result<URL, Error>) -> Void) {
        
        VideoGenerator.current.generate(from: data) { (progress) in
            progressCallback(progress)
        } outcome: { (result) in
            finishCallback(result)
        }
    }
    
    /* Конвертация .mov -> live photo */
    func convertMovieToLive(videoURL: URL, _ progressCallback: @escaping (CGFloat) -> Void, finishCallback: @escaping (PHLivePhoto?, LivePhotoResources?) -> Void) {
        
        LivePhoto.generate(from: URL(string: ""), videoURL: videoURL) { (progress) in
            progressCallback(progress)
        } completion: { (live, resources) in
            finishCallback(live, resources)
        }
    }
    
    /* Сохранение live photo в галерею */
    func saveToLibrary(_ resources: LivePhotoResources?) {
        if let resources = resources {
            LivePhoto.saveToLibrary(resources) { (success) in
                
            }
        }
    }
}

enum Gif2LiveStep {
    case loading
    case dataToMov(progress: Int, units: Int)
    case movToLive(progress: CGFloat)
    case done
}
