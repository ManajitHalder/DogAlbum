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

class DogVM: ObservableObject {
    enum EndPoint: String {
        case randomDogUrl = "https://dog.ceo/api/breeds/image/random"
        case breedUrl = "https://dog.ceo/api/breeds/image/randoms"
        
        var url: URL {
            URL(string: DogVM.EndPoint.randomDogUrl.rawValue)!
        }
    }
    
    @Published var dog: [Dog] = []
    @Published var dogImage = UIImage()
    @Published var dogBreed: String = ""
    
    func dogBreed(_ breed: String) -> String.SubSequence {
        if let range = breed.range(of: "breeds/") {
            let dogBreed = breed[range.upperBound...]
            if let index = dogBreed.firstIndex(of: "/") {
                return dogBreed.prefix(upTo: index)
            }
        }
        
        return ""
    }
    
    func fetchDog() {
        guard let url = URL(string: EndPoint.randomDogUrl.rawValue) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data else {
                return
            }
            
//            do {
//                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
//                guard let url = json["message"] else {
//                    print("Invalid url")
//                    return
//                }
//                print(url)
//            } catch {
//                print("JSONSerialization error \(error)")
//            }
           
            do {
                let jsonData = try JSONDecoder().decode(Dog.self, from: data)
                print(jsonData.message)
                
                guard let imageURL = URL(string: jsonData.message) else {
                    print("Invalid imageURL while fetching image")
                    return
                }
                
                let dogbreed = self?.dogBreed(jsonData.message)
            
                let imageFetchTask = URLSession.shared.dataTask(with: imageURL) { data, response, error in
                    guard let data = data else {
                        return
                    }
                    
                    guard let imageFromData = UIImage(data: data) else {
                        print("UIImage failed")
                        return
                    }
                    
                   
                    DispatchQueue.main.async {
                        self?.dogImage = imageFromData
                        if let dogbreed = dogbreed {
                            self?.dogBreed = String(dogbreed)
                        }
                    }
                }
                imageFetchTask.resume()
                
            } catch {
                print("JSONDecoder error, most probably Decodable.Protocol type not matching !!!")
            }
            
        }
        task.resume()
    }
}
