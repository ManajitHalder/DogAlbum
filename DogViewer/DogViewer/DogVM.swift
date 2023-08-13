//
//  DogVM.swift
//  
//  Created by Manajit Halder on 11/08/23 using Swift 5.0 on MacOS 13.4
//  

import Foundation
import UIKit

struct Dog: Codable {
    let status: String
    let message: String
}

struct DogDetail {
    let image: UIImage
    let breed: String
}

class DogVM: ObservableObject {
    enum EndPoint: String {
        case randomDogUrl = "https://dog.ceo/api/breeds/image/random"
        case breedUrl = "https://dog.ceo/api/breeds/image/randoms"
        
        var url: URL {
            URL(string: DogVM.EndPoint.randomDogUrl.rawValue)!
        }
    }
    
//    @Published var dog: [Dog] = []
//    @Published var dogDetail: DogDetail
    @Published var dogImage = UIImage()
    @Published var dogBreed: String = ""
    
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
                print("UIImage failed")
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
    
    func fetchDog() {
        guard let url = URL(string: EndPoint.randomDogUrl.rawValue) else {
            return
        }
       
        DogVM.requestRandomImage(url: url) { jsonData, error in
            guard let jsonData = jsonData else {
                print("Invalid jsonData")
                return
            }
                
            guard let imageURL = URL(string: jsonData.message) else {
                print("Invalid imageURL while fetching image")
                return
            }
            
            let dogbreed = self.dogBreed(jsonData.message)
        
            DogVM.fetchImageFile(url: imageURL) { image, error in
                guard let image = image else {
                    print("fetchImageFile: image fetch failed")
                    return
                }
                DispatchQueue.main.async {
                    self.dogImage = image
                    self.dogBreed = dogbreed
                }
            }
            
        }
    }
    
    func handleImageFileResponse(image: UIImage?, error: Error?) {
        guard let image = image else {
            print("fetchImageFile: image fetch failed")
            return
        }
        
        DispatchQueue.main.async { [self] in
            self.dogImage = image
            self.dogBreed = dogBreed
        }
    }
}
