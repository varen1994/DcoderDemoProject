//
//  CodesVC.swift
//  DecodersDemo
//
//  Created by Varender Singh on 17/02/19.
//  Copyright © 2019 Varender Singh. All rights reserved.
//

import UIKit


class ChatVC:UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
  
    @IBOutlet var textFiled: UITextField!
    @IBOutlet var bottomConstraintTextView: NSLayoutConstraint!
    var array = NSMutableArray()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var lblDevChat: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let objFileToDownload = FIleToDownloadData();
        self.tableView.delegate = self;
        self.textFiled.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.estimatedRowHeight = 70.0
        let activityView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityView.center = self.view.center
        activityView.startAnimating()
        self.view.addSubview(activityView)
        objFileToDownload.downloadChat { (arrayData) in
            self.array = arrayData;
            DispatchQueue.main.async {
                 self.lblDevChat.isHidden = true;
                 self.tableView.reloadData()
                 activityView.removeFromSuperview()
            }
        }
        self.addKeyboardObservers()
    }
    
    func addKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(keyBoardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyBoardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    @objc func keyBoardWillShow(notification:Notification)  {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame: NSValue = userInfo.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
         bottomConstraintTextView.constant = keyboardHeight-40
    }
    
    @objc func keyBoardWillHide(note:Notification)  {
        bottomConstraintTextView.constant = 11.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Mark: <Table View DataSource>
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.array.count;
    }
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chat = array[indexPath.row] as! Chat
        var cell = UITableViewCell();
        if(chat.is_sent_by_me)!  {
          cell = tableView.dequeueReusableCell(withIdentifier: "Cell-Identifier-2", for: indexPath);
        }
        else {
          cell = tableView.dequeueReusableCell(withIdentifier: "Cell-Identifier", for: indexPath);
        }
        let imageView = cell.contentView.viewWithTag(101) as! UIImageView
        let label1 = cell.contentView.viewWithTag(102) as! UILabel
        let label2 = cell.contentView.viewWithTag(103) as! UILabel
      
        do {
            if(chat.user_image_url != nil)  {
                let data = try NSData.init(contentsOf: URL.init(string: chat.user_image_url!)!) as Data
              imageView.image = UIImage.init(data: data)
            }
        }
        catch let error {
            print(error.localizedDescription)
        }
        imageView.layer.cornerRadius = imageView.layer.frame.size.height/2
        imageView.clipsToBounds = true
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        label1.text = chat.user_name
        label2.text = chat.text
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension;
    }
    
    //Mark: ACTIONS
    @IBAction func sendBtnClicked(_ sender: Any) {
        let chat = Chat();
        if(textFiled.text?.count != 0)  {
            chat.is_sent_by_me = true;
            chat.text = self.textFiled.text;
            chat.user_image_url = "http://dcoder.tech/avatar/dev7.png";
            chat.user_name = "Decoder";
            array.add(chat)
            self.tableView.reloadData()
            textFiled.text = ""
            textFiled.endEditing(true)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textFiled.endEditing(true)
        return true
    }
    
}
