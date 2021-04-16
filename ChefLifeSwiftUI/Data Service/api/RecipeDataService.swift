//
//  RecipeService.swift
//  ChefLifeSwiftUI
//
//  Created by Mike Griffin on 4/1/21.
//  Copyright © 2021 Mike Griffin. All rights reserved.
//

import Foundation
import Combine

struct RecipeDataService {
    func getMeasurements() -> AnyPublisher<[QuantityMeasurement], Error> {
        return apiService.fetch(endpoint: RecipeEndpoint.measurements.rawValue, headerFields: nil)
    }
    func getIngredients() -> AnyPublisher<[Ingredient], Error> {
        return apiService.fetch(endpoint: RecipeEndpoint.ingredients.rawValue, headerFields: nil)
    }
    func getTags() -> AnyPublisher<[Tag], Error> {
        return apiService.fetch(endpoint: RecipeEndpoint.tags.rawValue, headerFields: nil)
    }
    func createIngredient(body: Data) -> AnyPublisher<Ingredient, Error> {
        return apiService.post(endpoint: RecipeEndpoint.ingredients.rawValue, body: body,
                                         headerFields: [HeaderKeys.contentType.rawValue:
                                                            HeaderValues.JSONUTF8.rawValue])
    }
    func createMeasurement(body: Data) -> AnyPublisher<QuantityMeasurement, Error> {
        return apiService.post(endpoint: RecipeEndpoint.measurements.rawValue, body: body,
                                         headerFields: [HeaderKeys.contentType.rawValue:
                                                            HeaderValues.JSONUTF8.rawValue])
    }
    func createRecipe(body: Data) -> AnyPublisher<Recipe, Error> {
        return apiService.post(endpoint: RecipeEndpoint.recipes.rawValue, body: body,
                                         headerFields: [HeaderKeys.contentType.rawValue:
                                                            HeaderValues.JSON.rawValue])
    }
    func createTag(body: Data) -> AnyPublisher<Tag, Error> {
        return apiService.post(endpoint: RecipeEndpoint.tags.rawValue, body: body,
                                         headerFields: [HeaderKeys.contentType.rawValue:
                                                            HeaderValues.JSON.rawValue])
    }
}
