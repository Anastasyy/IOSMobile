import SwiftData

actor PreviewSampleData {
    @MainActor
    static var container: ModelContainer = {
        return try! inMemoryContainer()
    }()

    static var inMemoryContainer: () throws -> ModelContainer = {
        let schema = Schema([City.self])
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: schema, configurations: [configuration])
        let sampleData: [any PersistentModel] = Sample.contents
        
  
        Task { @MainActor in
            if try container.mainContext.fetch(FetchDescriptor<City>()).isEmpty {
                Sample.contents.forEach { container.mainContext.insert($0) }
            }
        }
        return container
    }
}
