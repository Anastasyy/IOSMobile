import SwiftUI
import SwiftData

struct FavouriteView: View {
    @Query var cities: [City]
    
    var body: some View {
        NavigationView {
            List(cities.filter { $0.isFavorite }) { city in
                NavigationLink(destination: DetailView(city: city)) {
                    Text(city.name)
                }
            }
            .navigationTitle("Избранное")
        }
    }
}

#Preview {
    FavouriteView()
        .modelContainer(PreviewSampleData.container)
}
