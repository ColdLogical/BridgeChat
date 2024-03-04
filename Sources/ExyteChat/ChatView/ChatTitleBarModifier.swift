import SwiftUI

struct ChatTitleBarModifier: ViewModifier {

    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.chatTheme) private var theme
    
    let title: String
    let status: String?
    let cover: URL?
    let avatarData: Data?
    let backHandler: (() -> Void)?
    let callHandler: (() -> Void)?
    let profileHandler: (() -> Void)?
    
    func body(content: Content) -> some View {
        VStack {
            HStack {
                backButton
                infoToolbarItem.onTapGesture(perform: {
                    profileHandler?()
                })
            }
            content
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden()
        .toolbarBackground(.visible)
    }
    
    private var backButton: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
            backHandler?()
        } label: {
            theme.images.backButton
        }
        .padding(.leading, 15)
        .padding(.vertical, 15)
    }
    
    private var infoToolbarItem: some View {
        HStack {
            
            ZStack(alignment: .bottomTrailing) {
                
                
                if let data = self.avatarData {
                    
                    Image(uiImage: UIImage(data: data)!)
                    
                        .resizable()
                        .scaledToFill()
                        .frame(width: 54, height: 54)
                        .clipShape(Circle())
                    
                } else {
                    let firstCharacter = title.first ?? "?"
                    VStack(alignment: .center) {
                        Text(String(firstCharacter))
                            .frame(width: 54, height: 54)
                            .background(theme.colors.grayStatus, in: Circle())
                    }
                }
                
                
                
//                if let url = cover {
//                    CachedAsyncImage(url: url, urlCache: .imageCache) { phase in
//                        switch phase {
//                        case .success(let image):
//                            image
//                                .resizable()
//                                .scaledToFill()
//                        default:
//                            Rectangle().fill(theme.colors.grayStatus)
//                        }
//                    }
//                    .frame(width: 35, height: 35)
//                    .clipShape(Circle())
//                } else {
//                    let firstCharacter = title.first ?? "?"
//                    VStack(alignment: .center) {
//                        Text(String(firstCharacter))
//                            .frame(width: 54, height: 54)
//                            .foregroundColor(Color.black)
//                            .background(theme.colors.grayStatus, in: Circle())
//                    }
//                }
                
                if #available(iOS 17.0, *){
                    
                    Circle()
                        .fill(status == "Online" ? Color.init(hex: "#81D8D0") : Color.init(hex: "#AFAFAF"))
                        .stroke(Color.white, lineWidth: 1)
                        .frame(width: 14, height: 14)
                }
            }
            
            
            VStack(alignment: .leading, spacing: 0) {
                Text(title)
                    .fontWeight(.semibold)
                    .font(.headline)
                    .foregroundColor(theme.colors.textLightContext)
                if let status = status {
                    Text(status)
                        .font(.footnote)
                        .foregroundColor(theme.colors.grayStatus)
                }
            }
            Spacer()
            Button(
                action: {
                    callHandler?()
                },
                label: {
                    Image("Call")
                }
            )
        }
        .padding(.leading, 10)
        .padding(.trailing, 20)
        .padding(.vertical, 15)
    }
}
