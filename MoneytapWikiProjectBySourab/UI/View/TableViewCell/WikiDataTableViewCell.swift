//
//  WikiDataTableViewCell.swift
//  MoneytapWikiProjectBySourab
//
//  Created by Sourab on 08/09/18.
//  Copyright © 2018 Sourab. All rights reserved.
//

import UIKit
import SDWebImage

class WikiDataTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgVwWikiImage: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var activityIndicatorImage: UIActivityIndicatorView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgVwWikiImage.image = nil
        imgVwWikiImage.sd_cancelCurrentImageLoad()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpUI() {
        labelTitle.textColor = BrandingClass.getDarkBlackColor()
        labelDescription.textColor = BrandingClass.getLightBlackColor()
    }
    
    func loadImageWithImageUrl(strImgSource: String) {
        activityIndicatorImage.startAnimating()
        let url = URL(string: strImgSource)
        
        imgVwWikiImage.sd_setImage(with: url, placeholderImage: nil, options: SDWebImageOptions.cacheMemoryOnly, completed: {(img, err, cacheTp, imgUr) in
            if err != nil {
                self.imgVwWikiImage.image = UIImage.init(named: "imageNotFound")
            } else {
                self.imgVwWikiImage.image = img
            }
            self.activityIndicatorImage.stopAnimating()
        })
    }
}
