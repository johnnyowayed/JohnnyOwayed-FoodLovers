//
//  ReciepeSceneViewController.swift
//  JohnnyOwayed-FoodLovers
//
//  Created by Georges on 11/5/21.
//

import UIKit
import GoogleMobileAds

final class ReciepeSceneViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView_Header: UIImageView!
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var removeAdButton: UIButton!
    @IBOutlet var bannerViewHeight: NSLayoutConstraint!
    
    var item = ReceipeSceneModel(imageUrl: "",title: "", ingredients: [], steps: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.registerCells()
    }
    
    func setupUI() {
        
        self.imageView_Header.contentMode = .scaleAspectFill
        let supportingUrl = item.imageUrl.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
        let url = URL(string: supportingUrl)
        self.imageView_Header.kf.setImage(with: url)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        
        self.title = item.title.capitalized
        
        self.bannerView.delegate = self
        self.bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
    }
    override func viewWillAppear(_ animated: Bool) {
        let adRemovalPurchased = UserDefaults.standard
        if !adRemovalPurchased.bool(forKey: "adRemoved") {
            bannerView.rootViewController = self
            bannerView.load(GADRequest())
            print("There is a banner!")
        } else {
            bannerView.isHidden = true
            bannerViewHeight.constant = 0
            self.removeAdButton.isHidden = true
            print("There is no banner")
        }
    }
    
    func registerCells() {
        self.tableView.register(UINib(nibName: "StepsTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        self.tableView.register(UINib.init(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "Header")
    }
    
    @IBAction func removeAdsButtonPressed(_ sender: Any) {
        self.alert(message: "Are you sure you want to pay 2.99$ to remove the ads?") {
            let adRemovalPurchased = UserDefaults.standard
            adRemovalPurchased.set(true, forKey: "adRemoved")
            adRemovalPurchased.synchronize()
            self.bannerView.isHidden = true
            self.removeAdButton.isHidden = true
            self.bannerViewHeight.constant = 0
        }
    }
}

extension ReciepeSceneViewController: GADBannerViewDelegate {
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("bannerViewDidReceiveAd")
    }
    
    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
        print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
}

extension ReciepeSceneViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 + item.steps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var mainCell = UITableViewCell()
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! StepsTableViewCell
            cell.label.text = "Ingredients"
            var customText = ""
            for ingredient in item.ingredients {
                customText = customText + "\n- \(ingredient)"
            }
            cell.textView.text = customText
            mainCell = cell
        }else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Header") as! HeaderTableViewCell
            cell.label.text = "Directions"
            mainCell = cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! StepsTableViewCell
            cell.label.text = "Step \(indexPath.row-2)"
            cell.textView.text = item.steps[indexPath.row-2]
            mainCell = cell
        }
        return mainCell
    }
}
