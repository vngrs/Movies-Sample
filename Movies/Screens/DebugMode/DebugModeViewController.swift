//
//  DebugModeViewController.swift
//  Movies
//
//  Created by Abdelrahman Mohamed on 6.08.2020.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import UIKit
import CoreVNGRSKit

class DebugModeViewController: ViewController, StoryboardBased {

    static var storyboardName: String = "DebugMode"

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var liveModeButton: UIButton!
    @IBOutlet weak var debugModeButton: UIButton!

    var viewModel: DebugModeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
        addChangeHandlers()
    }

    func configureViews() {

        cancelButton.roundCorners()
        liveModeButton.roundCorners()
        debugModeButton.roundCorners()
    }

    func addChangeHandlers() {

        viewModel.addChangeHandler { [weak self] (change) in
        guard let self = self else {return}

            switch change {
                // TODO
            case .mode:
                let storyboard = UIStoryboard(name: "Movies", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "MoviesListViewController")
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true, completion: nil)
////                self.dismiss(animated: true)
//                self.dismiss(animated: true) {
//
//                }
////                exit(0)

            }
        }
    }

    @IBAction func didTapCancel(_ sender: Any) {

        self.dismiss(animated: true)
    }
    
    @IBAction func didTapLiveMode(_ sender: Any) {

        viewModel.setMode(mode: "live")
    }

    @IBAction func didTapDebugMode(_ sender: Any) {

        viewModel.setMode(mode: "debug")
    }
}

//extension UIView {
//
//    func roundCorners(_ corners: UIRectCorner = .allCorners, withRadius radius: CGFloat) {
//        DispatchQueue.main.async { [weak self] in
//            guard let `self` = self else { return }
//            let path = UIBezierPath(
//                roundedRect: self.bounds,
//                byRoundingCorners: corners,
//                cornerRadii: CGSize(width: radius, height: radius)
//            )
//            let mask = CAShapeLayer()
//            mask.path = path.cgPath
//            self.layer.mask = mask
//        }
//    }
//
//}
