//
//  FollowerListVCViewController.swift
//  Mini GitHub
//
//  Created by Hady on 11/2/20.
//  Copyright © 2020 HadyOrg. All rights reserved.
//

import UIKit

class FollowerListVC: UIViewController {
    
    enum Section {
        case main
    }
    
    var userName : String!
    var followers : [Follower]  = []
    var filterFollowers : [Follower] = []

    var dataSource : UICollectionViewDiffableDataSource<Section , Follower>!
    var collectionView : UICollectionView!
    var page = 1
    var hasMoreFollower = true
    var isSearching     = false
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getFollower(userName: userName, page: page)
        configureDiffabelDataSource()
        configureSearchController()
    }
    
    override func viewWillAppear ( _ animated : Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false , animated : true)
    }
    
    private func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    private func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseId)
    }
    
    private func configureSearchController (){
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate   = self
        searchController.searchBar.placeholder = "Search for a follower name"
        navigationItem.searchController = searchController
        
    }
    func getFollower(userName : String , page : Int){
        showLoadingView()
        //ARC Memory Managment
        NetworkManager.shared.getFollower(for: userName, page: page) { [weak self] result in
           
            //unwarbing the optional Self because weak make it optional (ARC)
            guard let self = self else { return }
            //#warning("add hide the indicator here func")
            self.hideLoadingView()
            switch result{
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "في عبط حصل يا صاحبي", message: error.rawValue, buttonTitle: "Ok")
                
            case .success(let followers):
                if followers.count < 100 { self.hasMoreFollower.toggle() }
                self.followers.append(contentsOf: followers)
            
                if self.followers.isEmpty {
                    let message = "this user doen't have a followers go follow them 🤪"
                    DispatchQueue.main.async {
                            self.showEmptyStateView(message: message, in: self.view)
                    }
                    return // here we return cuz we don't wanaa update any data
                }
                self.updateData(with: self.followers)
            }
        }
    }
    
    
    func configureDiffabelDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section,Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, Follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseId, for: indexPath) as! FollowerCell
            cell.set(follower: Follower)
            return cell
        })
    }
    
    func updateData(with followerssssss : [Follower]){
        var snapshot = NSDiffableDataSourceSnapshot<Section,Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followerssssss)
        DispatchQueue.main.async { self.dataSource.apply(snapshot,animatingDifferences: true) }
    }
}

extension FollowerListVC : UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY        = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height        = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollower else { return}
            page += 1
            getFollower(userName: userName, page: self.page)
        }
//        print("This  is a offsetY = \(offsetY)")
//        print("This  is a content Height = \(contentHeight)")
//        print("This  is a Height = \(height)")
    }
    
//====================================================================================================
//====================================================================================================

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedArray = isSearching ? filterFollowers : followers
        let followerr     = selectedArray[indexPath.item]
        let destVC        = UserInfoVC()
        let navVc         = UINavigationController(rootViewController: destVC)
        destVC.userName = followerr.login
        present(navVc, animated: true)
    }

}

extension FollowerListVC : UISearchResultsUpdating ,UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text , !filter.isEmpty else { return }
        isSearching = true
        filterFollowers = followers.filter{  $0.login.lowercased().contains(filter.lowercased())    }
        updateData(with: filterFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateData(with: self.followers)
        isSearching.toggle()
    }

}

