//
//  NetworkManager.swift
//  OfficeHour
//
//  Created by Charlotte Ding on 5/5/22.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let host = "http://34.130.167.204"
    
    
    // get all subjects (DONE)
    static func getAllSubjects(completion: @escaping ([Subject]) -> Void) {
        let endpoint = "\(host)/api/subjects/"
        AF.request(endpoint, method: .get).validate().responseData { response in
            switch (response.result) {
            case.success(let data):
                let jsonDecoder = JSONDecoder()
                if let userResponse = try? jsonDecoder.decode(Subjects.self, from: data) {
                    completion(userResponse.subjects)
                } else {
                    print("Failed to decode getAllSubjects")
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // create a user <TODO> make response just a user, remove authentication stuff
    static func createUser(username: String, name: String, bio: String, price: Int, subjects: [String], isAvailable: Bool, password: String, completion: @escaping (Person) -> Void) {
        let endpoint = "\(host)/api/users/"
        let params: [String : Any] = [
            "username": username,
            "name": name,
            "bio": bio,
            "price": price,
            "subjects": subjects,
            "isAvailable": isAvailable,
            "password": password
        ]
        AF.request(endpoint, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseData { response in
            switch (response.result) {
            case.success(let data):
                let jsonDecoder = JSONDecoder()
                if let userResponse = try? jsonDecoder.decode(Person.self, from: data) {
                    completion(userResponse)
                } else {
                    print("Failed to decode createUser")
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // get a user by id
    static func getUser(id: Int, completion: @escaping (Person) -> Void) {
        let endpoint = "\(host)/api/users/\(id)/"
        AF.request(endpoint, method: .get).validate().responseData { response in
            switch (response.result) {
            case.success(let data):
                debugPrint(response)
                let jsonDecoder = JSONDecoder()
                if let userResponse = try? jsonDecoder.decode(Person.self, from: data) {
                    completion(userResponse)
                } else {
                    print("Failed to decode getUser")
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // edit a user
    static func editUser(id: Int, username: String, name: String, bio: String, price: Int, subjects: [String], isAvailable: Bool, completion: @escaping (Person) -> Void) {
        let endpoint = "\(host)/api/users/\(id)/"
        let params: [String : Any] = [
            "username": username,
            "name": name,
            "bio": bio,
            "price": price,
            "subjects": subjects,
            "isAvailable": isAvailable
        ]
        AF.request(endpoint, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseData { response in
            switch (response.result) {
            case.success(let data):
                let jsonDecoder = JSONDecoder()
                if let userResponse = try? jsonDecoder.decode(Person.self, from: data) {
                    completion(userResponse)
                } else {
                    print("Failed to decode editUser")
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // get all tutors by subject
    static func getAllTutors(subjectId: Int, completion: @escaping ([Person]) -> Void) {
        let endpoint = "\(host)/api/subjects/\(subjectId)/users/"
        AF.request(endpoint, method: .get).validate().responseData { response in
            switch (response.result) {
            case.success(let data):
                // print(String(data: data, encoding: .utf8))
                let jsonDecoder = JSONDecoder()
                if let userResponse = try? jsonDecoder.decode([Person].self, from: data) {
                    completion(userResponse)
                } else {
                    print("Failed to decode getAllTutors")
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // delete a user
    static func deleteUser(id: Int, completion: @escaping (Person) -> Void) {
        let endpoint = "\(host)/api/users/\(id)/"
        AF.request(endpoint, method: .delete).validate().responseData { response in
            switch (response.result) {
            case.success(let data):
                let jsonDecoder = JSONDecoder()
                if let userResponse = try? jsonDecoder.decode(Person.self, from: data) {
                    completion(userResponse)
                    print(userResponse)
                } else {
                    print("Failed to decode deleteUser")
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // create a request (user requests tutor)
    static func createRequest(senderId: Int, receiverId: Int, completion: @escaping (Request) -> Void) {
        let endpoint = "\(host)/api/transactions/"
        let params: [String : Int] = [
            "sender_id": senderId,
            "receiver_id": receiverId
        ]
        AF.request(endpoint, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseData { response in
            switch (response.result) {
            case.success(let data):
                let jsonDecoder = JSONDecoder()
                if let userResponse = try? jsonDecoder.decode(Request.self, from: data) {
                    completion(userResponse)
                } else {
                    print("Failed to decode createPost")
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // login request
    static func login(username: String, password: String, completion: @escaping (LoginId) -> Void) {
        let endpoint = "\(host)/api/simplelogin/"
        let params: [String : Any] = [
            "username": username,
            "password": password
        ]
        AF.request(endpoint, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseData { response in
            switch (response.result) {
            case.success(let data):
                let jsonDecoder = JSONDecoder()
                if let userResponse = try? jsonDecoder.decode(LoginId.self, from: data) {
                    completion(userResponse)
                } else {
                    print("Failed to decode login")
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
