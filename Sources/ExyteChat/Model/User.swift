//
//  Created by Alex.M on 17.06.2022.
//

import Foundation
import UIKit

public struct User: Codable, Identifiable, Hashable {
    
    public let id: String
    public let name: String
    public let avatarURL: URL?
    public let isCurrentUser: Bool
    public let avatarImageData: Data?

    public init(id: String, name: String, avatarURL: URL?, isCurrentUser: Bool, avatarImageData: Data?) {
        self.id = id
        self.name = name
        self.avatarURL = avatarURL
        self.isCurrentUser = isCurrentUser
        self.avatarImageData = avatarImageData
    }
}
