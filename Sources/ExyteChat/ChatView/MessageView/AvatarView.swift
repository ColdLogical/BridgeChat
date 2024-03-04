//
//  Created by Alex.M on 07.07.2022.
//

import SwiftUI

struct AvatarView: View {

    let url: URL?
    let avatarSize: CGFloat
    var displayAvatar: UIImage?
    
    var body: some View {
        
            
            if let image = self.displayAvatar{
                
                let image2: Image = Image(uiImage: image)
                
                image2
                    .resizable()
                    .scaledToFill()
                    .viewSize(avatarSize)
//                    .frame(width: 54, height: 54)
                    .clipShape(Circle())
            }
            
//            else{
//                let firstCharacter = group.displayName.first ?? "?"
//                VStack(alignment: .center) {
//                    Text(String(firstCharacter))
//                        .frame(width: 54, height: 54)
//                        .foregroundColor(Color.black)
//                        .background(Color.imageBackground, in: Circle())
//                }
//            }
        
    }

//    var body: some View {
//        CachedAsyncImage(url: url, urlCache: .imageCache) { image in
//            image
//                .resizable()
//                .scaledToFill()
//        } placeholder: {
//            Rectangle().fill(Color.gray)
//        }
//        .viewSize(avatarSize)
//        .clipShape(Circle())
//    }
}

struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView(
            url: URL(string: "https://placeimg.com/640/480/sepia"),
            avatarSize: 32
        )
    }
}
