//
//  Toast.swift
//  Weather Search
//
//  Created by 朱侯青晨 on 2021/12/5.
//

import Foundation
import Toast_Swift
import SwiftUI

struct Toast: UIViewControllerRepresentable {
    
    @Binding var text: String

    func makeUIViewController(context: UIViewControllerRepresentableContext<Toast>) -> UIToast {
        return UIToast(text: text)
    }

    func updateUIViewController(_ uiView: UIToast, context: UIViewControllerRepresentableContext<Toast>) {
        uiView.text = text
        uiView.viewDidLoad()
        text = ""
    }
}


class UIToast: UIViewController{

    var text: String = ""

    init(text: String) {
        super.init(nibName: nil, bundle: nil)
        self.text = text
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if text.contains("Favorite") {
            self.view.makeToast(text)
        }
    }
}
