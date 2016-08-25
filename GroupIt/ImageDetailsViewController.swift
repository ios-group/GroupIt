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
    
    var imageItemManager = ImageItemManager()
    
    func onAddButton() {
        print("adding a new image item ... ")
        performSegueWithIdentifier(Constants.CREATE_IMAGE_ITEM_SEQUE, sender: nil)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagesCollectionView.dataSource = self
        imagesCollectionView.backgroundColor = UIColor.whiteColor()
        
        let addButton = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(onAddButton))
        self.navigationItem.rightBarButtonItem = addButton
        
        self.title = imageCategory?.categoryName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let segueIdentifier = segue.identifier
        if segueIdentifier == Constants.CREATE_IMAGE_ITEM_SEQUE {
            let imageItemCreateViewController = segue.destinationViewController as! ImageItemCreateViewController
            if let sender = sender {
                let imageItem = sender as! ImageItem
                imageItemCreateViewController.imageItem = imageItem
            }
            imageItemCreateViewController.delegate = self
        }
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
        if let imageCategory = imageCategory {
            return imageCategory.imageItems.count
        } else {
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let imageCell = collectionView.dequeueReusableCellWithReuseIdentifier(Constants.IMAGE_CELL_ID, forIndexPath:indexPath) as! ImageCell
        let imageItem = imageCategory?.imageItems[indexPath.row]
        imageCell.imageView.image = imageItem?.image
        imageCell.imageItemNameLabel.text = imageItem?.imageItemName
        return imageCell
    }
}

extension ImageDetailsViewController : ImageItemCreateDelegate {
  
    func onSave(imageItem: ImageItem) {
        print("saving image item ...")
        if (imageItem.imageItemId != nil) {
            //update todoitem flow
            findAndRemove(imageItem)
        }
        imageItemManager.upsertImageItem((self.imageCategory?.categoryId)!, imageItem: imageItem) { (created : Bool, imageItem: ImageItem?, error : NSError?) in
            if error == nil {
                print("created ... \(imageItem)")
                self.imageCategory?.imageItems.append(imageItem!)
                self.imagesCollectionView.reloadData()
            } else {
                print(error)
            }
        }
    }

    func findAndRemove(imageItem : ImageItem) {
        let imageItemIndex = findIndex(imageItem)
        if let imageItemIndex = imageItemIndex {
            self.imageCategory?.imageItems.removeAtIndex(imageItemIndex)
        }
    }
    
    func findIndex(imageItem : ImageItem) -> Int? {
        let imageItems = self.imageCategory?.imageItems
        for i in 0 ..< imageItems!.count  {
            let existingImageItem = imageItems![i]
            if existingImageItem.imageItemId == imageItem.imageItemId {
                return i
            }
        }
        return nil
    }

    
}
