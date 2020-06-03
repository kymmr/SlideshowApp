//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 吉田 玲子 on 2020/05/25.
//  Copyright © 2020 reiko.yoshida. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var slideImage: UIImageView!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var timer: Timer!
    var counter: Int = 0
    let imageList: Array<String> = ["fox.jpg", "koala.jpg", "parrots.jpg"]
    var maxCount: Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        maxCount = imageList.count
        
        //ボタンにスタイルを当てる
        buttonStyle(prevButton, true)
        buttonStyle(playButton, true)
        buttonStyle(nextButton, true)
    }
    
    @IBAction func prevButton(_ sender: Any) {
        counter -= 1
        setSlideImage(self.counter)
    }
    
    @IBAction func nextButton(_ sender: Any) {
        counter += 1
        setSlideImage(self.counter)
    }
    
    @IBAction func playButton(_ sender: Any) {
        if self.timer == nil {
            //スライドショー開始
            self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(slideShow(_:)), userInfo: nil, repeats: true)
            
            //ボタン切り替え
            playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            buttonStyle(prevButton, false)
            buttonStyle(nextButton, false)
        } else {
            //スライドショー停止
            self.timer.invalidate()
            self.timer = nil
            
            //ボタン切り替え
            playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            buttonStyle(prevButton, true)
            buttonStyle(nextButton, true)
        }
    }
    
    @objc func slideShow(_ timer: Timer) {
        self.counter += 1
        setSlideImage(self.counter)
    }
    
    //操作ボタンのスタイル
    func buttonStyle(_ button:UIButton, _ isEnabled:Bool) -> () {
        
        if (isEnabled) {
            button.isEnabled = true
            button.tintColor = UIColor(named: "Button")
        } else {
            button.isEnabled = false
            button.tintColor = UIColor(named: "Button.Disabled")
        }
        
        button.layer.cornerRadius = 32
        button.layer.shadowColor = UIColor(named: "Button")?.cgColor.copy(alpha: 0.24)
        button.layer.shadowOpacity = 1 //影の色の透明度
        button.layer.shadowRadius = 16 //影のぼかし
        button.layer.shadowOffset = CGSize(width: 0, height: 0) //影の位置
    }
    
    // 画像をセット
    func setSlideImage (_ counter:Int) {
        
        // 1周しつづけるようにする
        if self.counter >= maxCount {
             self.counter = 0
         } else if self.counter < 0 {
             self.counter = maxCount - 1
         }
            
        // フェードイン・アウトのアニメーション
        UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions.allowUserInteraction, animations: {
            self.slideImage.alpha = 0.01
        })
        UIView.animate(withDuration: 0.4, delay: 0.2, options: UIView.AnimationOptions.allowUserInteraction, animations: {
            self.slideImage.alpha = 1
            self.slideImage.image = UIImage(named: self.imageList[self.counter])
        })
    }
    
    // 画像をタップしたら遷移させる
    @IBAction func onTapImage(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "fullscreen", sender: nil)
        if self.timer != nil {
                   //スライドショー停止
                   self.timer.invalidate()
                   self.timer = nil
                   
                   //ボタン切り替え
                   playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
                   buttonStyle(prevButton, true)
                   buttonStyle(nextButton, true)
               }
    }
    
    //FullscreenViewControllerに画像を渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let FullScreenViewController:FullScreenViewController = segue.destination as! FullScreenViewController

        FullScreenViewController.photo = slideImage.image
    }
    
    //遷移先から戻ってくるときに呼ばれるメソッド
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
    }
    
}
