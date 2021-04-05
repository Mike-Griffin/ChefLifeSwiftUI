//
//  RecipeService.swift
//  ChefLifeSwiftUI
//
//  Created by Mike Griffin on 4/1/21.
//  Copyright © 2021 Mike Griffin. All rights reserved.
//

import Foundation
import Combine

private let apiService = ApiService()

struct RecipeDataService {
    func getMeasurements() -> AnyPublisher<[QuantityMeasurement], Error> {
        return apiService.combineRequest(endpoint: RecipeEndpoint.measurements.rawValue, body: nil,
                                         httpMethod: HttpMethod.get.rawValue, headerFields: nil)
    }
    func getIngredients() -> AnyPublisher<[Ingredient], Error> {
        return apiService.combineRequest(endpoint: RecipeEndpoint.ingredients.rawValue, body: nil,
                                         httpMethod: HttpMethod.get.rawValue, headerFields: nil)
    }
    func createIngredient(body: Data) -> AnyPublisher<Ingredient, Error> {
        return apiService.combineRequest(endpoint: RecipeEndpoint.ingredients.rawValue, body: body,
                                         httpMethod: HttpMethod.post.rawValue,
                                         headerFields: [HeaderKeys.contentType.rawValue:
                                                            HeaderValues.JSONUTF8.rawValue])
    }
    func createMeasurement(body: Data) -> AnyPublisher<QuantityMeasurement, Error> {
        return apiService.combineRequest(endpoint: RecipeEndpoint.measurements.rawValue, body: body,
                                         httpMethod: HttpMethod.post.rawValue,
                                         headerFields: [HeaderKeys.contentType.rawValue:
                                                            HeaderValues.JSONUTF8.rawValue])
    }
}
