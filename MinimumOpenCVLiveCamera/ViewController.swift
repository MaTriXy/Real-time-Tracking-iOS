//
//  ViewController.swift
//  MinimumOpenCVLiveCamera
//
//  Created by Akira Iwaya on 2015/11/05.
//  Copyright © 2015年 akira108. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var start: UIButton!
    @IBOutlet weak var stop: UIButton!
    @IBOutlet weak var mode: UIButton!
    let wrapper = Wrapper()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        start.layer.cornerRadius = 4
        mode.layer.cornerRadius = 4
        stop.layer.cornerRadius = 4
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        wrapper.setTargetView(previewView);
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position :CGPoint = touch.location(in: view)
            wrapper.updateBox(position)
            print(position.x)
            print(position.y)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position :CGPoint = touch.location(in: view)
            wrapper.updateBox(position)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func switchMode(_ sender: Any) {
        wrapper.stop()
        showAlertMenu()
    }

    @IBAction func touchStart(_ sender: Any) {
        wrapper.start()
    }
    
    @IBAction func touchStop(_ sender: Any) {
        wrapper.stop()
    }
    
    func showAlertMenu() {
        
        let alertController = UIAlertController(title: "Mode", message: "Choose a mode", preferredStyle: UIAlertController.Style.alert)
        
        let touch = UIAlertAction(title: "touch tracking", style: UIAlertAction.Style.default) {
            (result : UIAlertAction) -> Void in
            self.wrapper.switchMode(1)
            self.wrapper.start()
        }
        let objectDet = UIAlertAction(title: "object detection", style: UIAlertAction.Style.default) {
            (result : UIAlertAction) -> Void in
            self.showAlertMsg(mode: 2)
        }
        let objectDetMask = UIAlertAction(title: "object detection mask", style: UIAlertAction.Style.default) {
            (result : UIAlertAction) -> Void in
            self.showAlertMsg(mode: 3)
        }
        let opticalFlow = UIAlertAction(title: "optical flow", style: UIAlertAction.Style.default) {
            (result : UIAlertAction) -> Void in
            self.showAlertMsg(mode: 4)
        }
        let cancel = UIAlertAction(title: "cancel", style: UIAlertAction.Style.default) {
            (result : UIAlertAction) -> Void in
            self.wrapper.start()
        }
        
        alertController.addAction(touch)
        alertController.addAction(objectDet)
        alertController.addAction(objectDetMask)
        alertController.addAction(opticalFlow)
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAlertMsg(mode: integer_t) {
        
        let alertController = UIAlertController(title: "Detection Mode", message: "Keep the camera still! Place your device on a steady surface.", preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "Got it!", style: UIAlertAction.Style.default) {
            (result : UIAlertAction) -> Void in
            self.wrapper.switchMode(mode)
            self.wrapper.start()
        }
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }

}

