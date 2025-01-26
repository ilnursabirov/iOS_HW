//
//  Post.swift
//  HW_02
//
//  Created by Сабиров Мльнур Марсович on 25.12.2024.
//

import Foundation
import UIKit

struct Post: Hashable {
    let id: UUID
    var text: String?
    var images: [UIImage]
    let date: Date

    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        return formatter.string(from: date)
    }
}
