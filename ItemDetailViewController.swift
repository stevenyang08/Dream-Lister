//
//  ItemDetailViewController.swift
//  Dream Lister
//
//  Created by Steven Yang on 8/28/16.
//  Copyright © 2016 Steven Yang. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var storePicker: UIPickerView!
    
    @IBOutlet weak var titleTextField: CustomTextField!
    
    @IBOutlet weak var priceTextField: CustomTextField!
    
    @IBOutlet weak var detailTextField: CustomTextField!
    
    @IBOutlet weak var thumbImage: UIImageView!
    
    var stores = [Store]()
    var itemTypes = [ItemType]()
    var itemToEdit: Item?
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        storePicker.delegate = self
        storePicker.dataSource = self

        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        print(stores.count)
        print(itemTypes.count)
        
        getStores()
        getItemTypes()
        
        if stores.count <= 0 {
            let store = Store(context: context)
            store.name = "Bestbuy"
            
            let store2 = Store(context: context)
            store2.name = "Tesla Dealership"
            
            let store3 = Store(context: context)
            store3.name = "Frys Electronic"
            
            let store4 = Store(context: context)
            store4.name = "Target"
            
            let store5 = Store(context: context)
            store5.name = "Amazon"
            
            let store6 = Store(context: context)
            store6.name = "K-Mart"
            
            ad.saveContext()
            getStores()
        }

        if itemTypes.count <= 0 {
            let itemType = ItemType(context: context)
            itemType.type = "Accessory"
            
            let itemType2 = ItemType(context: context)
            itemType2.type = "Electronic"
            
            let itemType3 = ItemType(context: context)
            itemType3.type = "Vehicle"
            
            let itemType4 = ItemType(context: context)
            itemType4.type = "Clothing"
            
            ad.saveContext()
            getItemTypes()
        }
    
        
        print(stores.count)
        print(itemTypes.count)
        
        if itemToEdit != nil {
            loadItemData()
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            let store = stores[row]
            return store.name
        } else {
            let itemType = itemTypes[row]
            return itemType.type
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return stores.count
        } else {
            return itemTypes.count
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Update later
    }
    
    func getStores() {
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        do {
            self.stores = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
        } catch {
            
            //handle error
        }
        
    }
    
    func getItemTypes() {
        let fetchRequest: NSFetchRequest<ItemType> = ItemType.fetchRequest()
        do {
            self.itemTypes = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
        } catch {
            
            //handle error
        }
    }
    
    @IBAction func saveItemButtonTapped(_ sender: AnyObject) {
        var item: Item!
        let picture = Image(context: context)
        picture.image = thumbImage.image
        
        if itemToEdit == nil {
            item = Item(context: context)
        } else {
            item = itemToEdit
        }
        
        item.toImage = picture

        if let title = titleTextField.text {
            item.title = title
        }
        if let price = priceTextField.text {
            item.price = (price as NSString).doubleValue
        }
        if let details = detailTextField.text {
            item.details = details
        }
        item.toStore = stores[storePicker.selectedRow(inComponent: 0)]
        item.toItemType = itemTypes[storePicker.selectedRow(inComponent: 1)]
        
        ad.saveContext()
        _ = navigationController?.popViewController(animated: true)
    }
    
    func loadItemData() {
        
        if let item = itemToEdit {
            titleTextField.text = item.title
            priceTextField.text = "\(item.price)"
            detailTextField.text = item.details
            thumbImage.image = item.toImage?.image as? UIImage
            
            if let store = item.toStore {
                
                var index = 0
                repeat {
                    
                    let s = stores[index]
                    if s.name == store.name {
                        storePicker.selectRow(index, inComponent: 0, animated: false)
                        break
                    }
                    index += 1
                    
                } while index < stores.count
                
            }
            
            if let itemType = item.toItemType {
                
                var index = 0
                repeat {
                    
                    let s = itemTypes[index]
                    if s.type == itemType.type {
                        storePicker.selectRow(index, inComponent: 1, animated: false)
                        break
                    }
                    index += 1
                    
                } while index < itemTypes.count
                
            }
        }
        
    }
    
    @IBAction func deletePressed(_ sender: AnyObject) {
        
        if itemToEdit != nil {
            context.delete(itemToEdit!)
            ad.saveContext()
        }
        _ = navigationController?.popViewController(animated: true)
        
        
    }
    
    
    @IBAction func addImageButtonTapped(_ sender: AnyObject) {
        present(imagePicker, animated: true, completion: nil)

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            thumbImage.image = image
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    

}
