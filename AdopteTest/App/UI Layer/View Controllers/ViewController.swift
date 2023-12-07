//
//  ViewController.swift
//  AdopteTest
//
//  Created by Moez bachagha on 7/12/2023.
//
import UIKit

class ViewController: UIViewController,UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var LeaguesCollection: UICollectionView!
    var isSearching = false
    var ContributorsViewModel: ContributorsViewModel!
    var ContributorsArray: [Contributor] = []
    var filteredItems: [Contributor] = []
    var Contributor : Contributor!

    override func viewDidLoad() {

        super.viewDidLoad()

        configureFlowLayout()
        ContributorsViewModel = AdopteTest.ContributorsViewModel()
        ContributorsViewModel.getContributors { [weak self] (Contributors, error) in
            if let error = error {

            }

            if let Contributors = Contributors {

                self?.ContributorsArray = Contributors
                

            }
            print("Retrieved \(self?.ContributorsArray.count ?? 0) contributors")

                // Reload the collection view on the main thread
                DispatchQueue.main.async {
                    self?.LeaguesCollection.reloadData()
                }

        }
    }

func configureFlowLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (LeaguesCollection.frame.width - 20) / 2, height: 180)
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) // Adjust the section insets
        LeaguesCollection.collectionViewLayout = layout
    }
}

extension ViewController : UICollectionViewDataSource, UICollectionViewDelegate,  UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

            return ContributorsArray.count


    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell

            Contributor = ContributorsArray[indexPath.row]
            cell.titleLabel.text = Contributor.login
        if (Contributor.avatar_url != nil) {
            if let imageURL = URL(string: Contributor.avatar_url!) {
                ContributorsViewModel.getImage(from : imageURL , completion: { [weak self] (image, error) in
                    if let error = error {

                    }

                    if let image = image {
                        DispatchQueue.main.async() { [weak self] in
                            cell.imageView.image = image
                            cell.imageView.layer.cornerRadius = 10
                            cell.imageView.clipsToBounds = true
                            cell.imageView.layer.shadowColor = UIColor.black.cgColor
                            cell.imageView.layer.shadowOpacity = 0.5
                            cell.imageView.layer.shadowOffset = CGSize(width: 4, height: 4)
                            cell.imageView.layer.masksToBounds = false
                            cell.imageView.layer.shadowRadius = 5.0

                        } }})

            }}
          //  cell.imageView.image = UIImage(named: "league")



        return cell
    }

}
