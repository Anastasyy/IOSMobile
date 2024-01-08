import SwiftUI
import YandexMapsMobile

import SwiftData



import Combine

class SelectedCityPublisher: ObservableObject {
    static let shared = SelectedCityPublisher()
    @Published var selectedCity: City?
}

final private class MapObjectTapListener: NSObject, YMKMapObjectTapListener {
    var lastTappedPlacemark: YMKPlacemarkMapObject?

    func onMapObjectTap(with mapObject: YMKMapObject, point: YMKPoint) -> Bool {
        if let placemark = mapObject as? YMKPlacemarkMapObject {
            let iconStyle = YMKIconStyle()
            iconStyle.anchor = NSValue(cgPoint: CGPoint(x: 0.5, y: 0.5))
            iconStyle.scale = 2.0
            
            let largeIcon =  UIImage(systemName: "mappin.and.ellipse.circle.fill")
            placemark.setIconWith(largeIcon!, style: iconStyle)

           if let lastPlacemark = lastTappedPlacemark, lastPlacemark != placemark {
               let normalIcon = UIImage(systemName: "mappin.and.ellipse.circle.fill")
               lastPlacemark.setIconWith(normalIcon!)
           }

            lastTappedPlacemark = placemark
            if let city = mapObject.userData as? City {
              let publisher = SelectedCityPublisher.shared
              publisher.selectedCity = nil
              DispatchQueue.main.async {
                  publisher.selectedCity = city
              }
            }
       }
        return true
    }
}

class YandexMapController: ObservableObject {
    static let shared = YandexMapController()
    @Published var map: YMKMapView?
    
    private var drivingSession: YMKDrivingSession?
    private var locationManager: LocationManager
    private let tapListener = MapObjectTapListener()

    private init() {
      self.locationManager = LocationManager()
    }
    
    func setupPlacemarks(cities: [City]) {
        for city in cities {
            let point = YMKPoint(latitude: Double(city.latitude), longitude: Double(city.longitude))
            let placemark = map!.mapWindow.map.mapObjects.addPlacemark(with: point)
            let image = UIImage(systemName: "mappin.and.ellipse.circle.fill")
            let coloredImage = image!.withTintColor(.red, renderingMode: .alwaysOriginal)
            
            let iconStyle = YMKIconStyle()
            iconStyle.anchor = NSValue(cgPoint: CGPoint(x: 0.5, y: 0.5))
            iconStyle.scale = 1
            
            placemark.opacity = 1
            placemark.isDraggable = false
            placemark.userData = city
            placemark.setIconWith(image!, style: iconStyle)
            
            placemark.addTapListener(with: tapListener)
        }
    }
    
    func cleanMap () {
        map!.mapWindow.map.mapObjects.clear()
        tapListener.lastTappedPlacemark = nil
    }
    
    func buildDirections(to city: City, onStart: @escaping () -> Void, onCompletion: @escaping () -> Void, onFail: @escaping () -> Void) {
        onStart()
    
        
        guard let location = locationManager.currentLocation else {
            print("Current location is not available.")
            return
        }
        
        guard let mapView = self.map else {
            print("Map view is not initialized.")
            return
        }
        
        let drivingRouter = YMKDirections.sharedInstance().createDrivingRouter()
        
        let drivingOptions: YMKDrivingDrivingOptions = {
            let options = YMKDrivingDrivingOptions()
            options.routesCount = 3
            return options
        }()
        
        let vehicleOptions = YMKDrivingVehicleOptions()
        
        let requestPoints = [
            YMKRequestPoint(point: YMKPoint(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude), type: .waypoint, pointContext: nil, drivingArrivalPointId: nil),
            YMKRequestPoint(point: YMKPoint(latitude: Double(city.latitude), longitude: Double(city.longitude)), type: .waypoint, pointContext: nil, drivingArrivalPointId: nil)
        ]
        
        self.drivingSession = drivingRouter.requestRoutes(
            with: requestPoints,
            drivingOptions: drivingOptions,
            vehicleOptions: vehicleOptions,
            routeHandler: { routes, error in
                if let error = error {
                    print("Error requesting routes: \(error.localizedDescription)")
                    onFail()
                    return
                }
               onCompletion()
               self.drivingRouteHandler(drivingRoutes: routes, error: error)
            }
        )
    }
    
    func drivingRouteHandler(drivingRoutes: [YMKDrivingRoute]?, error: Error?) {
            guard let routes = drivingRoutes else {
                print("No routes available.")
                return
            }
            for route in routes {
                let polylinePoints = route.geometry.points.map { YMKPoint(latitude: $0.latitude, longitude: $0.longitude) }
                let mapPolyline = YMKPolyline(points: polylinePoints)

                let polylineMapObject = map!.mapWindow.map.mapObjects.addPolyline(with: mapPolyline)

                polylineMapObject.strokeWidth = 5.0
                polylineMapObject.setStrokeColorWith(.systemTeal)
                polylineMapObject.outlineWidth = 1.0
                polylineMapObject.outlineColor = .black
            }
    }
}

struct YandexMapView: UIViewRepresentable {
    @EnvironmentObject var locationManager: LocationManager
    @Query var cities: [City]
    
    private var initialCenteringDone = false
    private let mapView = YMKMapView(frame: CGRect.zero)
    
    var cancellables = Set<AnyCancellable>()

    func makeUIView(context: Context) -> YMKMapView {
        let coordinator = context.coordinator
        coordinator.setupLocationSubscription()
        let mapKit = YMKMapKit.sharedInstance()
        let userLocationLayer = mapKit.createUserLocationLayer(with: mapView!.mapWindow)
        userLocationLayer.setVisibleWithOn(true)
        userLocationLayer.isHeadingEnabled = true
        YandexMapController.shared.map = mapView
        YandexMapController.shared.setupPlacemarks(cities: cities)
    
        return mapView!
    }

    func updateUIView(_ mapView: YMKMapView, context: Context) {}
    

    private mutating func centerMapLocation(target: YMKPoint, map: YMKMapView) {
        guard !initialCenteringDone else { return }
        let animation = YMKAnimation(type: YMKAnimationType.smooth, duration: 0.5)
        map.mapWindow.map.move(
            with: YMKCameraPosition(target: target, zoom: 14, azimuth: 0, tilt: 0),
            animation: animation,
            cameraCallback: nil
        )
        
        initialCenteringDone = true
    }

    mutating func updateMapLocation() {
        if let location = locationManager.currentLocation {
            let target = YMKPoint(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            centerMapLocation(target: target, map: mapView!)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    final class Coordinator: NSObject {
        var mapView: YandexMapView

        init(_ mapView: YandexMapView) {
            self.mapView = mapView
        }

        func setupLocationSubscription() {
            mapView.locationManager.$currentLocation
                .receive(on: RunLoop.main)
                .sink { [weak self] _ in
                    self?.mapView.updateMapLocation()
                }
                .store(in: &mapView.cancellables)
        }
    }
}
