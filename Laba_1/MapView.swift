import SwiftUI
import SwiftData

struct MapView: View {
    @Query var cities: [City]
    @StateObject var locationManager = LocationManager()
    @State private var showBottomSheet = false
    @State private var action: Int? = 0
    @State private var isLoading: Bool = false
    @ObservedObject private var selectedCityPublisher = SelectedCityPublisher.shared
    
    var yandexMapView = YandexMapView()
    let heights = stride(from: 0.4, through: 0.4, by: 0.1).map { PresentationDetent.fraction($0) }
    
    var body: some View {
            NavigationView {
                ZStack {
                    if let city = selectedCityPublisher.selectedCity {
                        NavigationLink(destination: DetailView(city: city), tag: 1, selection: $action) {
                            EmptyView()
                        }
                    }
                    
                    YandexMapView()
                        .environmentObject(locationManager)
                        .onChange(of: selectedCityPublisher.selectedCity) { newCity in
                            if newCity != nil {
                                showBottomSheet = true
                            }
                        }
                }
                .sheet(isPresented: Binding<Bool>(
                       get: { self.showBottomSheet },
                       set: { newValue in
                           self.showBottomSheet = newValue
                       }
                   )) {
                    VStack(alignment: .leading) {
                        if let city = selectedCityPublisher.selectedCity {
                            Image(city.assetName)
                                .resizable()
                                .frame(height: 200)
                            
                            Text(city.name)
                                .font(.title)
                                .padding(.horizontal)
                            
                            Spacer()
                            
                            GeometryReader { geometry in
                                HStack {
                                    Button(action: {
                                        YandexMapController.shared.cleanMap()
                                        YandexMapController.shared.setupPlacemarks(cities: cities)
                                        YandexMapController.shared.buildDirections(to: city, onStart: {
                                            isLoading = true
                                        }, onCompletion: {
                                            isLoading = false
                                        }, onFail: {
                                            isLoading = false
                                        })
                                    }, label: {
                                        HStack {
                                            if isLoading {
                                                ProgressView()
                                                    .progressViewStyle(CircularProgressViewStyle())
                                                    .zIndex(1)
                                            }
                                            Text("Построить маршрут")
                                                .frame(width: geometry.size.width * 0.5, height: 50)
                                                .background(Color.blue)
                                                .foregroundColor(.white)
                                                .cornerRadius(10)
                                        }
                                    })
                                    
                                    Spacer()
                                    Button(action: {
                                        showBottomSheet.toggle()
                                        self.action = 1
                                    }, label: {
                                        Text("Информация")
                                            .frame(width: geometry.size.width * 0.5, height: 50)
                                            .background(Color(UIColor.systemGroupedBackground))
                                            .cornerRadius(10)
                                    })
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .presentationDetents(Set(heights))
                   } .edgesIgnoringSafeArea([.top])
            }
        }
}

#Preview {
    ZStack {
        TabView {
            MapView()
                .environmentObject(SelectedCityPublisher.shared)
                .tabItem {
                    Text("#123123")
                }
        }
    }
}
