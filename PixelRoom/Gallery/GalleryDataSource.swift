//
//  GalleryDataSource.swift
//  PixelRoom
//
//  Created by Igor Lipovac on 01/03/2021.
//

import UIKit

struct PhotoItem: Equatable {
    let name: String
    let thumbnail: UIImage
    let url: URL
}

enum GallerySectionStyle {
    case featured
    case normal
    case featuredFooter
}

class GalleryDataSource {

    private struct GallerySection {
        let style: GallerySectionStyle
        let items: [PhotoItem]
    }
    
    private enum Constants {
        static let bundledPhotoNameTag = "unsplash"
        static let supportedFileTypes = ["jpg", "jpeg", "png", "heic"]
        static let featuredCount: Int = 5
        static let featureFooterCount: Int = 6
        static let pixellateUserDefaultKeyPrefix: String = "inputScaleFor"
        static let pixellateScaleInputCorrectionFactor: Float = 1.5
    }
    
    private let pixellateFilter = PixellateFilter()
    
    private var featuredPhotos = GallerySection(style: .featured, items: [])
    private var featuredFooterPhotos = GallerySection(style: .featuredFooter, items: [])
    private var photos = GallerySection(style: .normal, items: [])
    
    private var allSections: [GallerySection] {
        return [featuredPhotos, featuredFooterPhotos, photos]
    }
    
    // MARK: - Public
    
    public func reloadPhotos(completion: @escaping ()->Void) {
        DispatchQueue.global(qos: .background).async {
            var allItems: [PhotoItem] = Constants.supportedFileTypes
                .flatMap { Bundle.main.paths(forResourcesOfType: $0, inDirectory: nil) }
                .compactMap {
                    let url = URL(fileURLWithPath: $0)
                    let name = url.deletingPathExtension().lastPathComponent
                    guard name.contains(Constants.bundledPhotoNameTag),
                          let data = try? Data(contentsOf: url) else {
                        return nil
                    }
                    // TODO: add filter to the thumbnail, based on the stored parameter
                    let thumbnail = self.createThumbnail(from: data, pixellatedInputScale: self.loadPixellateEditsFor(name))
                    return PhotoItem(name: name, thumbnail: thumbnail, url: url)
                }.shuffled()
            
            let featuredItems = allItems.prefix(Constants.featuredCount)
            allItems.removeFirst(featuredItems.count)
            
            let footerItems = allItems.prefix(Constants.featureFooterCount)
            allItems.removeFirst(footerItems.count)
            
            self.featuredPhotos = GallerySection(style: .featured, items: Array(featuredItems))
            self.photos = GallerySection(style: .normal, items: allItems)
            self.featuredFooterPhotos = GallerySection(style: .featuredFooter, items: Array(footerItems))
            completion()
        }
    }

    public var numberOfSections: Int {
        return allSections.count
    }

    public func numberOfItemsInSection(_ section: Int) -> Int {
        return allSections[section].items.count
    }
    
    public func sectionStyleForSecton(_ section: Int) -> GallerySectionStyle {
        return allSections[section].style
    }
    
    public func item(at index:Int, inSection section: Int) -> PhotoItem {
        return allSections[section].items[index]
    }
    
    func loadPixellateEditsFor(_ filename: String) -> Float? {
        let userDefaults = UserDefaults.standard
        return userDefaults.float(forKey: "\(Constants.pixellateUserDefaultKeyPrefix)_\(filename)")
    }
}

// MARK: - Helpers

extension GalleryDataSource {
    
    private func createThumbnail(from imageData: Data, pixellatedInputScale: Float?) -> UIImage {
        let options = [
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceThumbnailMaxPixelSize: 150 * UIScreen.main.scale
        ] as CFDictionary
        let source = CGImageSourceCreateWithData(imageData as NSData, nil)!
        let imageReference = CGImageSourceCreateThumbnailAtIndex(source, 0, options)!
        let imageProperties = CGImageSourceCopyPropertiesAtIndex(source, 0, nil)! as Dictionary
        
        // If a pixellatedInputScale params is present, and is >= 1.0
        // let's try to pixellate the thumbnail,
        // otherwise, let's return the unfiltered thumbnail
        guard let pixellatedInputScale = pixellatedInputScale,
              pixellatedInputScale >= 1.0,
              let sourceWidth = imageProperties[kCGImagePropertyPixelWidth] as? Float else {
            let thumbnailImage = UIImage(cgImage: imageReference)
            return thumbnailImage
        }
        
        // Since the filter is applied to the thumbnail (because it's faster than applying it
        // to the whole image), in order to have realistic effect on the thumbnail
        // let's scale down the inputScale parameter of the filter
        // The pixellateScaleInputCorrectionFactor is an empiric correction factor used to
        // obtain a more visually pleasant effect with the thumbnails (and perceptually
        // more similar to the one applied to the full screen image)
        let ratio = Float(imageReference.width) / sourceWidth
        let thumbnailPixellatedInputScale = ratio * pixellatedInputScale * Constants.pixellateScaleInputCorrectionFactor
        
        let thumbnailImage = UIImage(cgImage: pixellateFilter
                                        .pixellate(image: imageReference,
                                                   inputScale: thumbnailPixellatedInputScale) ?? imageReference)
        return thumbnailImage
    }
}
