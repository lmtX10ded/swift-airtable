//
//  ImageViewContainer.swift
//  SuperSmash
//
//  Created by Zack Shapiro on 5/27/20.
//  Copyright © 2020 Zack Shapiro. All rights reserved.
//

import SwiftUI
import Combine

struct ImageViewContainer: View {

    @ObservedObject var remoteImageURL: RemoteImageURL

    init(imageUrl: String) {
        remoteImageURL = RemoteImageURL(imageURL: imageUrl)
    }

    var body: some View {
        Image(uiImage: UIImage(data: remoteImageURL.data) ?? UIImage())
            .resizable()
            .scaledToFit()
            .clipShape(Circle())
            .frame(width: 64, height: 64)
            .foregroundColor(Color(UIColor.secondarySystemFill))
    }
    
}

// MARK: - RemoteImageURL

class RemoteImageURL: ObservableObject {
    
    var didChange = PassthroughSubject<Data, Never>()
    
    @Published var data = Data() {
        didSet {
            didChange.send(data)
        }
    }
    
    init(imageURL: String) {
        guard let url = URL(string: imageURL) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }

            DispatchQueue.main.async { self.data = data }
        }.resume()
    }
    
}
