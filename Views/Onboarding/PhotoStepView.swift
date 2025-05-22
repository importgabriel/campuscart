import SwiftUI
import PhotosUI

struct PhotoStepView: View {
    @Binding var image: UIImage?
    let onNext: () -> Void
    @State private var pickerItem: PhotosPickerItem?

    var body: some View {
        VStack(spacing: 20) {
            Text("Add a profile photo")
                .font(.headline)

            if let uiImage = image {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .clipShape(Circle())
            } else {
                Circle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 200, height: 200)
                    .overlay(Text("No Photo"))
            }

            PhotosPicker(
                selection: $pickerItem,
                matching: .images,
                photoLibrary: .shared()
            ) {
                Text("Select from Library")
            }
            // iOS 17+ two-parameter onChange:
            .onChange(of: pickerItem) { oldItem, newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self),
                       let uiImage = UIImage(data: data) {
                        image = uiImage
                    }
                }
            }

            Button("Finish") {
                onNext()
            }
            .disabled(image == nil)
            .buttonStyle(.borderedProminent)
        }
    }
}

