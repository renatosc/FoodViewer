//
//  ProductSection.swift
//  FoodViewer
//
//  Created by arnaud on 25/08/2017.
//  Copyright © 2017 Hovering Above. All rights reserved.
//

import Foundation

public enum ProductSection {
    
    case identification
    case gallery
    case ingredients
    case nutritionFacts
    case nutritionScore
    case categories
    case completion
    case supplyChain

    var description: String {
        switch self {
        case .identification:
            return  TranslatableStrings.Identification
        case .ingredients:
            return TranslatableStrings.Ingredients
        case .gallery:
            return TranslatableStrings.Gallery
        case .nutritionFacts:
            return TranslatableStrings.NutritionFacts
        case .nutritionScore:
            return TranslatableStrings.NutritionalScore
        case .categories:
            return TranslatableStrings.Categories
        case .completion:
            return TranslatableStrings.CommunityEffort
        case .supplyChain:
            return  TranslatableStrings.SupplyChain
        }
    }
    

}
