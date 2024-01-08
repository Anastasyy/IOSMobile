import SwiftUI
import SwiftData

struct CityList: View {
    @Query var cities: [City]
   
    
    var body: some View {
        NavigationView {
            List(cities) { city in
                NavigationLink(destination: DetailView(city: city)) {
                  
                    Text(city.name)
                        .foregroundColor(.black)
                        .font(.headline)
                        .padding(.vertical, 12)
                        
                }
            }
            .listStyle(.plain)
            .navigationTitle("Города")
            .navigationBarTitleDisplayMode(.large)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [.gray, .brown, .brown]), startPoint: .top, endPoint: .bottom)
                                .edgesIgnoringSafeArea(.all)
                        )
        }
        .accentColor(.white)
    }
}

#Preview {
    CityList()
        .modelContainer(PreviewSampleData.container)
}
