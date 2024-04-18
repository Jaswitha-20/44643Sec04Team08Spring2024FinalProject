//
//  BaseViewController.swift
//  EventManagementApplication
//
//  Created by Jaswitha Kalikiri on 3/14/24.
//
import UIKit

class HomeVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var eventCategories: [String] = []
    var dataSource: [Event] = []
    
    var eventsResponse: EventResponse? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataManager.shared.fetchDataFromAPI { eventResponse, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
            } else if let eventResponse = eventResponse {
                self.eventsResponse = eventResponse
                
                if let categories = eventResponse.categories {
                    self.dataSource = categories.flatMap { $0.value.events ?? [] }
                }
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
        
        eventCategories = ["Personal Events", "Corporate Events", "Public Events"]
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = flowLayout()
        
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
        
    }
}


extension HomeVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return eventsResponse?.categories?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let categories = eventsResponse?.categories else {
            return 0
        }
        
        let sortedCategories = categories.keys.sorted()
        
        guard section < sortedCategories.count else {
            return 0
        }
        
        let category = sortedCategories[section]
        
        guard let events = categories[category]?.events else {
            return 0
        }
        
        return events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let category = eventsResponse?.categories?.keys.sorted(),
              let event = eventsResponse?.categories?[category[indexPath.section]]?.events?[indexPath.row] else {
            return UICollectionViewCell()
        }
        
        // Dequeue or create a cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCell", for: indexPath) as! EventCell
        
        // Configure the cell with event data
        cell.titleLabel.text = event.title
        if indexPath.section == 0 {
            cell.eventImage.image = UIImage(named: "coporate")
        }
        else if indexPath.section == 1 {
            cell.eventImage.image = UIImage(named: "personal")
        }
        else if indexPath.section == 2 {
            cell.eventImage.image = UIImage(named: "public")
        }
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // Return the header view for each section
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as! HeaderView
            if indexPath.section == 0{
                headerView.titleLabel.text = "Corporate Events"
            }
            else if indexPath.section == 1{
                headerView.titleLabel.text = "Personal Events"
            }
            else if indexPath.section == 2{
                headerView.titleLabel.text = "Public Events"
            }
            //                headerView.titleLabel.text = eventCategories[indexPath.section]
            return headerView
        } else {
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let category = eventsResponse?.categories?.keys.sorted() else { return }
        
        if let event = eventsResponse?.categories?[category[indexPath.section]]?.events?[indexPath.row] {
            let eventId = "\(event.id ?? 1)"
            let organiser = event.organizer
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "EventDetailVC") as! EventDetailVC
            vc.eventIdStr = eventId
            vc.organiserDetail = organiser
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}

extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    private func flowLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            var  groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.24), heightDimension: .absolute(180))
            
            
            var group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            group.interItemSpacing = .fixed(10)
            
            
            groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.45), heightDimension: .absolute(180))
            group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            
            section.interGroupSpacing = 5
            
            
            section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0)
            if sectionIndex == 0 || sectionIndex == 1 {
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
            } else if sectionIndex == 2 {
                section.orthogonalScrollingBehavior = .groupPaging
            }
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            section.boundarySupplementaryItems = [header]
            
            return section
        }
        
        return layout
    }
}


