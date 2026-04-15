import SwiftUI

struct SidebarView: View {
    @Binding var selectedTab: SidebarTab

    var body: some View {
        List(SidebarTab.allCases, selection: $selectedTab) { tab in
            Label(tab.rawValue, systemImage: tab.icon)
                .tag(tab)
        }
        .listStyle(.sidebar)
        .navigationSplitViewColumnWidth(min: 180, ideal: 200)
    }
}
