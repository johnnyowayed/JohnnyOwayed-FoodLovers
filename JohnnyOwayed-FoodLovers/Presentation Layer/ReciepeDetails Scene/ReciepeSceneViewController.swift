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
        self.bannerView.rootViewController = self
        self.bannerView.load(GADRequest())
    }
    
    func registerCells() {
        self.tableView.register(UINib(nibName: "StepsTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! StepsTableViewCell
        
        if indexPath.row == 0 {
            cell.label.text = "Ingredients"
            var customText = ""
            for ingredient in item.ingredients {
                customText = customText + "\n- \(ingredient)"
            }
            cell.textView.text = customText
        }else if indexPath.row == 1 {
            cell.label.text = "Directions"
            cell.textView.text = ""
        }else{
            cell.label.text = "Step \(indexPath.row-2)"
            cell.textView.text = item.steps[indexPath.row-2]
        }
        
        return cell
    }
}
