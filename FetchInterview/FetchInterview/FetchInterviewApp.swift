//
//  FetchInterviewApp.swift
//  FetchInterview
//
//  Created by Zachery Wagner on 11/21/24.
//

import SwiftUI

@main
struct FetchInterviewApp: App {
    var body: some Scene {
        WindowGroup {
            RecipeListViewFactory.create()
        }
    }
}
