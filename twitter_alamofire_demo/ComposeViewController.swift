//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Shao Yie Soh on 7/6/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
protocol ComposeViewControllerDelegate: class {
    func did(post: Tweet)
    
}



class ComposeViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    weak var delegate: ComposeViewControllerDelegate?

    
    
    @IBAction func exitView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func postTweet(_ sender: Any) {
        if textView.text.characters.count > 140 {
            print ("Too long. Currently " + String(describing: textView.text.characters.count))
        } else {
            if textView.text != nil {
        APIManager.shared.composeTweet(with: textView.text) { (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                self.delegate?.did(post: tweet)
                print("Compose Tweet Success!")
            }
        }
    dismiss(animated:true,completion: nil)
        }
        }
        
    }
    override func viewDidLoad() {

        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 

}
