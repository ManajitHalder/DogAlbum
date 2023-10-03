//
//  DogVM.swift
//  
//  Created by Manajit Halder on 11/08/23 using Swift 5.0 on MacOS 13.4
//  

import Foundation
import UIKit

struct DogDetail {
    var image: UIImage = UIImage()
    var breed: String = ""
    var breedList: [String] = []
}

class DogVM: ObservableObject {

    enum EndPoint {
        case randomDogUrl
        case randomBreedUrl(String)
        case listAllBreeds

        var url: URL {
            return URL(string: self.stringValue)!
        }
        
        var stringValue: String {
            switch self {
            case .randomDogUrl:
                return "https://dog.ceo/api/breeds/image/random"
            case .randomBreedUrl(let breed):
                return "https://dog.ceo/api/breed/\(breed)/images/random"
            case .listAllBreeds:
                return "https://dog.ceo/api/breeds/list/all"
            }
        }
    }
    
    // For caching images locally once the image is fetched by breed.
    static var dogImageCache: [String: UIImage] = [:]
    
    @Published var dogDetail: DogDetail = DogDetail()
    
    /*
     Dog breed url is https://images.dog.ceo/breeds/hound-afghan/n02088094_2738.jpg
     Create an array separated by /.
     Return the last but one element of the array
     
     Approach 1:
     
     if let range = breed.range(of: "breeds/") {
         let dogBreed = breed[range.upperBound...]
         if let index = dogBreed.firstIndex(of: "/") {
             return dogBreed.prefix(upTo: index)
         }
     }
     
     Approach 2:
     
     let arr = breed.components(separatedBy: "/")
     return arr[arr.count - 2]
     */
    
    func getDogBreed(_ breed: String) -> String {
        let arr = breed.components(separatedBy: "/")
        return arr[arr.count - 2]
    }
    
    static func fetchImageFile(url: URL, breed: String?, completionHandler: @escaping (UIImage?, String?, Error?) -> Void) {
        // Use the image if it was cached earlier, otherwise fetch it from the dog.ceo server.
        if let breed = breed, let cachedImage = dogImageCache[breed] {
//                print("fetchImageFile: using cached image")
                completionHandler(cachedImage, breed, nil)
        } else {
            let imageFetchTask = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else {
                    completionHandler(nil, nil, error)
                    return
                }
                
                guard let imageFromData = UIImage(data: data) else {
                    print("fetchImageFile: UIImage failed")
                    return
                }
                if let breed = breed {
                    // Cache the dog image locally so that next fetch uses it from the cache instead of refetching from the dog.ceo server.
                    dogImageCache[breed] = imageFromData
//                    print("fetchImageFile: caching image")
                }
                
                completionHandler(imageFromData, breed, nil)
            }
            imageFetchTask.resume()
        }
    }
        
    static func requestRandomImage(url: URL, completionHandler: @escaping (Dog?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
         
            do {
                let jsonData = try JSONDecoder().decode(Dog.self, from: data)
                completionHandler(jsonData, nil)
            }  catch {
                print("JSONDecoder error, most probably Decodable.Protocol type not matching !!!")
            }
        }
        task.resume()
    }
    
    func fetchDogByBreed(breed: String) {
        print("Dog Breed: \(self.dogDetail.breed)")
        guard let url = URL(string: EndPoint.randomBreedUrl(breed.isEmpty ? self.dogDetail.breed: breed).stringValue) else {
            return
        }
        fetchDog(url: url, breed)
    }
    
    func fetchRandomDog() {
        guard let url = URL(string: EndPoint.randomDogUrl.stringValue) else {
            return
        }
        fetchDog(url: url)
    }
    
    func fetchDog(url: URL, _ breed: String? = nil) {
        DogVM.requestRandomImage(url: url) { [self] jsonData, error in
            guard let jsonData = jsonData else {
                print("Invalid jsonData")
                return
            }
                
            guard let imageURL = URL(string: jsonData.message) else {
                print("Invalid imageURL while fetching image")
                return
            }
            
            var dogbreed: String = ""
            if breed == nil {
                dogbreed = self.getDogBreed(jsonData.message)
            }
            
            DogVM.fetchImageFile(url: imageURL, breed: breed != nil ? breed : dogbreed, completionHandler: handleBreedFetchResponse(image:breedName:error:))
        }
    }
    
    static func requestBreedList(url: URL, completionHandler: @escaping (BreedList?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            
            do {
                let jsonData = try JSONDecoder().decode(BreedList.self, from: data)
                completionHandler(jsonData, nil)
            } catch {
                print("requestBreedList JSONDecoder error, unable to fetch Dog breed list !!!")
            }
        }
        task.resume()
    }
    
    func fetchBreedList() {
        guard let url = URL(string: EndPoint.listAllBreeds.stringValue) else {
            return
        }
        
        DogVM.requestBreedList(url: url) { [self] jsonData, error in
            guard let jsonData = jsonData else {
                print("Invalid JSON data in fetchBreedList")
                return
            }
//            print(jsonData.message.keys.map { $0 })
            
            DispatchQueue.main.async { [weak self] in
                self?.dogDetail.breedList = jsonData.message.keys.map { $0 }
                self?.dogDetail.breed = jsonData.message.keys.map { $0 }.first ?? ""
            }
        }
    }
    
    func handleBreedFetchResponse(image: UIImage?, breedName: String?, error: Error?) {
            guard let image = image else {
                print("handleImageFileResponse: image fetch failed")
                return
            }
    
            guard let breedName = breedName else {
                print("handleImageFileResponse: dog breed nil")
                return
            }
        
            DispatchQueue.main.async { [self] in
                self.dogDetail.image = image
                self.dogDetail.breed = breedName
            }
        }
}
