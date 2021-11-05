//
//  HomeSceneViewController.swift
//  JohnnyOwayed-FoodLovers
//
//  Created by Georges on 11/5/21.
//

import Foundation
import UIKit
import Kingfisher
import GoogleMobileAds

protocol PresenterOutput {
    func presenterOutput(viewModel: [HomeSceneModel.ViewModel.Categories])
}

final class HomeSceneViewController: UIViewController, PresenterOutput {
    var interactor: HomeSceneInteractorImplementation?
    var router: HomeSceneRouterImplementation?
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var removeAdsButton: UIButton!
    
    private var viewModel: [HomeSceneModel.ViewModel.Categories] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
        self.setupUI()
        self.registerCell()
        self.interactor?.fetchFoods()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func setupUI() {
        self.title = "Food Lovers"
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.bannerView.delegate = self
        self.bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        self.bannerView.rootViewController = self
        self.bannerView.load(GADRequest())
        
        self.removeAdsButton.setImage(UIImage.init(named: "RemoveAdsBtn"), for: .normal)
    }
    
    func registerCell() {
        self.collectionView.register(UINib(nibName: "FoodItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        self.collectionView.register(UINib(nibName: "SectionHeader", bundle: nil), forCellWithReuseIdentifier: "Header")
    }
    @IBAction func removeAdsButtonPressed(_ sender: Any) {
        self.alert(message: "Are you sure you want to pay 2.99$ to remove the ads?") {
            print()
        }
    }
}

//MARK: Ads Banner Delegates

extension HomeSceneViewController: GADBannerViewDelegate {
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
      print("bannerViewDidReceiveAd")
    }

    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
      print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
}


extension HomeSceneViewController {
    func presenterOutput(viewModel: [HomeSceneModel.ViewModel.Categories]) {
        self.viewModel = viewModel
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension HomeSceneViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! FoodItemCollectionViewCell
        
        
        let items = self.viewModel[indexPath.section].categories
        
        cell.title_Label.text = items[indexPath.row].name
        cell.subtitle1_Label.text = items[indexPath.row].timeToPrepare
        cell.subtitle2_Label.text = items[indexPath.row].smallDescrition
        
        let supportingUrl = items[indexPath.row].imageUrl.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
        let url = URL(string: supportingUrl)
        cell.image_ImageView.kf.setImage(with: url)
        
        cell.layer.cornerRadius = 8
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.masksToBounds = true

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel[section].categories.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.frame.width-16)/2
        return CGSize(width: width, height: 250)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width:collectionView.frame.size.width, height:40)
    }
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//
////        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as? SectionHeader{
////            sectionHeader.sectionHeaderlabel.text = self.viewModel[indexPath.section].categoryName
////            return sectionHeader
////        }
//        return UICollectionReusableView()
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let item = self.viewModel[indexPath.section].categories[indexPath.row]
        
        self.router?.goToReceipeDetails(item: ReceipeSceneModel.init(imageUrl: item.imageUrl, title: item.name, ingredients: item.ingredients, steps: item.steps))
    }
}

//MARK: - Clean Swift Setup
extension HomeSceneViewController {
    func setup() {
        let viewController = self
        let presenter = HomeScenePresenterImplementation()
        let interactor = HomeSceneInteractorImplementation()
        let router = HomeSceneRouterImplementation()
        let webService = WebServiceServiceRequest()
        viewController.interactor = interactor
        viewController.router = router
        interactor.webService = webService
        interactor.presenter = presenter
        presenter.homeSceneViewController = viewController
        router.navigationController = self.navigationController
    }
}

class SectionHeader: UICollectionReusableView {
//    @IBOutlet weak var sectionHeaderlabel: UILabel!
}


