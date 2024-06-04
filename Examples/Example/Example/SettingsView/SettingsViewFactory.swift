//
//  SettingsViewFactory.swift
//  Example
//
//  Created by Stephen Wojcik on 30/05/2024.
//

import SwiftUI
import Navigator

class SettingsViewFactory {
    func make(navigator: Navigator) -> some View {
        return SettingsView(
            viewModel: SettingsViewModel(
                onPushSettingTapped: { setting in
                    navigator.push { newChildNavigator in
                        return SettingDetailViewFactory()
                            .make(
                                navigator: newChildNavigator,
                                setting: setting
                            )
                    }
                },
                onPresentSettingTapped: { setting in
                    navigator.present { newChildNavigator in
                        return SettingsViewFactory()
                            .make(
                                navigator: newChildNavigator
                            )
                    }
                },
                onCloseTapped: {
                    navigator.denavigate()
                }
            )
        )
    }
}
