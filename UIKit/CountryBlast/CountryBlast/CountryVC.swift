//
//  CountryVCViewController.swift
//  CountryBlast
//
//  Created by Daniel Stafford on 1/12/22.
//

import UIKit

class CountryVC: UIViewController {
    var populationLabel: UILabel!
    var regionLabel: UILabel!
    var subregionLabel: UILabel!
    var flagImage: UIImage!
    var flagImageView: UIImageView!
    var capitalLabel: UILabel!

    var selectedCountry: Country?
    var fontSize = CGFloat(20)
    var spacingBetweem = CGFloat(45)

    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor.systemBackground

        populationLabel = UILabel()
        populationLabel.translatesAutoresizingMaskIntoConstraints = false
        populationLabel.numberOfLines = 0
        populationLabel.text = "Population: \(selectedCountry?.population.formatted() ?? "N/A")"
        populationLabel.font = UIFont.boldSystemFont(ofSize: fontSize)
        populationLabel.sizeToFit()
        populationLabel.textColor = .none
        view.addSubview(populationLabel)

        regionLabel = UILabel()
        regionLabel.translatesAutoresizingMaskIntoConstraints = false
        regionLabel.numberOfLines = 0
        regionLabel.text = "Region: \(selectedCountry?.region ?? "N/A")"
        regionLabel.font = UIFont.boldSystemFont(ofSize: fontSize)
        regionLabel.sizeToFit()
        regionLabel.textColor = .none
        view.addSubview(regionLabel)

        subregionLabel = UILabel()
        subregionLabel.translatesAutoresizingMaskIntoConstraints = false
        subregionLabel.numberOfLines = 0
        subregionLabel.text = "Subregion: \(selectedCountry?.subregion ?? "N/A")"
        subregionLabel.font = UIFont.boldSystemFont(ofSize: fontSize)
        subregionLabel.sizeToFit()
        subregionLabel.textColor = .none
        view.addSubview(subregionLabel)

        capitalLabel = UILabel()
        capitalLabel.translatesAutoresizingMaskIntoConstraints = false
        capitalLabel.numberOfLines = 0
        capitalLabel.text = "Capital: \(selectedCountry?.capital?[0] ?? "N/A")"
        capitalLabel.font = UIFont.boldSystemFont(ofSize: fontSize)
        capitalLabel.sizeToFit()
        capitalLabel.textColor = .none
        view.addSubview(capitalLabel)

        flagImageView = UIImageView(image: UIImage(named: selectedCountry?.cca2.lowercased() ?? ""))
        flagImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(flagImageView)

        NSLayoutConstraint.activate([
            
            flagImageView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            flagImageView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),

            regionLabel.topAnchor.constraint(equalTo: flagImageView.bottomAnchor, constant: spacingBetweem),
            regionLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),

            subregionLabel.topAnchor.constraint(equalTo: regionLabel.bottomAnchor, constant: spacingBetweem),
            subregionLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),

            populationLabel.topAnchor.constraint(equalTo: subregionLabel.bottomAnchor, constant: spacingBetweem),
            populationLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),

            capitalLabel.topAnchor.constraint(equalTo: populationLabel.bottomAnchor, constant: spacingBetweem),
            capitalLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),

        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        flagImageView.alpha = 0
        populationLabel.alpha = 0
        subregionLabel.alpha = 0
        capitalLabel.alpha = 0
        regionLabel.alpha = 0

        UIView.animate(
            withDuration: 1,
            animations: {
                self.flagImageView.alpha = 1
                self.populationLabel.alpha = 1
                self.subregionLabel.alpha = 1
                self.capitalLabel.alpha = 1
                self.regionLabel.alpha = 1
        })
        
    }
}
