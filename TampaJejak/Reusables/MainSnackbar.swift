//
//  MainSnackbar.swift
//  TampaJejak
//
//  Created by Farhandika on 26/05/22.
//

import UIKit
import SnackBar_swift

class MainSnackBar: SnackBar {
    
    override var style: SnackBarStyle {
        var style = SnackBarStyle()
        style.background = .alternatejejak
        style.textColor = .dominantgreen
        return style
    }
}

