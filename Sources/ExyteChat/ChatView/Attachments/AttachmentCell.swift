//
//  Created by Alex.M on 16.06.2022.
//

import SwiftUI
import AVFoundation

struct AttachmentCell: View {
    
    @Environment(\.chatTheme) private var theme
    
    let attachment: Attachment
    let onTap: (Attachment) -> Void
    
    var body: some View {
        Group {
            if attachment.type == .image {
                content
            } else if attachment.type == .video {
                content
                    .overlay {
                        theme.images.message.playVideo
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 36, height: 36)
                    }
            } else {
                content
                    .overlay {
                        Text("Unknown")
                    }
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            onTap(attachment)
        }
    }
    
    var content: some View {
        AsyncImageView(attachment: attachment)
    }
}

struct AsyncImageView: View {
    
    @Environment(\.chatTheme) var theme
    let attachment: Attachment
    
    var body: some View {
        
        if attachment.type == .video {
            
            VideoThumbnailView(videoURL: attachment.thumbnail)
        } 
        
        else if attachment.type == .image {
            
            CachedAsyncImage(url: attachment.thumbnail, urlCache: .imageCache) { imageView in
                imageView
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ZStack {
                    Rectangle()
                        .foregroundColor(theme.colors.inputLightContextBackground)
                        .frame(minWidth: 100, minHeight: 100)
                    ActivityIndicator(size: 30, showBackground: false)
                }
            }
        }
    }
}

struct VideoThumbnailView: View {
    let videoURL: URL
    @State private var thumbnailImage: UIImage?
    
    var body: some View {
        Group {
            if let thumbnailImage = thumbnailImage {
                Image(uiImage: thumbnailImage)
                    .resizable()
                    .scaledToFill()
                
            } else {
                
                Rectangle()
                    .foregroundColor(.black)
                    .onAppear {
                        generateThumbnailFromVideo(videoURL: videoURL) { image in
                            thumbnailImage = image
                        }
                    }
            }
        }
    }
    
    private func generateThumbnailFromVideo(videoURL: URL, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            let asset = AVAsset(url: videoURL)
            let assetImageGenerator = AVAssetImageGenerator(asset: asset)
            assetImageGenerator.appliesPreferredTrackTransform = true
            
            let time = CMTime(seconds: 1, preferredTimescale: 1)
            do {
                let cgImage = try assetImageGenerator.copyCGImage(at: time, actualTime: nil)
                let image = UIImage(cgImage: cgImage)
                DispatchQueue.main.async {
                    completion(image)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}
