import CoreData
import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var budgetViewModel: BudgetViewModel

    var body: some View {
        TabView(selection: $budgetViewModel.selectedTab) {
            ForEach(Tabs.allCases) { tab in
                tabView(tab)
                    .tabItem {
                        if tab == .new {
                            Image("Icons/NewTab")
                                .renderingMode(.original)
                        } else {
                            Image(systemName: tab.icon)
                        }
                        if tab != .new {
                            Text(tab.title)
                        }
                    }
                    .tag(tab)
            }
        }
    }

    @ViewBuilder
    private func tabView(_ selected: Tabs) -> some View {
        switch selected {
        case .home:
            NavigationViewWrapper {
                HomeView()
            }
        case .budgets:
            NavigationViewWrapper {
                placeholderView("Budgets")
            }
        case .reports:
            NavigationViewWrapper {
                placeholderView("Reports")
            }
        case .account:
            NavigationViewWrapper {
                placeholderView("Account")
            }
        case .new:
            NavigationStack {
                AddBudgetView()
            }
        }
    }

    private func placeholderView(_ title: String) -> some View {
        Text(title)
            .font(.bold(22))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.backgroundLight)
    }
}

enum Tabs: String, CaseIterable, Identifiable, Hashable {
    case home, budgets, new, reports, account
    var id: Self { self }

    var title: String {
        switch self {
        case .home: "Home"
        case .budgets: "Budgets"
        case .new: "New"
        case .reports: "Reports"
        case .account: "Account"
        }
    }

    var icon: String {
        switch self {
        case .home: "house"
        case .budgets: "square.grid.2x2"
        case .new: "plus.circle.fill"
        case .reports: "chart.bar"
        case .account: "person"
        }
    }
}

fileprivate struct NavigationViewWrapper<Content: View>: View {
    let content: () -> Content

    var body: some View {
#if os(macOS)
        NavigationSplitView {
            content()
        } detail: {
            Text("Select an item")
        }
#else
        content()
#endif
    }
}
