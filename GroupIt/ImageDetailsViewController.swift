//
//  ImageDetailsViewController.swift
//  GroupIt
//
//  Created by Ankit Jasuja on 8/11/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit

class ImageDetailsViewController: UIViewController {

    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    var imageCategory : ImageCategory?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagesCollectionView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ImageDetailsViewController : UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (imageCategory?.imageItems?.count)!
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let imageCell = collectionView.dequeueReusableCellWithReuseIdentifier(Constants.IMAGE_CELL_ID, forIndexPath:indexPath) as! ImageCell
        let imageItem = imageCategory?.imageItems![indexPath.row]
        imageCell.imageView.image = imageItem?.image
        return imageCell
    }
}
