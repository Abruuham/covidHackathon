//
//  ViewController.swift
//  covidHackathon
//
//  Created by Abraham Calvillo on 3/28/20.
//  Copyright © 2020 AbrahamCalvillo. All rights reserved.
//

import UIKit
import Foundation
import MapKit
import Alamofire
import SwiftyJSON


class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CLLocationManagerDelegate{
    
    
    
    //******************************
    // MARK: Variables
    //******************************
    
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    
    var location: CLLocation?
    var placemark: CLPlacemark?
    lazy var refreshControl = UIRefreshControl()
    private let cellIdentifier = "itemCell"
   
    
    @IBOutlet weak var worldActive: UILabel!
    @IBOutlet weak var usActive: UILabel!
    
    @IBOutlet weak var worldRecovered: UILabel!
    @IBOutlet weak var usRecovered: UILabel!
    
    @IBOutlet weak var usDeaths: UILabel!
    @IBOutlet weak var worldDeaths: UILabel!
    @IBOutlet weak var guidesView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var mainCollection: UICollectionView!
    @IBOutlet weak var testingView: UIView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var dateSection: UILabel!
    @IBOutlet weak var virus: UIImageView!
    @IBOutlet weak var mainScroll: UIScrollView!
    
    //******************************
    // MARK: Main View
    //******************************
    override func viewDidLoad() {
        super.viewDidLoad()
        let authStatus = CLLocationManager.authorizationStatus()
        if authStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        if authStatus == .denied || authStatus == .restricted {
            // add any alert or inform the user to to enable location services
        }
        startLocationManager()
        
        mainCollection.delegate = self
        mainCollection.dataSource = self
        mainScroll.contentInsetAdjustmentBehavior = .never
        setupView()
        getData()
        
        
        let kRotationAnimationKey = "com.myapplication.rotationanimationkey"
        
        func rotateView(view: UIView, duration: Double = 18) {
            if view.layer.animation(forKey: kRotationAnimationKey) == nil {
                let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
                
                rotationAnimation.fromValue = 0.0
                rotationAnimation.toValue = Float(Double.pi * 2.0)
                rotationAnimation.duration = duration
                rotationAnimation.repeatCount = Float.infinity
                
                view.layer.add(rotationAnimation, forKey: kRotationAnimationKey)
            }
        }
        rotateView(view: self.virus)
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self,action: #selector(ViewController.refresh), for: UIControl.Event.valueChanged)
        self.mainScroll.addSubview(refreshControl)
        
        
        
    }
    
    @objc func refresh(sender: AnyObject!){
        getData()
        refreshControl.endRefreshing()
    }
    
    
    func getData(){
       let urlUS = "https://thevirustracker.com/free-api?countryTotal=US"
       let urlWorld = "https://thevirustracker.com/free-api?global=stats"
        
        AF.request(urlUS).responseJSON{ response in
            switch response.result{
            case .success(let value):
                let json = JSON(value)
               for item in json["countrydata"].arrayValue {
                
                self.usActive.text = "\(item["total_cases"].intValue)"
                self.usRecovered.text = "\(item["total_recovered"].intValue)"
                self.usDeaths.text = "\(item["total_deaths"].intValue)"
                }
                

            case .failure(let error):
                print(error)
            }
        }
        AF.request(urlWorld).responseJSON{ response in
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                   for item in json["results"].arrayValue {
                    
                    self.worldActive.text = "\(item["total_cases"].intValue)"
                    self.worldRecovered.text = "\(item["total_recovered"].intValue)"
                    self.worldDeaths.text = "\(item["total_deaths"].intValue)"
                    }
                    

                case .failure(let error):
                    print(error)
                }
            }
            
           
            
          
            
           
            
            
          
    }
    
    
    
    //******************************
    // MARK: Setup View
    //******************************
    func setupView(){
        
        
        // Header Section Setup
        headerView.backgroundColor = headerColor
        headerImage.image = UIImage(named: "femaleDr")
        makePath(myView: headerView)
        
        
        // Testing Location Setup
        testingView.backgroundColor = lightBlue
        testingView.layer.cornerRadius = 15
        testingView.layer.shadowColor = UIColor.lightGray.cgColor
        testingView.layer.shadowRadius = 10
        testingView.layer.shadowOpacity = 0.2
        testingView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        // Guides View Setup
        guidesView.layer.cornerRadius = 15
        guidesView.layer.shadowColor = UIColor.lightGray.cgColor
        guidesView.layer.shadowRadius = 10
        guidesView.layer.shadowOpacity = 0.2
        guidesView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        // Set Date
        let monthFormatter = DateFormatter()
        let date = Date()
        monthFormatter.dateFormat = "MMM. dd, YYYY"
        dateSection.text = "\(monthFormatter.string(from: date))"
        
        
    }
    
    //******************************
    // MARK: Setup Collection View
    //******************************
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width: 220, height: 150)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        COLLECTION_LIST.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mainCollection.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ItemCell
        cell.backgroundColor = lightBlue
        cell.cellView.backgroundColor = lightBlue
        cell.layer.cornerRadius = 15
        cell.cellText.text = COLLECTION_LIST[indexPath.row].title
        cell.cell_Image.image = COLLECTION_LIST[indexPath.row].backgroundImage
        
        return cell
    }
    
    
    //******************************
    // MARK: Location Settings
    //******************************
    
    
    func startLocationManager() {
        // always good habit to check if locationServicesEnabled
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    func stopLocationManager() {
        locationManager.stopUpdatingLocation()
        locationManager.delegate = nil
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // print the error to see what went wrong
        print("didFailwithError\(error)")
        // stop location manager if failed
        stopLocationManager()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // if you need to get latest data you can get locations.last to check it if the device has been moved
        let latestLocation = locations.last!
        
        // here check if no need to continue just return still in the same place
        if latestLocation.horizontalAccuracy < 0 {
            return
        }
        // if it location is nil or it has been moved
        if location == nil || location!.horizontalAccuracy > latestLocation.horizontalAccuracy{
            
            location = latestLocation
            // stop location manager
            stopLocationManager()
            
            
            location!.fetchCityAndCountry { city, country, error in
                guard let city = city, let country = country, error == nil else { return }
                self.cityName.text = "\(city + ", " + country)"  // your city and state
            }
            
        }
    }
    
    
    //******************************
    // MARK: Make Path
    //******************************
    func makePath(myView: UIView){
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 1.5, y: 222.5))
        bezierPath.addCurve(to: CGPoint(x: 159.5, y: 241.5), controlPoint1: CGPoint(x: 1.5, y: 222.5), controlPoint2: CGPoint(x: 34.5, y: 251.5))
        bezierPath.addCurve(to: CGPoint(x: 396.5, y: 222.5), controlPoint1: CGPoint(x: 284.5, y: 231.5), controlPoint2: CGPoint(x: 358.5, y: 201.5))
        bezierPath.addCurve(to: CGPoint(x: 464.5, y: 208.5), controlPoint1: CGPoint(x: 434.5, y: 243.5), controlPoint2: CGPoint(x: 464.5, y: 208.5))
        bezierPath.addLine(to: CGPoint(x: 464.5, y: -20.5))
        bezierPath.addLine(to: CGPoint(x: -23.5, y: -20.5))
        bezierPath.addLine(to: CGPoint(x: -23.5, y: 173.5))
        bezierPath.addLine(to: CGPoint(x: 1.5, y: 222.5))
        bezierPath.close()
        
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezierPath.cgPath
        
        myView.layer.mask = shapeLayer
    }
    
    
    
}



