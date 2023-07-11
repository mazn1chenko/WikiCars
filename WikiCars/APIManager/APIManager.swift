//
//  APIManager.swift
//  WikiCars
//
//  Created by m223 on 01.07.2023.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase

class APIManager {
    
    
    static let shared = APIManager()
    
    private func configureFB() -> Firestore {
        
        var db: Firestore!
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        return db
        
    }
    
    func gettingCarsOfAllBrands(collection: String, docName: String, collection2: String, completion: @escaping ([AllBrandsOfCars]?) -> Void) {
        let db = configureFB()
        let ref = db.collection(collection).document(docName).collection(collection2)
        
        ref.getDocuments { querySnapshot, error in
            guard error == nil else {
                completion(nil)
                print("Error in gettingCarsOfAllBrands: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            var allBrandsOfCars: [AllBrandsOfCars] = []
            
            for document in querySnapshot!.documents {
                let brandName = document.get("brandName") as? String ?? "NoData"
                let descriptionOfBrand = document.get("descriptionOfBrand") as? String ?? "NoData"
                let brand = AllBrandsOfCars(brandName: brandName, descriptionOfBrand: descriptionOfBrand)
                allBrandsOfCars.append(brand)
            }
            
            if !allBrandsOfCars.isEmpty {
                completion(allBrandsOfCars)
            } else {
                completion(nil)
                print("Invalid data format or empty 'All' field")
            }
        }
    }
    
    
    
    
    func getPosts(collection1: String, docName: String, collection2: String, completion: @escaping ([DataCarsModel]) -> Void){
        let db = configureFB()
        let ref = db.collection(collection1).document(docName).collection(collection2)
        
        ref.getDocuments { querySnapshot, error in
            guard error == nil else {
                completion([])
                print("Error in getPosts: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            var dataCars: [DataCarsModel] = []
            
            for document in querySnapshot!.documents {
                let name = document.get("name") as? String ?? "NoData"
                let description = document.get("description") as? String ?? "NoData"
                let data = DataCarsModel(name: name, desription: description)
                dataCars.append(data)
            }
            
            completion(dataCars)
        }
    }
    
    
    func getParticularModelInfo(collection1: String, docName: String, collection2: String, docName2: String, completion: @escaping ([ParticularyCarModel]) -> Void) {
        let db = configureFB()
        let ref = db.collection(collection1).document(docName).collection(collection2).document(docName2)
        
        ref.getDocument { document, error in
            guard error == nil else {
                completion([])
                print("Error in getParticularModelInfo: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            var dataCars: [ParticularyCarModel] = []
            
            let name = document?.get("name") as? String ?? "NoDataAbountName"
            let description = document?.get("description") as? String ?? "NoDataAbountDescription"
            let brand = document?.get("brand") as? String ?? "NoDataAbountBrand"
            let siteOfModel = document?.get("siteOfModel") as? String ?? "NoDataAboutSiteOfModel"
            let data = ParticularyCarModel(name: name, desription: description, brand: brand, siteOfModel: siteOfModel)
            dataCars.append(data)
            
            completion(dataCars)
        }
    }
    
    
    
    
    
    func getImageOfCar(picName: String, completion: @escaping (UIImage) -> Void) {
        let storage = Storage.storage()
        let reference = storage.reference()
        let pathRef = reference.child("imageOfCar")
        
        var image: UIImage = UIImage(named: "mainPage")!
        
        let fileRef = pathRef.child(picName + ".jpeg")
        
        fileRef.getData(maxSize: 1024*1024) { data, error in
            guard error == nil else { completion(image); print("ImageWasNotReceivedInGetImageOfCarFunctionAPIManager"); return }
            image = UIImage(data: data!)!
            completion(image)
        }
        
    }
    
    func gettingImageOfBrands(picName: String, completion: @escaping (UIImage) -> Void) {
        let storage = Storage.storage()
        let reference = storage.reference()
        let pathRef = reference.child("imageOfBrands")
        
        var image: UIImage = UIImage(named: "default")!
        
        let fileRef = pathRef.child(picName + ".png")
        
        fileRef.getData(maxSize: 1024*1024) { data, error in
            guard error == nil else { completion(image); print("ImageWasNotReceivedIngettingImageOfBrandsAPIManager"); return }
            image = UIImage(data: data!)!
            completion(image)
        }
        
    }
    
    func getNews(collection: String, completion: @escaping ([NewsModel]) -> Void) {
        let db = configureFB()
        let ref = db.collection(collection)
        
        ref.getDocuments { querySnapshot, error in
            guard let documents = querySnapshot?.documents, error == nil else {
                completion([])
                print("Error in getNews: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            var news: [NewsModel] = []
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
            
            for document in documents {
                let title = document.get("title") as? String ?? "NoDataAboutTitle"
                let description = document.get("description") as? String ?? "NoDataAboutDescription"
                
                if let timestamp = document.get("date") as? Timestamp {
                    let date = timestamp.dateValue()
                    let dateString = dateFormatter.string(from: date)
                    let data = NewsModel(title: title, description: description, date: dateString)
                    news.append(data)
                } else {
                    let date = "NoDataAboutDate"
                    let data = NewsModel(title: title, description: description, date: date)
                    news.append(data)
                }
            }
            
            completion(news)
        }
    }
}
