import SwiftUI

struct ChatTitleBarModifier: ViewModifier {

    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.chatTheme) private var theme
    
    let title: String
    let status: String?
    let cover: URL?
    let backHandler: (() -> Void)?
    let callHandler: (() -> Void)?
    
    func body(content: Content) -> some View {
        VStack {
            HStack {
                backButton
                infoToolbarItem
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
            if let url = cover {
                CachedAsyncImage(url: url, urlCache: .imageCache) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    default:
                        Rectangle().fill(theme.colors.grayStatus)
                    }
                }
                .frame(width: 35, height: 35)
                .clipShape(Circle())
            } else {
                let firstCharacter = title.first ?? "?"
                VStack(alignment: .center) {
                    Text(String(firstCharacter))
                        .frame(width: 54, height: 54)
                        .foregroundColor(Color.black)
                        .background(theme.colors.grayStatus, in: Circle())
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
