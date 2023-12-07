//
//  ProfilViewController.swift
//  AdopteTest
//
//  Created by Moez bachagha on 7/12/2023.
//

import UIKit

class ProfilViewController: UIViewController {

    var contibutor  : Contributor?
    var ContributorsViewModel: ContributorsViewModel!


    @IBOutlet weak var avatarImg: UIImageView!
    @IBOutlet weak var contibutorNameTxt: UILabel!
    @IBOutlet weak var contributionsTxt: UILabel!



    override func viewDidLoad() {
        super.viewDidLoad()
        ContributorsViewModel = AdopteTest.ContributorsViewModel()

        contibutorNameTxt.text = contibutor?.login
        if let contributions = contibutor?.contributions {
            contributionsTxt.text = String(contributions)
        } else {
            // Handle the case where contibutor?.contributions is nil
            contributionsTxt.text = "N/A"
        }
        if (contibutor?.avatar_url != nil) {
            if let imageURL = URL(string: (contibutor?.avatar_url)!) {
                ContributorsViewModel.getImage(from : imageURL , completion: { [weak self] (image, error) in
                    if let error = error {

                    }

                    if let image = image {
                        DispatchQueue.main.async() { [weak self] in
                            self!.avatarImg.image = image
                            self!.avatarImg.layer.cornerRadius = 10
                            self!.avatarImg.clipsToBounds = true
                            self!.avatarImg.layer.shadowColor = UIColor.black.cgColor
                            self!.avatarImg.layer.shadowOpacity = 0.5
                            self!.avatarImg.layer.shadowOffset = CGSize(width: 4, height: 4)
                            self!.avatarImg.layer.masksToBounds = false
                            self!.avatarImg.layer.shadowRadius = 5.0

                        } }})

            }}

    }




}
