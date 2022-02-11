//
//  ViewController.swift
//  InterviewFlutter
//
//  Created by Rake Yang on 2022/2/11.
//

import UIKit
import Flutter

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func showFlutter(_ sender: Any) {
        if let app = UIApplication.shared.delegate as? AppDelegate {
            let vc = FlutterViewController(engine: app.flutterEngine, nibName: nil, bundle: nil)
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
    }
}

