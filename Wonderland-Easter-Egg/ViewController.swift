//
//  ViewController.swift
//  Wonderland-Easter-Egg
//
//  Created by JaminZhou on 2017/3/19.
//  Copyright © 2017年 Hangzhou Tomorning Technology Co., Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let webView = UIWebView(frame: UIScreen.main.bounds)
    let oops = Oops(frame: UIScreen.main.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let htmlPath = Bundle.main.path(forResource: "thanks", ofType: "html")
        let htmlString = try? String(contentsOfFile: htmlPath!, encoding: String.Encoding.utf8)
        webView.frame.size.height = UIScreen.main.bounds.height-64
        webView.backgroundColor = UIColor.white
        view.addSubview(webView)
        webView.loadHTMLString(htmlString!, baseURL: nil)
        webView.scrollView.delegate = self

        oops.frame.origin.y = UIScreen.main.bounds.size.height
        view.addSubview(oops)
    }

}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let tmp = scrollView.contentOffset.y+scrollView.bounds.size.height-scrollView.contentSize.height
        let yep: CGFloat = 280
        if (tmp>0) {
            oops.frame.origin.y = UIScreen.main.bounds.height - tmp
            if (tmp>=yep && oops.frame.origin.y != -250) {
                scrollView.delegate = nil
                scrollView.isScrollEnabled = false
                scrollView.contentInset = UIEdgeInsetsMake(-tmp-(scrollView.contentSize.height-scrollView.bounds.size.height), 0, 0, 0)
                UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
                    self.oops.frame.origin.y = -250
                    self.webView.frame.origin.y = -UIScreen.main.bounds.size.height-250
                }, completion: { (value) in
                    self.title = "Oops"
                })
            }
        } else {
            oops.frame.origin.y = UIScreen.main.bounds.height
        }
    }
}

class Oops: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let circleOriginY: CGFloat = 46
        let circleWidth: CGFloat = 16
        let defaultBlueColor = UIColor(red: 0, green: 141/255.0, blue: 237/255.0, alpha: 1.0)
        
        let circle0 = UIView(frame: CGRect(x: frame.size.width/2-circleWidth/2, y: circleOriginY, width: circleWidth, height: circleWidth))
        circle0.layer.cornerRadius = 8
        circle0.layer.masksToBounds = true
        circle0.layer.borderWidth = 2
        circle0.layer.borderColor = defaultBlueColor.cgColor;
        addSubview(circle0)
        
        let circle1 = UIView(frame: CGRect(x: 4.5, y: 4.5, width: 7, height: 7))
        circle1.layer.cornerRadius = 3.5
        circle1.layer.masksToBounds = true
        circle1.layer.borderWidth = 1
        circle1.layer.borderColor = defaultBlueColor.cgColor
        circle0.addSubview(circle1)
        
        let count = 300
        for i in 1...count {
            let width: CGFloat = 1.5
            let originY = 1.5*(2*CGFloat(i)-1)+circleOriginY+circleWidth
            let circle = UIView(frame: CGRect(x: frame.size.width/2-width/2, y: originY, width: width, height: width))
            circle.backgroundColor = defaultBlueColor
            circle.layer.cornerRadius = width/2
            circle.layer.masksToBounds = true
            addSubview(circle)
        }
        
        let jeff = UIImageView(image: #imageLiteral(resourceName: "Jeff"))
        jeff.frame.origin.x = frame.size.width/2-jeff.frame.size.width/2
        jeff.frame.origin.y = 1.5*(2*100-1)+circleOriginY+circleWidth
        addSubview(jeff)
        
        let attStr0 = NSMutableAttributedString(string: "Jeff designed this App.", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 11, weight: UIFontWeightLight),NSForegroundColorAttributeName: defaultBlueColor])
        attStr0.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 11, weight: UIFontWeightMedium), range: NSRange(location: 0, length: 4))
        let label0 = UILabel()
        label0.attributedText = attStr0
        label0.sizeToFit()
        label0.center = CGPoint(x: frame.size.width/2, y: jeff.center.y+70)
        addSubview(label0)
        
        let jamin = UIImageView(image: #imageLiteral(resourceName: "JaminZhou"))
        jamin.center = CGPoint(x: frame.size.width/2, y: jeff.center.y+235)
        addSubview(jamin)

        let attStr1 = NSMutableAttributedString(string: "Jamin developed this App.", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 11, weight: UIFontWeightLight),NSForegroundColorAttributeName: UIColor(red: 1, green: 179/255.0, blue: 19/255.0, alpha: 1.0)])
        attStr1.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 11, weight: UIFontWeightMedium), range: NSRange(location: 0, length: 5))
        let label1 = UILabel()
        label1.attributedText = attStr1
        label1.sizeToFit()
        label1.center = CGPoint(x: frame.size.width/2, y: jamin.center.y+70)
        addSubview(label1)
        
        let view0 = UIView(frame: CGRect(x: 0, y: 0, width: label0.frame.size.width, height: label0.frame.size.height+10))
        view0.backgroundColor = UIColor.white
        view0.center = label0.center
        insertSubview(view0, belowSubview: label0)
        
        let view1 = UIView(frame: CGRect(x: 0, y: 0, width: label1.frame.size.width, height: label1.frame.size.height+10))
        view1.backgroundColor = UIColor.white
        view1.center = label1.center
        insertSubview(view1, belowSubview: label1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

