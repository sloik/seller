//system
import SwiftUI

public struct TabBarIcon: View {
    private let imageName: String
    private let titleName: String

    public init(imageName: String, titleName: String) {
        self.imageName = imageName
        self.titleName = titleName
    }

    public var body: some View {
        VStack(spacing: 0) {
            Image(imageName)
                .padding(.bottom, 10)
            Text(titleName)
                .design(typography: .label(weight: .regular, size: 12))
        }
    }
}
