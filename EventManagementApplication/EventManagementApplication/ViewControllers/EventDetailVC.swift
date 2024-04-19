//
//  EventDetailVC.swift
//  EventManagementApplication
//
//  Created by Divya Sarvepalli on 3/10/24.
//

import UIKit
import AnimatedGradientView
import SDWebImage

class EventDetailVC: UIViewController, UICollectionViewDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    var eventIdStr = ""
    var eventDetails: [EventData] = []

    var organiserDetail: Organizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let animatedGradient = AnimatedGradientView(frame: view.bounds)
                animatedGradient.direction = .up
                animatedGradient.animationValues = [(colors: ["#A9F5F2", "#F5F6CE"], .up, .axial),
                                                    (colors: ["#F5A9D0", "#2ECCFA", "#BEF781"], .right, .axial),
                                                    (colors: ["#ECE0F8", "#819FF7"], .down, .axial),
                                                    (colors: ["#58FAF4", "#F4FA58", "#A9A9F5"], .left, .axial)]
                view.addSubview(animatedGradient)
                view.sendSubviewToBack(animatedGradient)
    //    fetchEventDetails()
        
        
        let layout = CollectionViewFlowLayout()
        collectionView.collectionViewLayout = layout

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(EventDetailCell.self, forCellWithReuseIdentifier: "EventDetailCell")
        self.collectionView.reloadData()
    }
    
//    func fetchEventDetails() {
//        DataManager.shared.fetchEventDetails(eventID: eventIdStr) { result in
//            switch result {
//            case .success(let eventDetailResponse):
//                if let eventData = eventDetailResponse.data {
//                    self.eventDetails = eventData
//                    DispatchQueue.main.async {
//                        self.collectionView.reloadData()
//                    }
//                } else {
//                    print("No event data found")
//                }
//            case .failure(let error):
//                print("Error fetching event details: \(error)")
//            }
//        }
//    }
}

extension EventDetailVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eventDetails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCell", for: indexPath) as! EventCell
        let eventDetail = eventDetails[indexPath.item]
        cell.titleLabel.text = (eventDetail.organizerName ?? "")
        cell.titleLabel.numberOfLines = 1
        cell.price?.text =  "Budget : \(eventDetail.price ?? 0)"
        
      
        let imageUrl = URL(string:eventDetail.image?.first ?? "")
        cell.eventImage.sd_setImage(with:imageUrl, placeholderImage: UIImage(named: "no_image"),options: SDWebImageOptions(rawValue: 0), completed: { (img, err, cacheType, imgURL) in
        })
            
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let eventDetail = eventDetails[indexPath.item]
        let vc = storyboard?.instantiateViewController(withIdentifier: "EventBookingVC") as! EventBookingVC
        vc.eventData = eventDetail
      //  vc.organiserDetail = organiserDetail
        navigationController?.pushViewController(vc, animated: true)
    }
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 250)
    }

// Assuming you have set up EventDetailCell class
class EventDetailCell: UICollectionViewCell {
    let titleLabel: UILabel = {
        let label = UILabel()
        // Customize label properties as needed
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Add titleLabel to cell's contentView and set up constraints
        contentView.addSubview(titleLabel)
        // Add constraints here
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        configureLayout()
    }

    private func configureLayout() {
        guard let collectionView = collectionView else { return }

        let availableWidth = collectionView.bounds.width - sectionInset.left - sectionInset.right
        let itemWidth = (availableWidth - minimumInteritemSpacing) / 2

        itemSize = CGSize(width: itemWidth, height: itemWidth)
    }
}
