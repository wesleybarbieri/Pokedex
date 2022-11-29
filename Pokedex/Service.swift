//
//  Service.swift
//  Pokédex
//
//  Created by Wesley Camilo on 08/11/22.
//

import Foundation
import UIKit

class Services {
    
    enum HTTPmethod: String {
        case post
        case get
    }
    
    func request<I: Decodable>(_ urlstring: String, method: HTTPmethod = .get, parameters: [String:Any] = [:], headers: [String:String] = [:], completion: @escaping (_ success: I?,_ error: String?) ->()) {
        
        guard let urlQuery = urlstring.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            var urlComponente = URLComponents(string: urlQuery) else {
            completion(nil, "Erro inesperado")
            return
        }
        
        if method == .get {
            urlComponente.queryItems = []
            for param in parameters {
                urlComponente.queryItems?.append(URLQueryItem(name: param.key, value: "\(param.value)"))
            }
        }
        
        guard let url = urlComponente.url else { return }
        debugPrint(url.absoluteString)
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        var headersDefault: [String: String] = [
            "Content-Type": "application/json"
        ]
        
        headers.forEach { key, value in
            headersDefault[key] = value
        }
        request.allHTTPHeaderFields = headersDefault
        debugPrint("Headers: ", headersDefault)
        
        if parameters.count > 0 && method == .post {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            debugPrint("Parametros: ",parameters)
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let msgError = error {
                DispatchQueue.main.async {
                    completion(nil, msgError.localizedDescription)
                }
                return
            }
            
            if let response = data {
                let debugJson = try? JSONSerialization.jsonObject(with: response, options: JSONSerialization.ReadingOptions.allowFragments)
                debugPrint(debugJson ?? "")
                
                if let object = try? JSONDecoder().decode(I.self, from: response) {
                    DispatchQueue.main.async {
                        completion(object, nil)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(nil, "Erro servidor")
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil, "Erro inesperado")
                }
            }
        }

        task.resume()
    }
    
    func request<I: Decodable, T: Encodable>(_ urlstring: String, method: HTTPmethod = .get, encodable: T?, headers: [String:String] = [:], completion: @escaping (_ success: I?,_ error: String?) ->()) {
        DispatchQueue.main.async {
            guard let urlQuery = urlstring.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                var urlComponente = URLComponents(string: urlQuery) else {
                completion(nil, "Erro inesperado")
                return
            }
            
            if method == .get {
        //            urlComponente.queryItems = []
        //            for param in parameters {
        //                urlComponente.queryItems?.append(URLQueryItem(name: param.key, value: "\(param.value)"))
        //            }
            }
            
            guard let url = urlComponente.url else { return }
            debugPrint(url.absoluteString)
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            
            var headersDefault: [String: String] = [
                "Content-Type": "application/json"
            ]
            headers.forEach { key, value in
                headersDefault[key] = value
            }
            request.allHTTPHeaderFields = headersDefault
            debugPrint("Headers: ", headersDefault)
            
            if let encodable = encodable, method == .post {
                request.httpBody = try? JSONEncoder().encode(encodable)
            }
            
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                if let msgError = error {
                    DispatchQueue.main.async {
                        completion(nil, msgError.localizedDescription)
                    }
                    return
                }
                
                if let response = data {
                    let debugJson = try? JSONSerialization.jsonObject(with: response, options: JSONSerialization.ReadingOptions.allowFragments)
                    debugPrint(debugJson ?? "")
                    
                    if let object = try? JSONDecoder().decode(I.self, from: response) {
                        DispatchQueue.main.async {
                            completion(object, nil)
                        }
                    } else {
                        DispatchQueue.main.async {
                            completion(nil, "Erro servidor")
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(nil, "Erro inesperado")
                    }
                }
            }

            task.resume()
        }
    }
    
    func request(_ urlstring: String, method: HTTPmethod = .get, parameters: [String:Any] = [:], headers: [String:String] = [:], completion: @escaping (_ success: Any?,_ error: String?) ->()) {
        
        guard let urlQuery = urlstring.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: urlQuery) else {
            completion(nil, "Erro inesperado")
            return
        }
        debugPrint(urlQuery)
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if headers.count > 0 {
            request.allHTTPHeaderFields = headers
            debugPrint("Headers: ",headers)
            
        }
        
        if parameters.count > 0 {
            let jsonSerialization = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            request.httpBody = jsonSerialization
            debugPrint("Parametros: ",parameters)
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let msgError = error {
                completion(nil, msgError.localizedDescription)
                return
            }
            
            if let response = data {
                let debugJson = try? JSONSerialization.jsonObject(with: response, options: JSONSerialization.ReadingOptions.allowFragments)
                debugPrint(debugJson ?? "")

                DispatchQueue.main.async {
                    completion(response, nil)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil, "Erro inesperado")
                }
            }
        }

        task.resume()
    }
    
    func carregarImage(_ urlstring: String, completion: @escaping (_ success: UIImage?,_ error: String?) ->()) {
        
        guard let _ = urlstring.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: urlstring) else {
            completion(nil, "Erro inesperado")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPmethod.get.rawValue
        request.cachePolicy = .useProtocolCachePolicy
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let msgError = error {
                DispatchQueue.main.async {
                    completion(nil, msgError.localizedDescription)
                }
                return
            }
            
            if let response = data {
                let image = UIImage.init(data: response)
                DispatchQueue.main.async {
                    completion(image, nil)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil, "Erro inesperado")
                }
            }
        }

        task.resume()
    }
    
    func saveFileLocali(imageName: String, image: UIImage) -> String? {
        
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }

        let fileName = imageName
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 1) else {
            return nil
        }

        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
                print("Removed old image")
            } catch let removeError {
                print("couldn't remove file at path", removeError)
            }
        }

        do {
            try data.write(to: fileURL)
        } catch let error {
            print("error saving file with error", error)
        }
        return fileURL.absoluteString
    }
    
    func uploadFile(imageName: String, image: UIImage) -> URL? {
        guard let urlImage = self.saveFileLocali(imageName: imageName, image: image) else {
            return nil
        }
        let _ = URL(string: urlImage)
        let urlPath = URL(string: "gs://projeto-pi4.appspot.com/")
//        Alamofire.upload(url!, to: urlPath!, method: .post).responseJSON { (response) in
//            print(response)
//        }
        return urlPath
    }
    
}
