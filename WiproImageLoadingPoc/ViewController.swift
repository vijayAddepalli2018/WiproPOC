//
//  ViewController.swift
//  WiproImageLoadingPoc
//  Copyright © 2018 Vijay. All rights reserved.
//

import UIKit
import SDWebImage
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let countryContactsTableView = UITableView()
    var refreshCtrl: UIRefreshControl!
    var tableData: [Row] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(countryContactsTableView)
        setUpContraintsForTableView()
        initiliseTableView()
        dragToRefresh()
        self.fetchTableViewData()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    /// Set up contraints for TableView to work in any device
    fileprivate func setUpContraintsForTableView() {
         let marginGuide = view.layoutMarginsGuide
        countryContactsTableView.translatesAutoresizingMaskIntoConstraints = false
        countryContactsTableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        countryContactsTableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        countryContactsTableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        countryContactsTableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
        countryContactsTableView.topAnchor.constraint(equalTo:marginGuide.topAnchor).isActive = true
        countryContactsTableView.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        countryContactsTableView.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        countryContactsTableView.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
    }
    
    /// Initial set up table view
    fileprivate func initiliseTableView() {
        countryContactsTableView.delegate = self
        countryContactsTableView.dataSource = self
        countryContactsTableView.register(TableViewCell.self, forCellReuseIdentifier: "contactCell")
    }
    
    /// When pull down in tableview then we make service call to refersh
    fileprivate func dragToRefresh() {
        self.refreshCtrl = UIRefreshControl()
        self.refreshCtrl.addTarget(self, action: #selector(ViewController.fetchTableViewData), for: .valueChanged)
        if #available(iOS 10.0, *) {
            self.countryContactsTableView.refreshControl = self.refreshCtrl
        } else {
            countryContactsTableView.addSubview(self.refreshCtrl)
        }
    }
    
    /// Calls network manager genric function to pull data from web
    @objc func fetchTableViewData () {
        
        if ConnectivityManager.isConnectedToInternet {
            NetworkManager.sharedInstance.fetchGenericData(urlString: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json") { [weak self] (country: Welcome?, sucess) in
                guard let strongSelf = self else {
                    return
                }
                if sucess {
                    guard let unWrappedCountry = country else {
                        return
                    }
                    let cleanedData = unWrappedCountry.rows.filter({ (row) -> Bool in
                        if row.description != nil && row.title != nil {
                            return true
                        }
                        return false
                    })
                    strongSelf.tableData = cleanedData
                    DispatchQueue.main.async {
                        strongSelf.title = unWrappedCountry.title
                        strongSelf.countryContactsTableView.reloadData()
                        if #available(iOS 10.0, *) {
                            strongSelf.countryContactsTableView.refreshControl?.endRefreshing()
                        } else {
                            strongSelf.refreshCtrl.endRefreshing()
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        strongSelf.showAlert(message: "There was an error processing your request")
                    }
                }
            }
        } else {
            self.showAlert(message: "There was an error processing your request")
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! TableViewCell
        cell.nameLabel.text = tableData[indexPath.row].title
        cell.detailLabel.text = tableData[indexPath.row].description
        let imageUrl = URL.init(string: tableData[indexPath.row].imageHref ?? "")
        cell.countryImageView.sd_setShowActivityIndicatorView(true)
        cell.countryImageView.sd_setIndicatorStyle(.gray)
        // Used SD web image for async load and cache
        cell.countryImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage.init(named: "placeholder"), options: [.progressiveDownload])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return tableData.count
        return tableData.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    /// Display alert if service call retunr false in completion block
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
            }}))
        self.present(alert, animated: true, completion: nil)
    }
    
}

