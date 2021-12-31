//
//  ViewController.swift
//  UIKitPreview
//
//  Created by Daniel Stafford on 12/30/21.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }


}

struct VCPreview: PreviewProvider {

    static var previews: some View {
        VCContainerView().edgesIgnoringSafeArea(.all)
    }
    struct VCContainerView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            return ViewController()
        }

        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        }

        typealias UIViewControllerType = UIViewController

    }

}
