//
//  ZoomAndSnapFlowLayout.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 08/06/2021.
//

import Foundation
import UIKit

class ZoomAndSnapFlowLayout: UICollectionViewFlowLayout {
    
    var width : CGFloat = 0
    var height : CGFloat = 0
    let activeDistance: CGFloat = 200 //200
    let zoomFactor: CGFloat = 0.5 //0.3

    
  
    override init() {
        super.init()
    
        scrollDirection = .horizontal
        minimumLineSpacing = 40 // 40
        itemSize = CGSize(width: 150, height: 200)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   

    override func prepare() {
        guard let collectionView = collectionView else { fatalError() }
        let verticalInsets = (collectionView.frame.height - collectionView.adjustedContentInset.top - collectionView.adjustedContentInset.bottom - itemSize.height) / 2 // 2
        let horizontalInsets = (collectionView.frame.width - collectionView.adjustedContentInset.right - collectionView.adjustedContentInset.left - itemSize.width) / 2 //2
        sectionInset = UIEdgeInsets(top: verticalInsets, left: horizontalInsets, bottom: verticalInsets, right: horizontalInsets)

        super.prepare()
    }

//    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        guard let collectionView = collectionView else { return nil }
//        let rectAttributes = super.layoutAttributesForElements(in: rect)!.map { $0.copy() as! UICollectionViewLayoutAttributes }
//        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.frame.size)
//
//        // Make the cells be zoomed when they reach the center of the screen
//        for attributes in rectAttributes where attributes.frame.intersects(visibleRect) {
//            let distance = visibleRect.midX - attributes.center.x
//            let normalizedDistance = distance / activeDistance
//
//            if distance.magnitude < activeDistance {
//                let zoom = 1 + zoomFactor * (1 - normalizedDistance.magnitude)
//                attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1)
//                attributes.zIndex = Int(zoom.rounded())
//            }
//        }
//
//        return rectAttributes
//    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let collectionView = collectionView else { return nil }
        let rectAttributes = super.layoutAttributesForElements(in: rect)!.map { $0.copy() as! UICollectionViewLayoutAttributes }
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.frame.size)
        let visibleAttributes = rectAttributes.filter { $0.frame.intersects(visibleRect) }

        // Keep the spacing between cells the same.
        // Each cell shifts the next cell by half of it's enlarged size.
        // Calculated separately for each direction.
        func adjustXPosition(_ toProcess: [UICollectionViewLayoutAttributes], direction: CGFloat, zoom: Bool = false) {
            var dx: CGFloat = 0

            for attributes in toProcess {
                let distance = visibleRect.midX - attributes.center.x
                attributes.frame.origin.x += dx

                if distance.magnitude < activeDistance {
                    let normalizedDistance = distance / activeDistance
                    let zoomAddition = zoomFactor * (1 - normalizedDistance.magnitude)
                    let widthAddition = attributes.frame.width * zoomAddition / 2
                    dx = dx + widthAddition * direction

                    if zoom {
                        let scale = 1 + zoomAddition
                        attributes.transform3D = CATransform3DMakeScale(scale, scale, 1)
                    }
                }
            }
        }

        // Adjust the x position first from left to right.
        // Then adjust the x position from right to left.
        // Lastly zoom the cells when they reach the center of the screen (zoom: true).
        adjustXPosition(visibleAttributes, direction: +1)
        adjustXPosition(visibleAttributes.reversed(), direction: -1, zoom: true)

        return rectAttributes
    }

    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return .zero }

        // Add some snapping behaviour so that the zoomed cell is always centered
        let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.frame.width, height: collectionView.frame.height)
        guard let rectAttributes = super.layoutAttributesForElements(in: targetRect) else { return .zero }

        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        let horizontalCenter = proposedContentOffset.x + collectionView.frame.width / 2

        for layoutAttributes in rectAttributes {
            let itemHorizontalCenter = layoutAttributes.center.x
            if (itemHorizontalCenter - horizontalCenter).magnitude < offsetAdjustment.magnitude {
                offsetAdjustment = itemHorizontalCenter - horizontalCenter
            }
        }

        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        // Invalidate layout so that every cell get a chance to be zoomed when it reaches the center of the screen
        return true
    }

    override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
        let context = super.invalidationContext(forBoundsChange: newBounds) as! UICollectionViewFlowLayoutInvalidationContext
        context.invalidateFlowLayoutDelegateMetrics = newBounds.size != collectionView?.bounds.size
        return context
    }

}
