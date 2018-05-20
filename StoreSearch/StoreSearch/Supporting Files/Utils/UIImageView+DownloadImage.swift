//
//  UIImageView+DownloadImage.swift
//  StoreSearch
//
//  Created by Permi on 2018/5/20.
//  Copyright © 2018 Permi. All rights reserved.
//

import UIKit

extension UIImageView {
    func loadImage(url: URL) -> URLSessionDownloadTask {
        let urlSession = URLSession.shared
        let downloadTask = urlSession.downloadTask(with: url) { [weak self] (url, response, error) in
            if error == nil, let url = url, let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    if let weakSelf = self {
                        weakSelf.image = image
                    }
                }
            }
        }
        downloadTask.resume()
        return downloadTask
    }
}
