//
//  CodesVC.swift
//  DecodersDemo
//
//  Created by Varender Singh on 17/02/19.
//  Copyright © 2019 Varender Singh. All rights reserved.
//

import UIKit

class CodesVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UIPickerViewDataSource,UIPickerViewDelegate,UISearchBarDelegate {
    var btnClicked:Int = 0
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewUnderPicker: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var btnTrending: UIButton!
    @IBOutlet weak var btnAll: UIButton!
    
    var array = NSMutableArray();
    var arrayFiltered = NSMutableArray();
    var arrayAll = NSArray();
    var arrayTrending = NSArray();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.showsCancelButton = true
         self.viewUnderPicker.isHidden  = true
        arrayTrending = ["TRENDING","MOST POPULAR","RECENT","MYCODES"];
        arrayAll = ["ALL","JAVA","C++","C#","PYTHON","SWIFT","OBJECTIVE-C"];
         let objFileToDownload = FIleToDownloadData();
        let activityView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityView.center = self.view.center
        activityView.startAnimating()
        self.view.addSubview(activityView)
        objFileToDownload.downloadCodes { (arrayData) in
            self.array = arrayData;
            DispatchQueue.main.async {
                self.tableView.reloadData()
                activityView.removeFromSuperview()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    
    }
    

    
    //MARK:- <Table View DataSource>
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CodesTVC = self.tableView.dequeueReusableCell(withIdentifier: "Cell-Identifier", for: indexPath) as! CodesTVC;
        let code = self.array[indexPath.row];
        cell.putDataInFields(code: code as! Code);
        return cell;
    }
    
   
    
    func hideOrShowPicker() {
        if(!self.viewUnderPicker.isHidden) {
            if(btnClicked == 0)  {
                let row = arrayTrending.index(of: btnTrending.titleLabel?.text);
                pickerView.selectRow(row, inComponent: 0, animated: false);
            }
            else {
                let row = arrayAll.index(of: btnAll.titleLabel?.text);
               pickerView.selectRow(row, inComponent: 0, animated: false);
            }
        }
        self.viewUnderPicker.isHidden = !self.viewUnderPicker.isHidden;
    }
    
    
    //MARK:- <UIPickerViewDataSource>
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(btnClicked == 0)  {
            return arrayTrending.count;
        }
        else {
            return arrayAll.count;
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        if(btnClicked == 0)  {
            return arrayTrending[row] as? String;
        }
        else {
            return arrayAll[row] as? String;
        }
    }
    
    
    //MARK:- ACTIONS
    @IBAction func doneBtnClicked(_ sender: Any) {
        if(btnClicked==0)  {
            let row = pickerView.selectedRow(inComponent: 0);
            self.btnTrending.setTitle(arrayTrending[row] as? String, for: UIControlState.normal);
        }
        else {
            let row = pickerView.selectedRow(inComponent: 0);
            self.btnAll.setTitle(arrayAll[row] as? String, for: UIControlState.normal);
        }
       self.hideOrShowPicker()
    }
    
    
    @IBAction func cancelBtnClicked(_ sender: Any) {
      self.hideOrShowPicker()
    }
    
    @IBAction func allBtnClicked(_ sender: Any) {
        btnClicked = 0;
        self.hideOrShowPicker();
        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
        self.pickerView.reloadAllComponents();
    }
    
    
    @IBAction func trendingBtnClicked(_ sender: Any) {
        btnClicked = 1;
        self.hideOrShowPicker();
        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
        self.pickerView.reloadAllComponents();
    }
    
    //MARK:- UISearchBarDelegate
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
}
