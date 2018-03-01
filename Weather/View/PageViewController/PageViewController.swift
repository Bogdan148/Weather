//
//  PageViewController.swift
//  Weather
//
//  Created by Bodya on 26.02.2018.
//  Copyright © 2018 Bodya. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    weak var pageBehaviorDelegate : PageBehaviorDelegate?
    
    private var getViewControllers =
        [
        UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier:"DetailViewController"),
        UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier:"CitiesView")
        ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        if let firstVC = getViewControllers.first {
            self.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }

    
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        let vcIndex = getViewControllers.index(of: pendingViewControllers.first!)
        pageBehaviorDelegate?.didPageUpdate(pageViewController: pageViewController, currentIndex: vcIndex!)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = getViewControllers.index(of: viewController) else {
            return nil
        }
        pageBehaviorDelegate?.didPageUpdate(pageViewController: pageViewController, currentIndex: vcIndex)
        let nextIndex = vcIndex - 1
        if nextIndex >= 0 {
            return getViewControllers[nextIndex]
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = getViewControllers.index(of: viewController) else {
            return nil
        }
        pageBehaviorDelegate?.didPageUpdate(pageViewController: pageViewController, currentIndex: vcIndex)
        
        let nextIndex = vcIndex + 1
        if nextIndex != getViewControllers.count {
            return getViewControllers[nextIndex]
        }
        return nil
    }
}

@objc protocol PageBehaviorDelegate : class {
    
    @objc optional func pageCount(pageViewController : UIPageViewController, pageCount : Int)
    func didPageUpdate(pageViewController : UIPageViewController, currentIndex : Int)
}

