//
//  RecipeListView+ViewState.swift
//  FetchInterview
//
//  Created by Zachery Wagner on 11/21/24.
//

import Foundation

extension RecipeListView {
    enum ViewState: Equatable {
        case loading
        case loaded([Recipe])
        case empty
        case error(String)
    }
}
