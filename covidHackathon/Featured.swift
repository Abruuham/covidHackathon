//
//  Featured.swift
//  CompositionalLayoutDemo
//
//  Created by Kévin MAAREK on 26/09/2019.
//  Copyright © 2019 Kévin MAAREK. All rights reserved.
//

import UIKit

public class Featured: UICollectionViewCell {
    
    var container: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = UIColor.white
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = 20
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 12
        view.layer.shadowOffset = CGSize(width: 0, height: 15)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "FEATURED"
        label.font = UIFont.preferredFont(forTextStyle: .headline).withSize(26)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var subtitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "Some subtitle"
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    var viewBackground: UIImageView = {
//        let imageView: UIImageView = UIImageView()
//        imageView.image = UIImage(named: "wom.jpeg")!
//        imageView.clipsToBounds = true
//        imageView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
//        imageView.contentMode = .scaleAspectFill
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.container)
        //self.container.addSubview(self.viewBackground)
        self.container.addSubview(self.titleLabel)
        self.container.addSubview(self.subtitleLabel)

        NSLayoutConstraint.activate([
            self.container.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.container.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.container.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.container.rightAnchor.constraint(equalTo: self.contentView.rightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.container.topAnchor, constant: 20),
            self.titleLabel.leftAnchor.constraint(equalTo: self.container.leftAnchor, constant: 20),
            self.titleLabel.rightAnchor.constraint(equalTo: self.container.rightAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            self.subtitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10),
            self.subtitleLabel.leftAnchor.constraint(equalTo: self.container.leftAnchor, constant: 20),
            self.subtitleLabel.rightAnchor.constraint(equalTo: self.container.rightAnchor, constant: -20)
        ])
//
//        NSLayoutConstraint.activate([
//            self.viewBackground.topAnchor.constraint(equalTo: self.container.topAnchor, constant: 0),
//            self.viewBackground.leftAnchor.constraint(equalTo: self.container.leftAnchor, constant: 0),
//            self.viewBackground.rightAnchor.constraint(equalTo: self.container.rightAnchor, constant: 0)
//        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setup(title: String, subtitle: String) {
        self.titleLabel.text = title
        self.subtitleLabel.text = subtitle
       // self.viewBackground.image = UIImage(named: "wom.jpeg")!
    }
}
