//
//  makeCircleView + Designable.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2021/01/01.
//

import Foundation
import UIKit

@IBDesignable public class RoundedUIView: UIView {

    override public func layoutSubviews() {
        super.layoutSubviews()

        self.layer.cornerRadius = self.frame.width / 2;
        self.layer.masksToBounds = true
    }
}


@IBDesignable public class RoundedUIImageView: UIImageView {

    override public func layoutSubviews() {
        super.layoutSubviews()

        self.layer.cornerRadius = self.frame.width / 2;
        self.layer.masksToBounds = true
    }
}

@IBDesignable public class RoundedUIButton: UIButton {

    override public func layoutSubviews() {
        super.layoutSubviews()

        self.layer.cornerRadius = self.frame.width / 2;
        self.layer.masksToBounds = true
    }
}
