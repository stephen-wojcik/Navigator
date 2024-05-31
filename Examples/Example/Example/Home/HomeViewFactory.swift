//
//  HomeViewFactory.swift
//  Example
//
//  Created by Stephen Wojcik on 30/05/2024.
//

import SwiftUI
import Navigator

class HomeViewFactory {
    func make() -> RootCoordinatedScreenView<HomeView> {
        let navigator = SwiftUINavigator.makeRoot()
        let viewModel = HomeViewModel()
        
        viewModel.onNextPageTapped = {
            navigator.push(destination: NextPageViewFactory().make(navigator:))
        }
        
        viewModel.onSettingsTapped = {
            navigator.present(destination: SettingsViewFactory().make(navigator:))
        }
        
        return HomeView(viewModel: viewModel)
            .root(navigator: navigator)
    }
}
