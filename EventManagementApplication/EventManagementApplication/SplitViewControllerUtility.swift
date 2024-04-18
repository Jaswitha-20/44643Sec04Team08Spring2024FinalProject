//
//  SplitViewControllerUtility.swift
//  LMCS
//
//  Created by Macbook-Pro on 12/04/24.
//

import Foundation
import UIKit

class SplitViewControllerUtility {
    static func toggleMasterView(for splitViewController: UISplitViewController) {
        if splitViewController.isCollapsed {
            splitViewController.show(.primary)
        } else {
            if splitViewController.displayMode == .oneOverSecondary {
                splitViewController.preferredDisplayMode = .secondaryOnly
            } else {
                splitViewController.preferredDisplayMode = .automatic
            }
        }
    }
}
