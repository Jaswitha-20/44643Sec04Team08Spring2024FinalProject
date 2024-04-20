//
//  SplitViewControllerUtility.swift
//
//
//  Created by Jaswitha Kaliliri
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
