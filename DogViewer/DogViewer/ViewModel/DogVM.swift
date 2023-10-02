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
    
    @Published var dogDetail: DogDetail = DogDetail()
    @Published var dogImage = UIImage()
    @Published var dogBreed: String = ""
    @Published var dogBreedList: [String] = []
    
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
    
    func dogBreed(_ breed: String) -> String {
        let arr = breed.components(separatedBy: "/")
        return arr[arr.count - 2]
    }
    
    static func fetchImageFile(url: URL, completionHandler: @escaping (UIImage?, Error?) -> Void) {
        let imageFetchTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            
            guard let imageFromData = UIImage(data: data) else {
                print("fetchImageFile: UIImage failed")
                return
            }
            completionHandler(imageFromData, nil)
        }
        imageFetchTask.resume()
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
        print("Dog Breed: \(self.dogBreed)")
        guard let url = URL(string: EndPoint.randomBreedUrl(breed.isEmpty ? self.dogBreed: breed).stringValue) else {
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
                dogbreed = self.dogBreed(jsonData.message)
//                self.dogDetail.breed = self.dogBreed(jsonData.message)
            }
            
            DogVM.fetchImageFile(url: imageURL) { image, error in
                guard let image = image else {
                    print("fetchImageFile: image fetch failed")
                    return
                }
                DispatchQueue.main.async { [weak self] in
                    print("Image displayed:::")
                    self?.dogImage = image
                    self?.dogDetail.image = image
                    if breed == nil {
                        self?.dogBreed = dogbreed
                        self?.dogDetail.breed = dogbreed
                    }
                }
            }
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
                self?.dogBreedList = jsonData.message.keys.map { $0 }
                self?.dogBreed = jsonData.message.keys.map { $0 }.first ?? ""
            
                self?.dogDetail.breedList = jsonData.message.keys.map { $0 }
                self?.dogDetail.breed = jsonData.message.keys.map { $0 }.first ?? ""
            }
        }
    }
    
//    func handleImageFileResponse(image: UIImage?, error: Error?) {
//        guard let image = image else {
//            print("fetchImageFile: image fetch failed")
//            return
//        }
//
//        DispatchQueue.main.async { [self] in
//            self.dogImage = image
//            self.dogBreed = dogBreed
//        }
//    }
}
