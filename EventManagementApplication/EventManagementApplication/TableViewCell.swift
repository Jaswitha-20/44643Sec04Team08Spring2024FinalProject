//
//  SignUpVC.swift
//  EventManagementApplication
//
//  Created by Jaswitha Reddy on 3/9/24.
//


import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var commonTitle: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel?
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var callBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(title:String,location:String,description:String,date:String)  {
        
        self.commonTitle.text = title
        self.locationLbl.text = location
        self.descriptionLbl?.text = description
        self.dateLbl.text = date        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

