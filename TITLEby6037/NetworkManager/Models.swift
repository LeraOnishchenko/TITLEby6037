//
//  Models.swift
//  TITLEby6037
//
//  Created by lera on 28.02.2025.
//

import Foundation

struct Question: Decodable{
    let id: Int
    let text: String
    let subText: String?
    let numberOfColumns: Int
    let screenName: String
    let minSelection: Int
    let multiSelect: Bool
    let options: [Answer]
}

struct Answer: Decodable {
    let id: UUID
    let text: String
    let subText: String?
    let image: String?
    let color: String?
    
    init(id: UUID, text: String, subText: String? = nil, image: String? = nil, color: String? = nil) {
        self.id = id
        self.text = text
        self.subText = subText
        self.image = image
        self.color = color
    }
}
