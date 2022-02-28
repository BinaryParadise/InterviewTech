//
//  ViewController.swift
//  InterviewFlutter
//
//  Created by Rake Yang on 2022/2/11.
//

import UIKit
import Flutter
import CocoaLumberjack
import FlutterPluginRegistrant

class IFFlutterViewController: FlutterViewController {
    deinit {
        print("\(self).\(#function) +\(#line)")
    }
}

class ViewController: UIViewController {
    weak var engine: FlutterEngine?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let app = UIApplication.shared.delegate as? AppDelegate {
            //engine = app.flutterEngine
        }
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(forName: .init(rawValue: "FlutterViewControllerWillDealloc"), object: self, queue: nil) { noti in
            print("will dealloc")
        }
    }

    @IBAction func changed(_ sender: Any) {
        
    }
    
    @IBAction func showFlutter(_ sender: Any) {
        
        var engine = FlutterEngine(name: "new.engine")
        self.engine = engine
        engine.run()
        GeneratedPluginRegistrant.register(with: engine)
        
        let vc = IFFlutterViewController(engine: engine, nibName: nil, bundle: nil)
        let channel = FlutterMethodChannel(name: "native.to.flutter", binaryMessenger: vc.binaryMessenger)
        channel.setMethodCallHandler { call, result in
            if call.method == "openRoute" {
                self.navigationController?.pushViewController(ViewController(), animated: true)
            }
        }
        channel.invokeMethod("setInitialRoute", arguments: "/canary", result: nil)
        vc.modalPresentationStyle = .fullScreen
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "present nav", style: .default, handler: { [weak self] action in
            self?.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "present vc", style: .default, handler: { [weak self] action in
            self?.present(vc, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "push vc", style: .default, handler: { [weak self] action in
            self?.navigationController?.pushViewController(vc, animated: true)
        }))
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { action in
            
        }))
        present(alert, animated: true, completion: nil)
    }
}

