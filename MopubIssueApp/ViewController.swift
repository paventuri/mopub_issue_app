//
//  ViewController.swift
//  MopubIssueApp
//
//  Created by Paulo Arthur Venturi on 11/11/14.
//  Copyright (c) 2014 Paulo A Venturi. All rights reserved.
//

import UIKit
import MoPub

class ViewController: UIViewController, MPAdViewDelegate {
    
    // TODO: Replace this test id with your personal ad unit id
    var adView: MPAdView = MPAdView(adUnitId: "bca65d9e7fe64b50b8cc82b2ec47fb62", size: MOPUB_BANNER_SIZE)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.adView.delegate = self
        self.adView.frame = CGRectMake(0, self.view.bounds.size.height - MOPUB_BANNER_SIZE.height,
            MOPUB_BANNER_SIZE.width, MOPUB_BANNER_SIZE.height)
        self.view.addSubview(self.adView)
        self.loadAdIfReachable()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadAdIfReachable(){
        if Network.isConnected() {
            // Network is connected ...
            self.adView.loadAd()
        } else {
            // No network -- do something truly amazing...
        }
    }
    
    func adViewDidFailToLoadAd(view: MPAdView!) {
        // ISSUE
        // There is still an issue loading the ads e.g. Timeout Error....
        println(Network.carrier())
        println(Network.isConnected())
        println(Network.isReachable())
    }

    func viewControllerForPresentingModalView() -> UIViewController {
        return self
    }

}

