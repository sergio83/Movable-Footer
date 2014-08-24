//
//  MovableFooterController.swift
//  MovableTabbarExample
//
//  Created by Sergio Cirasa on 23/08/14.
//  Copyright (c) 2014 Sergio Cirasa. All rights reserved.
//

import Foundation
import UIKit

public class MovableFooterController : NSObject
{
    private let animationDuration = 0.22
    private var footerView:UIView
    private var scrollView:UIScrollView
    private var containerView:UIView
    private var isDragging = false
    private var screenHeight:CGFloat = 0.0
    private var lastOffset:CGFloat = 0.0
    private var originY:CGFloat = 0.0
    private var translation:CGFloat = 0.0
    private var footerHeight:CGFloat = 0.0
    

    init(footerView:UIView,scrollView:UIScrollView,containerView:UIView)
    {        
        self.footerView = footerView
        self.scrollView = scrollView
        self.containerView = containerView
        self.originY = self.footerView.frame.origin.y;
        self.screenHeight =  UIScreen.mainScreen().bounds.size.height;
        self.footerHeight = self.footerView.frame.size.height
        self.scrollView.contentInset = UIEdgeInsetsMake(0, 0,self.footerHeight,0);        
        super.init()
    }
    
// MARK: - Public Methods
//------------------------------------------------------------------------------------------------------------------------------------------
    public func updateScrollView(scrollView:UIScrollView){
        self.scrollView = scrollView;
        self.scrollView.contentInset = UIEdgeInsetsMake(0, 0,self.footerHeight,0);
    }
    
    public func setContainerViewSizeForMovableFooter (){
    self.containerView.frame.size.height = self.screenHeight;
    }
    
    public func setContainerViewSizeForNonMovableFooter(){
        UIView.animateWithDuration(animationDuration, animations: {
            self.containerView.frame.size.height = self.screenHeight - self.footerHeight;
            }, completion: {(value: Bool) in})
        showFooter()
    }
    
// MARK: - Private Methods
//------------------------------------------------------------------------------------------------------------------------------------------
    private func showFooter()
    {
        UIView.animateWithDuration(animationDuration, animations: {
            self.footerView.frame.origin.y = self.screenHeight - self.footerHeight;
            self.footerView.alpha   = 1.0;
        }, completion: {(value: Bool) in})
    }
    
    private func hideFooter()
    {
        UIView.animateWithDuration(animationDuration, animations: {
            self.footerView.frame.origin.y  = self.screenHeight;
            self.footerView.alpha   = 0.5;
        }, completion: {(value: Bool) in
            self.footerView.alpha   = 0.0;
        })
    }
    
// MARK: - UIScrollViewDelegate
//------------------------------------------------------------------------------------------------------------------------------------------
    public func scrollViewWillBeginDragging(scrollView: UIScrollView!)
    {
        if(scrollView.frame.size.height<scrollView.contentSize.height){
            self.isDragging = true;
            self.lastOffset = scrollView.contentOffset.y;
        }
    }
    
    public func scrollViewWillEndDragging(scrollView: UIScrollView!, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
    {
        self.isDragging = false;
        let y = targetContentOffset.memory.y + scrollView.bounds.size.height - scrollView.contentInset.bottom;
        let h = scrollView.contentSize.height;
        if(y <= h ) {
            if (y >= h - self.footerHeight || velocity.y<0 || (velocity.y==0 && self.translation<0)) {
                showFooter();
            } else {
                hideFooter();
            }
        }
    }
    
    public func scrollViewDidScroll(scrollView: UIScrollView!)
    {
        if(self.isDragging == true){
            let y = self.scrollView.contentOffset.y + scrollView.bounds.size.height;
            let h = scrollView.contentSize.height;
            if(y >= h - self.footerHeight) {
                
                if(self.lastOffset-self.scrollView.contentOffset.y<=0){
                    var yy = self.screenHeight - (y-h);
                    if(yy < self.screenHeight-self.footerHeight){
                        yy=self.screenHeight-self.footerHeight
                    }
                    
                    self.footerView.frame.origin.y =  yy;
                }
            }else{
                self.translation = scrollView.contentOffset.y - self.lastOffset;
                if(self.footerView.frame.origin.y + self.translation > self.footerHeight+self.originY){
                    self.footerView.frame.origin.y = self.footerHeight+self.originY;
                }else if(self.footerView.frame.origin.y + self.translation < self.originY){
                    self.footerView.frame.origin.y = self.originY;
                }else{
                    self.footerView.frame.origin.y = self.footerView.frame.origin.y + self.translation;
                }
            }
        }
        self.footerView.alpha = (self.footerView.frame.origin.y  == self.screenHeight) ? 0 : 1;
        self.lastOffset = scrollView.contentOffset.y;
    }
    
    public func scrollViewDidEndDecelerating(scrollView: UIScrollView!){
        self.isDragging = false;
    }
    
}