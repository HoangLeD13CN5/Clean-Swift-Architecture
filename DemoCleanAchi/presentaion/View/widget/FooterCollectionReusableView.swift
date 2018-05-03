//
//  FooterCollectionReusableView.swift
//  DemoCleanAchi
//
//  Created by LEMINHO on 4/4/18.
//  Copyright © 2018 LEMINHO. All rights reserved.
//

import UIKit

class FooterCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var loading: UIActivityIndicatorView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func showLoading(){
        self.loading.isHidden = false;
    }
    
    func hideLoading(){
        self.loading.isHidden = true;
    }
    
    
}
