//
//  SecondViewController.swift
//  ARKitVisionObjectDetection
//
//  Created by Vladislav Luchnikov on 2021-03-29.
//  Copyright © 2021 Rozengain. All rights reserved.
//

import UIKit
import SwiftUI

class SwiftUIViewHostingController: UIHostingController<ContentView> {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: ContentView())
    }
}

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    //    let contentView1 = UIHostingController(rootView: testView())
//    @IBSegueAction func addSwiftUI(_ coder: NSCoder) -> UIViewController? {
//    return UIHostingController(coder: coder, rootView: testView())
//    }

}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


