//
//  ImageItemCreateViewController.swift
//  GroupIt
//
//  Created by Ankit Jasuja on 8/24/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit

protocol ImageItemCreateDelegate {
    func onSave(imageItem : ImageItem)
}

class ImageItemCreateViewController: UIViewController {

    @IBOutlet weak var imageItemNameTextField: UITextField!
    @IBOutlet weak var uploadPhotoButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    var delegate : ImageItemCreateDelegate?
    
    var imageItem : ImageItem?
    
    func beautify() {
        let backgroundImage = UIImageView(frame: UIScreen.mainScreen().bounds)
        backgroundImage.image = UIImage(named: "bg-image-2")
        self.view.insertSubview(backgroundImage, atIndex: 0)

        TextFieldTheme.beautifyTextField(imageItemNameTextField, placeHolder: "name")

        ButtonTheme.beautifyButton(uploadPhotoButton)
        ButtonTheme.beautifyButton(saveButton)
        ButtonTheme.beautifyButton(cancelButton)
    }

    override func viewDidLoad() {
        print("create image view controller ... ")
        super.viewDidLoad()
        imageItemNameTextField.delegate = self
        beautify()
        prepopulateData()
    }

    func prepopulateData() {
        if let imageItem = imageItem {
            self.imageItemNameTextField.text = imageItem.imageItemName
        }
    }

    @IBAction func onCameraButtonTap(sender: AnyObject) {
        print("opening camera ... ")
        // call camera and set image in imageItem.
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        if (UIImagePickerController.isSourceTypeAvailable(.Camera)) {
            imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera
        } else if (UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary)) {
            imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        } else if (UIImagePickerController.isSourceTypeAvailable(.SavedPhotosAlbum)) {
            imagePickerController.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
        }
        self.presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func onSaveButtonTap(sender: AnyObject) {
        print("saving image item ...")
        let updatedImageItem = getUpdatedImageItem()
        self.delegate?.onSave(updatedImageItem)
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    func getUpdatedImageItem() -> ImageItem {
        let imageItem = ImageItem()
        imageItem.imageItemId = self.imageItem?.imageItemId
        imageItem.imageItemName = imageItemNameTextField.text
        imageItem.image = self.imageItem?.image
        return imageItem
    }

    
    @IBAction func onCancelButtonTap(sender: AnyObject) {
        print("cancelling image item ...")
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
}

extension ImageItemCreateViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Do something with the images (based on your use case)
        if imageItem == nil {
            self.imageItem = ImageItem()
        }
        self.imageItem?.image = originalImage
        // Dismiss UIImagePickerController to go back to your original view controller
        dismissViewControllerAnimated(true, completion: nil)
//        performSegueWithIdentifier("tagSegue", sender: nil)
    }

}

extension ImageItemCreateViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}



