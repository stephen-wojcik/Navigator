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
        let viewModel = SettingsViewModel()
        
        viewModel.onPushSettingTapped = { setting in
            navigator.push { newChildNavigator in
                return SettingDetailViewFactory()
                    .make(
                        navigator: newChildNavigator,
                        setting: setting
                    )
            }
        }
        
        viewModel.onPresentSettingTapped = { setting in
            navigator.present { newChildNavigator in
                return SettingDetailViewFactory()
                    .make(
                        navigator: newChildNavigator,
                        setting: setting
                    )
            }
        }
        
        viewModel.onCloseTapped = {
            navigator.denavigate()
        }
        
        return SettingsView(viewModel: viewModel)
    }
}
