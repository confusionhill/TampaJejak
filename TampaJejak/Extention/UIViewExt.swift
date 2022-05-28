//
//  UIViewExt.swift
//  TampaJejak
//
//  Created by Farhandika on 14/05/22.
//

import UIKit

extension UIView {
    func setRounded(
        size: CGSize,
        where parts: UIRectCorner
    ) {
       let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: parts, cornerRadii: size)
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
}


extension UICollectionView {
    func scrollToNearestVisibleCollectionViewCell() {
        self.decelerationRate = UIScrollView.DecelerationRate.fast
        let visibleCenterPositionOfScrollView = Float(self.contentOffset.x + (self.bounds.size.width / 2))
        var closestCellIndex = -1
        var closestDistance: Float = .greatestFiniteMagnitude
        for i in 0..<self.visibleCells.count {
            let cell = self.visibleCells[i]
            let cellWidth = cell.bounds.size.width
            let cellCenter = Float(cell.frame.origin.x + cellWidth / 2)

            // Now calculate closest cell
            let distance: Float = fabsf(visibleCenterPositionOfScrollView - cellCenter)
            if distance < closestDistance {
                closestDistance = distance
                closestCellIndex = self.indexPath(for: cell)!.row
            }
        }
        if closestCellIndex != -1 {
            self.scrollToItem(at: IndexPath(row: closestCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
}


extension UITableView {
    static let shouldScrollSectionHeadersDummyViewHeight = CGFloat(40)

    var shouldScrollSectionHeaders: Bool {
        set {
            if newValue {
                tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: UITableView.shouldScrollSectionHeadersDummyViewHeight))
                contentInset = UIEdgeInsets(top: -UITableView.shouldScrollSectionHeadersDummyViewHeight, left: 0, bottom: 0, right: 0)
            } else {
                tableHeaderView = nil
                contentInset = .zero
            }
        }

        get {
            return tableHeaderView != nil && contentInset.top == UITableView.shouldScrollSectionHeadersDummyViewHeight
        }
    }

}
