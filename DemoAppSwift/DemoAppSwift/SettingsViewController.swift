//
//  SettingsViewController.swift
//  DemoAppSwift
//
//  Created by Shimi Sheetrit on 2/16/16.
//  Copyright © 2016 Matomy Media Group Ltd. All rights reserved.
//

import UIKit
import AVFoundation

class SettingsViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    
    private var isScannerReading: Bool!
    private var captureSession: AVCaptureSession!
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer!

    @IBOutlet weak var hashTextField: UITextField!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var viewPreview: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var doneButtonItem: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.isScannerReading = false
        self.captureSession = nil
        
        self.startButton.layer.cornerRadius = 4.0
        self.statusLabel.text = "QR Code Reader is not yet running..."
        
        self.view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(SettingsViewController.dismissKeyboard)))
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissKeyboard() {
        
        self.hashTextField.resignFirstResponder()
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "SettingsToMainSegue") {
            
            if((self.hashTextField.text?.characters.count)! > 0) {
                
                let vc = segue.destination as! MainViewController
                vc.invh = self.hashTextField.text!
                
            }
        }
    }
    
    @IBAction func startStopReading(_ sender: AnyObject) {
        
        if(!self.isScannerReading) {
            if(self.startReading()) {
                
                self.startButton.setTitle("Stop", for:UIControlState())
                self.statusLabel.text = "Scanning for QR Code..."
                
            }
        } else{
            
            self.stopReading()
            self.startButton.setTitle("Start!", for:UIControlState())
            self.statusLabel.text = "QR Code Reader is not running..."
            
        }
        
        self.isScannerReading = !self.isScannerReading
        
    }
    
    func startReading () -> Bool {
        
        var input: AVCaptureDeviceInput
        
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        do {
            
            input = try AVCaptureDeviceInput.init(device: captureDevice!)
            
        }
        catch {
            
            return false
        }
        
        self.captureSession = AVCaptureSession.init()
        self.captureSession.addInput(input)
        
        let captureMetadataOutput = AVCaptureMetadataOutput.init()
        self.captureSession.addOutput(captureMetadataOutput)
        
        var dispatchQueue: DispatchQueue
        dispatchQueue = DispatchQueue(label: "myQueue")
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatchQueue)
        captureMetadataOutput.metadataObjectTypes = NSArray.init(object: AVMetadataObjectTypeQRCode) as [AnyObject]
        
        self.videoPreviewLayer = AVCaptureVideoPreviewLayer.init(session: self.captureSession)
        self.videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        self.videoPreviewLayer.frame = self.viewPreview.layer.bounds
        self.viewPreview.layer.addSublayer(self.videoPreviewLayer)
        
        self.captureSession.startRunning()
        
        return true
    }
    
    func stopReading() {
        
        self.captureSession.stopRunning()
        self.captureSession = nil
        self.videoPreviewLayer.removeFromSuperlayer()
    }
    
    //MARK: AVCaptureMetadataOutputObjectsDelegate
    
    private func captureOutput(_ captureOutput: AVCaptureOutput!,
        didOutputMetadataObjects metadataObjects: [AnyObject]!,
        from connection: AVCaptureConnection!) {
            
            if(metadataObjects != nil && metadataObjects.count > 0) {
                
                let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
                
                if(metadataObj.type == AVMetadataObjectTypeQRCode) {
                    
                    //self.statusLabel.performSelector(onMainThread: #selector(setter: UITableViewCell.textLabel), with: "QR Code Reader is not running...", waitUntilDone: false)
                    
                    self.statusLabel.text = "QR Code Reader is not running..."
                    self.performSelector(onMainThread: #selector(SettingsViewController.stopReading), with: nil, waitUntilDone: false)
                    
                    DispatchQueue.main.async(execute: {
               
                        self.startButton.setTitle("Start!", for:UIControlState())
                        self.hashTextField.text = metadataObj.stringValue
                        
                        })
                    
                        self.isScannerReading = false
                    
                }
    
            }
    }
    
    
}
