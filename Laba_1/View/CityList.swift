import SwiftUI
import SwiftData

struct CityList: View {
    @Query var cities: [City]
    
    var body: some View {
        NavigationView {
            List(cities) { city in
                NavigationLink(destination: DetailView(city: city)) {
                    Text(city.name)
                }
            }
            .navigationTitle("Города")
        }
    }
}

#Preview {
    CityList()
        .modelContainer(PreviewSampleData.container)
}
