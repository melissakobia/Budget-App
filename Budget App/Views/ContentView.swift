//
//  ContentView.swift
//  Budget App
//
//  Created by Sonnie on 24/11/2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @StateObject var budgetViewModel: BudgetViewModel = BudgetViewModel()
    @State var selected: Tabs = .home
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        TabView {
            ForEach (Tabs.allCases, id: \.id) { tab in
                Tab(tab.title, systemImage: tab.icon) {
                  tabView(tab)
                }
                
            }
        }
    }
    
    func tabView(_ selected: Tabs) -> some View {
        switch selected {
        case .home:
            return AnyView(NavigationViewWrapper {
                HomeView().environmentObject(budgetViewModel)
            })
        case .budgets:
            return AnyView(NavigationViewWrapper {
                EmptyView()
            })
        case .reports:
            return AnyView(NavigationViewWrapper {
                EmptyView()
            })
        case .new:
            return AnyView(NavigationStack {
                AddBudgetView().environmentObject(budgetViewModel)
            })
                
            
        case .account:
            return AnyView(NavigationViewWrapper {
                EmptyView()
            })
        }
    }
        
}

enum Tabs: String, CaseIterable, Identifiable {
    case home, budgets, new, reports, account
    
    var id: Self { self }
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .budgets: return "Budgets"
        case .new: return "New"
        case .reports: return "Reports"
        case .account: return "Account"
        }
    }
    
    var icon: String {
        switch self {
        case .home: return "house"
        case .budgets: return "book"
        case .new: return "plus.circle.fill"
        case .reports: return "chart.bar"
        case .account: return "person.crop.circle"
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

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}


//    NavigationViewWrapper {
//        List {
//            ForEach(items) { item in
//                NavigationLink {
//                    Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
//                } label: {
//                    Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
//                }
//            }
//            .onDelete(perform: deleteItems)
//        }
//#if os(macOS)
//        .navigationSplitViewColumnWidth(min: 180, ideal: 200)
//#endif
//        .toolbar {
//#if os(iOS)
//            ToolbarItem(placement: .navigationBarTrailing) {
//                EditButton()
//            }
//#endif
//            ToolbarItem {
//                Button(action: addItem) {
//                    Label("Add Item", systemImage: "plus")
//                }
//            }
//        }
//    }
//}
//
//private func addItem() {
//    withAnimation {
//        let newItem = Item(timestamp: Date())
//        modelContext.insert(newItem)
//    }
//}
//
//private func deleteItems(offsets: IndexSet) {
//    withAnimation {
//        for index in offsets {
//            modelContext.delete(items[index])
//        }
//    }
//}
