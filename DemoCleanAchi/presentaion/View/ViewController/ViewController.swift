//
//  ViewController.swift
//  DemoCleanAchi
//
//  Created by LEMINHO on 4/2/18.
//  Copyright © 2018 LEMINHO. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController,ListMovieView,UICollectionViewDataSource {
    
    @IBOutlet weak var collectionMovies: UICollectionView!
    let reuseIdentifier = "ImageCell"
    let reuseFooterIdentifier = "RefreshFooterView"
    var footerView:FooterCollectionReusableView?
    var arr:Array<String> = Array()
    var isLoading:Bool = true
    
    var listMoviePretenser:ListMoviePretenser!
    
    fileprivate let itemsPerRow: CGFloat = 2
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
         listMoviePretenser.attachView(view: self)
        // set footer for UICollectionView
        self.collectionMovies.register(UINib(nibName: "FooterCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: reuseFooterIdentifier)
    
    }
    override func viewWillAppear(_ animated: Bool) {
        listMoviePretenser.refreshListMovies()
    }
    override func viewDidDisappear(_ animated: Bool) {
        listMoviePretenser.detachView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadMoviesSuccess( load:Int,size:Int){
        DispatchQueue.main.async {
            self.footerView?.hideLoading()
            self.isLoading = false
            self.collectionMovies.reloadData()
        }
    }
    
    func refreshData(){
        DispatchQueue.main.async {
            self.isLoading = true
            self.collectionMovies.reloadData()
            self.footerView?.showLoading()
           
        }
    }
  
    
    // click item
    func collectionView(_ collectionView: UICollectionView,shouldSelectItemAt indexPath: IndexPath) -> Bool {
        self.listMoviePretenser.clickMovieItem(position: indexPath.row)
        return false
    }
   
    // size header
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 0)
    }
    // size footer
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: 55)
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset.y;
        let contentHeight = scrollView.contentSize.height;
        let diffHeight = contentHeight - contentOffset;
        let frameHeight = scrollView.bounds.size.height;
        let pullHeight  = fabs(diffHeight - frameHeight);
        print("scrollViewWillBeginDecelerating contentOffset: \(contentOffset)")
        print("scrollViewWillBeginDecelerating pullHeight: \(pullHeight)")
    }
    //compute the offset and call the load method
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset.y;
        let contentHeight = scrollView.contentSize.height;
        let diffHeight = contentHeight - contentOffset;
        let frameHeight = scrollView.bounds.size.height;
        let pullHeight  = fabs(diffHeight - frameHeight);
        print("scrollViewDidEndDecelerating contentOffset: \(contentOffset)")
        print("scrollViewDidEndDecelerating pullHeight: \(pullHeight)")
        if pullHeight == 0.0 && isLoading == false{
            self.isLoading = true
            self.footerView?.showLoading()
            self.listMoviePretenser.getListMovies()
        }
        if contentOffset == 0.0 && isLoading == false{
            self.listMoviePretenser.refreshListMovies()
        }
    }
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    // count of a section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listMoviePretenser.movies.count
    }
    
    
    // create item
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MovieViewCell
        let movie = listMoviePretenser.movies[indexPath.row]
        let url = URL(string: movie.url!)
        cell.imageMovie.kf.setImage(with:url)
        return cell
    }
    
    
    // create footer
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView{
        switch kind {
        case UICollectionElementKindSectionFooter:
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseFooterIdentifier, for: indexPath) as! FooterCollectionReusableView
            self.footerView = footer
            self.footerView?.backgroundColor = UIColor.clear
            return footer
        default:
            assert(false, "Unexpected element kind")
        }
    }
}

extension ViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                                 layout collectionViewLayout: UICollectionViewLayout,
                                 minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return CGFloat(0.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return CGFloat(0.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let collectionViewSize = collectionMovies.frame.size.width
        return CGSize(width: collectionViewSize/itemsPerRow, height: collectionViewSize/itemsPerRow)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
    }
}


