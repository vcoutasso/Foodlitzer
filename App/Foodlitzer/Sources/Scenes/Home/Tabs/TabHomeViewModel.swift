//
//  TabHomeViewModel.swift
//  Foodlitzer
//
//  Created by Alessandra Souza da Silva on 26/11/21.
//

import Combine

final class TabHomeViewModel: ObservableObject {
    // MARK: - Private properties

    private var userLocationUseCase: UserLocationUseCaseProtocol
    private var nearbyRestaurantsUseCase: FetchNearbyRestaurantsUseCaseProtocol

    // MARK: Object lifecycle

    init(userLocationUseCase: UserLocationUseCaseProtocol,
         nearbyRestaurantsUseCase: FetchNearbyRestaurantsUseCaseProtocol) {
        self.userLocationUseCase = userLocationUseCase
        self.nearbyRestaurantsUseCase = nearbyRestaurantsUseCase
    }

    // MARK: - View events

    func handleOnAppear() {
        userLocationUseCase.setup()
    }

    func handleButtonTapped(completion: @escaping ([TabHomeView.Restaurants]) -> Void) {
        if let (latitude, longitude) = userLocationUseCase.execute() {
            let latitudeDescription = latitude.description
            let longitudeDescription = longitude.description

            Task {
                let restaurants = await nearbyRestaurantsUseCase.execute(latitude: latitudeDescription,
                                                                         longitude: longitudeDescription)
                completion(restaurants.map { .init(id: $0.id,
                                                   name: $0.name,
                                                   address: $0.address,
                                                   images: $0.images.compactMap { $0.asImage() },
                                                   rating: $0.rating,
                                                   price: $0.priceLevel)
                })
            }
        }
    }
}

enum TabHomeViewModelFactory {
    static func make() -> TabHomeViewModel {
        let restaurantInfoService = FirebaseDatabaseService<RestaurantInfoDTO>()
        let restaurantImageService = FirebaseDatabaseService<RestaurantImageDTO>()
        let restaurantVideoService = FirebaseDatabaseService<RestaurantVideoDTO>()
        let mediaService = RestaurantMediaService(databaseImageService: restaurantImageService,
                                                  databaseVideoService: restaurantVideoService)
        let placesService = NearbyPlacesService()
        let invalidTypes = ["lodging"]
        let repository = NearbyRestaurantRepository(databaseService: restaurantInfoService,
                                                    mediaService: mediaService,
                                                    placesService: placesService,
                                                    invalidTypes: invalidTypes)
        let userLocationUseCase = UserLocationUseCase()
        let nearbyRestaurantsUseCase = FetchNearbyRestaurantsUseCase(repository: repository)

        return TabHomeViewModel(userLocationUseCase: userLocationUseCase,
                                nearbyRestaurantsUseCase: nearbyRestaurantsUseCase)
    }
}
