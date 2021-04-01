//
//  ViewController.swift
//  ARKitVisionObjectDetection
//
//  Created by Vladislav Luchnikov on 2021-03-29.
//


import UIKit
import SceneKit
import ARKit
import Vision
import RealityKit
import SwiftUI

//global vars
var ageGroups: [String: Int] = ["0-2": 0,
                                "4-6": 1,
                                "8-12": 2,
                                "15-20": 3,
                                "25-32": 4,
                                "38-43": 5,
                                "48-53": 6,
                                "60-100": 7]
var anchorNames = [Int]()

var anchorPhones = [Int: Int]()

var anchors = [ARAnchor]()

var threshold = 1.0

var totalCount = 0

//ARanchor subclass with # of phones
class AgeAnchor: ARAnchor {
    var phones = 0
}


// ARSCNViewDelegate describes renderer
class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    // Swift UI
//    let contentView1 = UIHostingController(rootView: ContentView())
    
    
    private var viewportSize: CGSize!
    private var detectRemoteControl: Bool = true
    
    // sound vars
    let synth = AVSpeechSynthesizer()
    var player: AVAudioPlayer?
    var volume = 1.0
    var Qs = [String]()
    var Ans = [String]()
    var SpeechStatus = String()
    var PreviousQ = ""
    var PreviousA = ""

    
    let url = Bundle.main.url(forResource: "iphone message", withExtension: "mp3")
    

    
    override var shouldAutorotate: Bool { return false }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        synth.delegate = self
        SetupQNA()
        SpeechStatus = "Hi"
        SpeakHi()
        viewportSize = sceneView.frame.size
    }
    
    // App opens
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resetTracking()
    }
    // App pauses
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    // tomeasure anchor dist..
    func distanceBetweenPoints (A: SIMD3<Float>, B: SIMD3<Float>) -> CGFloat {
        let l = sqrt(
            (A.x - B.x) * (A.x - B.x)
                + (A.y - B.y) * (A.y - B.y)
                + (A.z - B.z) * (A.z - B.z)
        )
        return CGFloat(l)
    }
    
    //gets pair of question and answer (as a String Array) by specifying index
    func GetQ() -> String {
        Qs.shuffle()
        while Qs[0] == PreviousQ {
            
            Qs.shuffle()
        }
        return Qs[0]
    }

    func GetA() -> String {
        Ans.shuffle()
        while Ans[0] == PreviousA {
            Ans.shuffle()
        }
        return Ans[0]
    }
        
    //Get plist file and return as NSArray
    func SetupQNA() {
        let path = Bundle.main.path(forResource: "data", ofType: "plist")
        var arr : NSArray?
        arr = NSArray(contentsOfFile: path!)
        
        for item in arr!{
            let pair = item as! [String]
            if pair[0] == "Why i want new phone" ||
                pair[1] == "Facts"
                {
                continue
            }
            if pair[0] == "na"
                {
                Ans.append(pair[1])
            }
            else
            {
                Qs.append(pair[0])
                Ans.append(pair[1])
            }
        }
    }
        
    func SpeakQ() {
        
        let speechUtterance: AVSpeechUtterance = AVSpeechUtterance(string: GetQ())
        speechUtterance.rate = AVSpeechUtteranceMaximumSpeechRate / 2.0
        speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        speechUtterance.volume = Float(self.volume)
        synth.speak(speechUtterance)
    }
    
    func SpeakA() {
        
        let speechUtterance: AVSpeechUtterance = AVSpeechUtterance(string: GetA())
        speechUtterance.rate = AVSpeechUtteranceMaximumSpeechRate / 2.0
        speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        speechUtterance.volume = Float(self.volume)
        synth.speak(speechUtterance)
    }
    
    func SpeakHi() {
        
        let speechUtterance: AVSpeechUtterance = AVSpeechUtterance(string: "Hello")
        speechUtterance.rate = AVSpeechUtteranceMaximumSpeechRate / 2.0
        speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        speechUtterance.volume = Float(self.volume)
        synth.speak(speechUtterance)
    }
    
    func SpeakShouldI() {
        
        let speechUtterance: AVSpeechUtterance = AVSpeechUtterance(string: "Should i get a new phone?")
        speechUtterance.rate = AVSpeechUtteranceMaximumSpeechRate / 2.0
        speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        speechUtterance.volume = Float(self.volume)
        synth.speak(speechUtterance)
    }
    
    // called on viewWillAppear on start and when they press reset
    private func resetTracking() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = []
        sceneView.session.run(configuration, options: [.removeExistingAnchors, .resetTracking])
        detectRemoteControl = true
    }

    //Tells the delegate that a SceneKit node corresponding to a new AR anchor has been added to the scene.
        
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        let numOfPhones = anchorPhones[Int(anchor.name!)!]
        // print(numOfPhones!)
//        print("anchor name")
//        print(anchor.name!)
        var offset = 0.0
        let verticalOffset = 0.1
        // Add phone models display to the anchor
        do {
            
            player = try AVAudioPlayer(contentsOf: url!, fileTypeHint: AVFileType.mp3.rawValue)
            player?.play()
        }
        catch{
            print("player couldn't play")
        }

        totalCount += numOfPhones!
        updateCount(count: totalCount)
        
        for _ in 1...numOfPhones! {
            //let mobileScene = SCNScene(named: "art.scnassets/IPhoneSE1.dae")
            let mobileScene = SCNScene(named: "art.scnassets/iPhone.usdz")
//            guard let sceneNode = mobileScene?.rootNode.childNode(withName: "Phone", recursively: true) else {
//                fatalError("model not found")
//            }
            guard let sceneNode = mobileScene?.rootNode.childNode(withName: "Geom", recursively: true) else {
                fatalError("model not found")
            }
            let factor = 0.01
            sceneNode.scale.x = sceneNode.scale.x * Float(factor)
            sceneNode.scale.y = sceneNode.scale.y * Float(factor)
            sceneNode.scale.z = sceneNode.scale.z * Float(factor)
            let material = SCNMaterial()
            material.locksAmbientWithDiffuse = true
//            material.isDoubleSided = false
//            material.ambient.contents = UIColor.black
//            material.diffuse.contents = UIImage(named: "texture.jpeg")
            self.sceneView.autoenablesDefaultLighting = true
            sceneNode.geometry?.materials = [material]
            sceneNode.position.x = sceneNode.position.x + Float(offset)
            sceneNode.position.y += Float(verticalOffset)
            offset = offset + 0.05
            node.addChildNode(sceneNode)
        }
    }

    //Tells the delegate that the renderer has cleared the viewport and is about to render the scene.
    func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
        
        
        guard detectRemoteControl,
            let capturedImage = sceneView.session.currentFrame?.capturedImage
            else { return }
        
        
        // set up and perform requests for face rectangle detection
        let faceDetection = VNDetectFaceRectanglesRequest()
        let faceDetectionRequest = VNSequenceRequestHandler()
        try? faceDetectionRequest.perform([faceDetection], on: capturedImage)
        guard let results = faceDetection.results as? [VNFaceObservation] else {
            print("error on face detection results")
            return }
        
        // for each face set up ARkit anchor + detect age
        for observation in results {
           
            guard let currentFrame = sceneView.session.currentFrame else { continue }
            let fromCameraImageToViewTransform = currentFrame.displayTransform(for: .portrait, viewportSize: viewportSize)
            let boundingBox = observation.boundingBox
            let viewNormalizedBoundingBox = boundingBox.applying(fromCameraImageToViewTransform)
            let t = CGAffineTransform(scaleX: viewportSize.width, y: viewportSize.height)
            // Scale up to view coordinates
            let viewBoundingBox = viewNormalizedBoundingBox.applying(t)

            let midPoint = CGPoint(x: viewBoundingBox.midX,
                       y: viewBoundingBox.midY)

            let results = sceneView.hitTest(midPoint, types: .featurePoint)
            guard let result = results.first else { continue }
            
            
            
            //detectRemoteControl = false
            
            // get current frame
            let image = CIImage(cvPixelBuffer: capturedImage)
            var ageBin:String = ""
            // create handler for age detection, pass the image cropped to face bounding box
            let imageRequestHandler = VNImageRequestHandler(ciImage: image.cropped(to: observation.boundingBox))
            do {
                // perform age detection
                try imageRequestHandler.perform([ageDetectionRequest])
                guard let results = ageDetectionRequest.results else {return}
                var confidence:Float = 0

                
                // iterate over age bins for one observtaion and find highest confidence
                for item in results where item is VNClassificationObservation {
                    let item2 = item as? VNClassificationObservation
                    guard let confidence2 = item2?.confidence else {continue}
                    if confidence2 > confidence {
                        confidence = confidence2
                        guard let ageBin2 = item2?.identifier else {continue}
                        ageBin = ageBin2
                    }
                }
                
            } catch {
                print("Failed to perform age detection request.")
            }
            // save # of phones to array
            var name = 0
            for item in anchors{
                name = index(ofAccessibilityElement: item)
            }
            // set phone count for an anchor
            anchorPhones[name] = ageGroups[ageBin] ?? 0
            let anchor = ARAnchor(name: String(name), transform: result.worldTransform)
            var thislocation = simd_make_float3(anchor.transform.columns.3)
            // check distance from existing anchors
            let thresh = Float(0.5)
            if anchors.isEmpty {
                print("initial anchor added")
                sceneView.session.add(anchor: anchor)
                anchors.append(anchor)
                detectRemoteControl = false
            }
            for anchorItem in anchors {
                print("checking")
                let location = simd_make_float3(anchorItem.transform.columns.3)
                let dist = Float(distanceBetweenPoints(A: thislocation, B: location))
                if dist < thresh
                {
                    print("too close")
                    return
                } else {
                    print("anchor added")
                    sceneView.session.add(anchor: anchor)
                    anchors.append(anchor)
                    // detectRemoteControl = false
                }
            }
        }
    
        
    }
    
    // set up age detection request
    lazy var ageDetectionRequest: VNCoreMLRequest = {
        guard let model = try? VNCoreMLModel(for: AgeNet(configuration: MLModelConfiguration()).model) else {
             fatalError("Erro acessando modelo")
        }

        let request = VNCoreMLRequest(model: model) { [weak self] request, error in
            guard let results = request.results as? [VNClassificationObservation], let gendResult = results.first else {
                  fatalError("Unexpected type!")
            }
            
        }
        return request
    }()

    
    @IBAction private func didTouchResetButton(_ sender: Any) {
//        volume = 0.0
        anchorNames = [Int]()
        anchorPhones = [Int: Int]()
        anchors = [ARAnchor]()
        resetTracking()
    }
    @IBOutlet weak var myLabe: UILabel!
    func updateCount(count: Int) {
        self.myLabe.text = String(count)
    }
}

extension ViewController: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        let seconds = 3.0
        switch SpeechStatus {
        case "Hi":
            SpeechStatus = "Q"
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                self.SpeakQ()
            }
        case "Q":
            SpeechStatus = "ShouldI"
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                self.SpeakShouldI()
            }
        case "ShouldI":
            SpeechStatus = "A"
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                self.SpeakA()
            }
        case "A":
            SpeechStatus = "Q"
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds + 1.0) {
                self.SpeakQ()
            }
        default:
            print("Default switch on SpeechStatus")
        }
    }
}


