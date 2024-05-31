//
//  NextPageViewFactory.swift
//  Example
//
//  Created by Stephen Wojcik on 30/05/2024.
//

import SwiftUI
import Navigator

class NextPageViewFactory {
    func make(navigator: Navigator) -> some View {
        let viewModel = NextPageViewModel()
        
        viewModel.onNextPageTapped = {
            navigator.push(destination: NextPageViewFactory().make(navigator:))
        }
        
        viewModel.onSettingsTapped = {
            navigator.present(destination: SettingsViewFactory().make(navigator:))
        }
        
        viewModel.onExitTapped = {
            navigator.popToRoot()
        }
        
        return NextPageView(viewModel: viewModel)
    }
}
