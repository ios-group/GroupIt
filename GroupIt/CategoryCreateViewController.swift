//
//  CategoryCreateViewController.swift
//  GroupIt
//
//  Created by Ankit Jasuja on 8/21/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit

protocol CategoryCreateDelegate {
    func onSave(category : Category)
}


class CategoryCreateViewController: UIViewController {

    var category : Category?
    var delegate : CategoryCreateDelegate?
    
    @IBOutlet weak var categoryTypeLabel: UILabel!
    
    @IBOutlet weak var categoryNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepopulateData()
    }

    func prepopulateData() {
        if let category = category {
            categoryTypeLabel.text = category.categoryType.rawValue
            categoryNameTextField.text = category.categoryName
        }
    }

    @IBAction func onSaveButtonTap(sender: AnyObject) {
        print("saving category ...")
        let updatedCategory = getUpdatedCategory()
        self.delegate?.onSave(updatedCategory)
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    func getUpdatedCategory() -> Category {
        let updatedCategory = Category(categoryType: self.category!.categoryType)
        updatedCategory.categoryId = self.category?.categoryId
        updatedCategory.categoryName = categoryNameTextField.text
        return updatedCategory
    }
//        let categoryType : CategoryType = (self.category?.categoryType)!
//        switch categoryType {
//        case .TODO:
//            print("creating todo category ...")
//            let todoCategory = TodoCategory()
//            todoCategory.id = self.category?.categoryId
//            todoCategory.todoName = categoryNameTextField.text
//            return todoCategory
//        case .POLL:
//            print("creating poll category ...")
//            let pollCategory = PollCategory()
//            return pollCategory
//        case .IMAGES:
//            print("creating image category ...")
//            let imageCategory = ImageCategory()
//            return imageCategory
//        }
//    }
    
    @IBAction func onCancelButtonTap(sender: AnyObject) {
        print("cancelling category ...")
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
}
