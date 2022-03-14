//
//  NetworkViewController.swift
//  InterviewUI
//
//  Created by rakeyang on 2022/3/14.
//

import UIKit
import Starscream

class NetworkViewController: UIViewController {

    lazy var webSocket = WebSocket(url: URL(string: "ws://121.40.165.18:8800")!)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        webSocket.connect()
    }
    
    deinit {
        webSocket.disconnect()
    }

}
