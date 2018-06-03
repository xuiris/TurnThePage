//
//  ImageViewController.swift
//  MicrophoneAnalysis
//
//  Created by Iris Xu on 6/2/18.
//  Copyright © 2018 AudioKit. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    var index: Int = 0;
    var pageViewController : UIPageViewController?
    
    @IBOutlet weak var imageView: UIImageView!

    @IBAction func NextClicked(_ sender: Any) {
        index += 1
        self.imageView.image = UIImage(named: Constants.Statics.images[index])
        if (index == ((Constants.Statics.images.count) - 1)) {
            let disableMyButton = sender as? UIButton
            disableMyButton?.isEnabled = false
        }
    }



    class Constants {
        
        struct Statics {
            static let images = ["jinglebells.jpg","jinglebells.jpg","jinglebells.jpg"]
        }
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initUI();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.hidesBarsOnTap = true;
        self.navigationController?.hidesBarsOnSwipe = true;
        displayPhoto()
        
    }
    
    func initUI() -> Void {
        //        pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        //        pageViewController!.dataSource = self
    }
    
    func displayPhoto() {
        // Decide how the image will display in the UIImageView box
        self.imageView.contentMode = UIViewContentMode.scaleAspectFit
        
        // Load the image
        let image = UIImage(named: Constants.Statics.images[index])
        self.imageView.image = image
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
