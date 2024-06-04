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
        return NextPageView(
            viewModel: NextPageViewModel(
                onNextPageTapped: {
                    navigator.push(destination: NextPageViewFactory().make(navigator:))
                },
                onSettingsTapped: {
                    navigator.present(destination: SettingsViewFactory().make(navigator:))
                },
                onExitTapped: {
                    navigator.popToRoot()
                }
            )
        )
    }
}
