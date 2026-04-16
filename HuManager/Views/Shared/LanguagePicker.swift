import SwiftUI

struct LanguagePicker: View {
    @Environment(\.localization) private var lang

    var body: some View {
        Menu {
            ForEach(Language.allCases) { language in
                Button {
                    lang.currentLanguage = language
                } label: {
                    HStack {
                        Text("\(language.flag) \(language.displayName)")
                        if language == lang.currentLanguage {
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
        } label: {
            HStack(spacing: 4) {
                Text(lang.currentLanguage.flag)
                Text(lang.currentLanguage.shortLabel)
                    .font(.caption.bold())
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(.quaternary, in: RoundedRectangle(cornerRadius: 6))
        }
        .menuStyle(.borderlessButton)
        .fixedSize()
    }
}
