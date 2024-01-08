import SwiftUI
import SwiftData

struct DetailView: View {
    var city: City
    
    @Environment(\.modelContext) private var modelContext
    @State private var isFavorite: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                GeometryReader { geometry in
                    let minY = geometry.frame(in: .global).minY
                    let height = geometry.size.height
                    let opacity = max(0, min(1, 1 + minY / height))
                    
                    ZStack(alignment: .bottomLeading) {
                        Image(city.assetName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .clipped()
                            .opacity(opacity)

                        HStack {
                            Text(city.name)
                                .font(.title)

                            Spacer()
                            Button(action: {
                                isFavorite.toggle()
                                updateTrip()
                            }) {
                                if isFavorite {
                                    Image(systemName: "star.fill")
                                } else {
                                    Image(systemName: "star")
                                }
                            }
                        }
                        .padding()
                        .foregroundColor(.white)
                        .frame(width: geometry.size.width, alignment: .leading)
                        .background(.ultraThinMaterial)
                    }
                }
                .frame(height: 500)
    
                Text(city.description)
                                   .padding(.horizontal)
                                   .font(.body)
                                   .multilineTextAlignment(.leading)
                                   .textCase(.none)
                                   
            }
        }
        .edgesIgnoringSafeArea([.top])
        .onAppear {
            isFavorite = city.isFavorite
        }
    }
    
    
    private func updateTrip() {
        city.isFavorite = isFavorite
    }
}

#Preview {
    ModelContainerPreview(PreviewSampleData.inMemoryContainer, content: {
        NavigationView {
            TabView {
                DetailView(city: City.preview)
            }
        }
    
    })
}
