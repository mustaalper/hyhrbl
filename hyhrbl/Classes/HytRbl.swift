//
//  HytRbl.swift
//  hyhrbl
//
//  Created by MAA on 29.06.2022.
//

import Foundation
import UIKit

public class UrlConverter {
    
    public init() { }
    
    public static func getImg(image: UIImageView, url: String) {
        image.load(urlString: url)
    }
    //
    public static func getData(urlString: String) {
        
        let task = URLSession.shared.dataTask(with: URL(string: urlString)!) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let _ = response else { return }
            
            guard let data = data else { return }
            
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    print(jsonResult)
                }
            } catch let catchError {
                print(catchError)
            }
        };task.resume()
    }
    
}

extension UIImageView {
    func load(urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
