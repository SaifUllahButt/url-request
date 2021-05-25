//
//  View.swift
//  url_Request
//
//  Created by M Zaryab on 25/05/2021.
//  Copyright © 2021 M Zaryab. All rights reserved.
//



import UIKit

extension UIView {
    func aspectRation(_ ratio: CGFloat) -> NSLayoutConstraint {

        return NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: self, attribute: .width, multiplier: ratio, constant: 0)
    }
    func removeAllSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func roundCorners(radius: CGFloat = 5, bordorColor: UIColor = .white, borderWidth: CGFloat = 0.5) {
        layer.cornerRadius = radius
        layer.borderColor = bordorColor.cgColor
        layer.borderWidth = borderWidth
        layer.masksToBounds = true
    }
    
    func circularView(bordorColor: UIColor = UIColor.clear, borderWidth: CGFloat = 0.5) {
        layer.cornerRadius = frame.size.width/2
        clipsToBounds = true
        layer.masksToBounds = true
        layer.borderColor = bordorColor.cgColor
        layer.borderWidth = borderWidth
    }
    
    func addShadow(scale: Bool = true) {
        self.layer.cornerRadius = 5
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 5
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    }
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

extension UIView {
    func addShadowToView(cornerRadius:CGFloat = 7, color: UIColor = UIColor.lightGray) {
        backgroundColor = UIColor.white
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 5
        layer.cornerRadius = cornerRadius
    }
    func addShadowToViewCollectionView(cornerRadius:CGFloat = 7, color: UIColor = UIColor(named: "3")as! UIColor) {
        backgroundColor = UIColor.white
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 5
        layer.cornerRadius = cornerRadius
    }
    func addShadowToViewHistoryCell(cornerRadius:CGFloat = 7, color: UIColor = UIColor.lightGray) {
        backgroundColor = UIColor(named: "brown")as! UIColor
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 5
        layer.cornerRadius = cornerRadius
    }
    

}
extension UIView{
    func blurImage()
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds

        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }
}

public extension UIView {

    @discardableResult
     func addBlur(style: UIBlurEffect.Style = .extraLight) -> UIVisualEffectView {
        let blurEffect = UIBlurEffect(style: style)
        let blurBackground = UIVisualEffectView(effect: blurEffect)
        addSubview(blurBackground)
        blurBackground.translatesAutoresizingMaskIntoConstraints = false
        blurBackground.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        blurBackground.topAnchor.constraint(equalTo: topAnchor).isActive = true
        blurBackground.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        blurBackground.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        return blurBackground
    }
}
extension UIView {

    public func addConstaintsToSuperview(leftOffset: CGFloat, topOffset: CGFloat) {

        self.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint(item: self,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: self.superview,
                           attribute: .leading,
                           multiplier: 1,
                           constant: leftOffset).isActive = true

        NSLayoutConstraint(item: self,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: self.superview,
                           attribute: .top,
                           multiplier: 1,
                           constant: topOffset).isActive = true
    }

    public func addConstaints(height: CGFloat, width: CGFloat) {

        self.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint(item: self,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: height).isActive = true


        NSLayoutConstraint(item: self,
                           attribute: .width,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: width).isActive = true
    }
}
extension UIView {
    /** Loads instance from nib with the same name. */
    func loadNib() -> Self {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView as! Self
    }
}
//public extension UIView {
//    public class func fromNib(nibNameOrNil: String? = nil) -> Self {
//        return fromNib(nibNameOrNil, type: self)
//    }
//
//    public class func fromNib<T : UIView>(nibNameOrNil: String? = nil, type: T.Type) -> T {
//        let v: T? = fromNib(nibNameOrNil, type: T.self)
//        return v!
//    }
//
//    public class func fromNib<T : UIView>(nibNameOrNil: String? = nil, type: T.Type) -> T? {
//        var view: T?
//        let name: String
//        if let nibName = nibNameOrNil {
//            name = nibName
//        } else {
//            // Most nibs are demangled by practice, if not, just declare string explicitly
//            name = nibName
//        }
//        let nibViews = NSBundle.mainBundle().loadNibNamed(name, owner: nil, options: nil)
//        for v in nibViews {
//            if let tog = v as? T {
//                view = tog
//            }
//        }
//        return view
//    }
//
//    public class var nibName: String {
//        let name = "\(self)".componentsSeparatedByString(".").first ?? ""
//        return name
//    }
//    public class var nib: UINib? {
//        if let _ = NSBundle.mainBundle().pathForResource(nibName, ofType: "nib") {
//            return UINib(nibName: nibName, bundle: nil)
//        } else {
//            return nil
//        }
//    }
//}
extension UIView {
    
    var top : CGFloat{
        get{
            return self.frame.origin.y
        }
        set{
            var frame       = self.frame
            frame.origin.y  = newValue
            self.frame      = frame
        }
    }
    
    var bottom : CGFloat{
        get{
            return frame.origin.y + frame.size.height
        }
        set{
            var frame       = self.frame
            frame.origin.y  = newValue - self.frame.size.height
            self.frame      = frame
        }
    }
    
    var right : CGFloat{
        get{
            return self.frame.origin.x + self.frame.size.width
        }
        set{
            var frame       = self.frame
            frame.origin.x  = newValue - self.frame.size.width
            self.frame      = frame
        }
    }
    
    var left : CGFloat{
        get{
            return self.frame.origin.x
        }
        set{
            var frame       = self.frame
            frame.origin.x  = newValue
            self.frame      = frame
        }
    }
}

extension UIView {
    func blurImage(image: UIImage, blurAmount: CGFloat) -> UIImage? {
        guard let ciImage = CIImage(image: image) else {return nil}
        
        let blurFilter = CIFilter(name: "CIGaussianBlur")
        blurFilter?.setValue(ciImage, forKey: kCIInputImageKey)
        blurFilter?.setValue(blurAmount, forKey: kCIInputRadiusKey)
        
        guard let outputImage = blurFilter?.outputImage else {return nil}
        return UIImage(ciImage: outputImage)
    }
}
