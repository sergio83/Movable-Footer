//
//  FirstViewController.swift
//  MovableTabbarExample
//
//  Created by Sergio Cirasa on 22/08/14.
//  Copyright (c) 2014 Sergio Cirasa. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var tableView: UITableView!
    
    var movableFooterController: MovableFooterController?
    
// MARK: - Life Cycle Methods
//------------------------------------------------------------------------------------------------------------------------------------------
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Test"
        self.movableFooterController = MovableFooterController(footerView: self.tabBarController!.tabBar ,scrollView: self.tableView,containerView: self.view);
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.movableFooterController?.setContainerViewSizeForNonMovableFooter();
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle
    {
        return UIStatusBarStyle.LightContent;
    }
// MARK: - UITableViewDataSource
//------------------------------------------------------------------------------------------------------------------------------------------
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
            return 50
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
            let kCellIdentifier: String = "CellIdentifier"
            let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier)! as UITableViewCell
            cell.textLabel!.text = "Cell  \(indexPath.row)"
            return cell
    }
// MARK: - UIScrollViewDelegate
//------------------------------------------------------------------------------------------------------------------------------------------
    func scrollViewWillBeginDragging(scrollView: UIScrollView)
    {
        self.movableFooterController?.scrollViewWillBeginDragging(scrollView)
    }
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        self.movableFooterController?.scrollViewWillEndDragging(scrollView,withVelocity: velocity,targetContentOffset: targetContentOffset)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView)
    {
        self.movableFooterController?.scrollViewDidScroll(scrollView)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView)
    {
       self.movableFooterController?.scrollViewDidEndDecelerating(scrollView)
    }
//------------------------------------------------------------------------------------------------------------------------------------------
}

