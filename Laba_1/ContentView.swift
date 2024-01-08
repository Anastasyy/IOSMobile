import SwiftUI
import SwiftData
import YandexMapsMobile

struct ContentView: View {
    @Query var cities: [City]
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        TabView {
            CityList()
            .tabItem {
                Label("Города", systemImage: "building.2")
            }
            MapView()
            .tabItem {
                Label("Map", systemImage: "map")
            }
            FavouriteView()
            .tabItem {
                Label("Favourite", systemImage: "star")
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(PreviewSampleData.container)
}
