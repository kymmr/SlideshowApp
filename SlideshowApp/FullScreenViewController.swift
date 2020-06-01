//
//  FullscreenViewController.swift
//  SlideshowApp
//
//  Created by 吉田 玲子 on 2020/05/30.
//  Copyright © 2020 reiko.yoshida. All rights reserved.
//

import UIKit

class FullScreenViewController: UIViewController, UIScrollViewDelegate {

    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    var photo:UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // デリゲートを設定
        self.scrollView.delegate = self
        
        // 最大倍率・最小倍率を設定する
        self.scrollView.maximumZoomScale = 8.0
        self.scrollView.minimumZoomScale = 1.0
        
        // 画像をセットする
        self.imageView.image = photo
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    func zoomForScale(scale:CGFloat, center: CGPoint) -> CGRect{
        var zoomRect: CGRect = CGRect()
        zoomRect.size.height = self.scrollView.frame.size.height / scale
        zoomRect.size.width = self.scrollView.frame.size.width  / scale
        zoomRect.origin.x = center.x - zoomRect.size.width / 2.0
        zoomRect.origin.y = center.y - zoomRect.size.height / 2.0
        return zoomRect
    }

}
