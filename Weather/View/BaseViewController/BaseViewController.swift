//
//  BaseViewController.swift
//  Weather
//
//  Created by Bodya on 27.02.2018.
//  Copyright © 2018 Bodya. All rights reserved.
//

import UIKit
import SideMenu

class BaseViewController: UIViewController, PageBehaviorDelegate {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var containerView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.isUserInteractionEnabled = false
        SideMenuManager.default.menuFadeStatusBar = false
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PageViewController {
            vc.pageBehaviorDelegate = self
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func didPageUpdate(pageViewController: UIPageViewController, currentIndex: Int) {
        pageControl.currentPage = currentIndex
    }

}
