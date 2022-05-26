//
//  StringExt.swift
//  TampaJejak
//
//  Created by Farhandika on 26/05/22.
//

import Foundation

extension String {
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}

extension RangeReplaceableCollection where Element: Equatable {

    mutating func addOrReplace(_ element: Element) {
        if let index = self.firstIndex(of: element) {
            self.replaceSubrange(index...index, with: [element])
        }
        else {
            self.append(element)
        }
    }
}
