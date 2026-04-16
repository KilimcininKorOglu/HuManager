import SwiftUI

struct SidebarView: View {
    @Binding var selectedTab: SidebarTab
    @Environment(\.localization) private var lang

    var body: some View {
        List(SidebarTab.allCases, selection: $selectedTab) { tab in
            Label(tab.displayName(lang), systemImage: tab.icon)
                .tag(tab)
        }
        .listStyle(.sidebar)
        .navigationSplitViewColumnWidth(min: 180, ideal: 200)
    }
}
