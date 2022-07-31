//
//  ClosedPRTableViewCell.swift
//  NaviAssignment1
//
//  Created by Nancy Jain on 30/07/22.
//

import UIKit

class ClosedPRTableViewCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var createdDate: UILabel!
    @IBOutlet weak var closedDate: UILabel!
    
    private var urlString: String = ""
    
    func setCellWithValuesOf(_ userDetails:UserDetails) {
        updateUI(title: userDetails.title, created_at: userDetails.created_at, closed_at: userDetails.closed_at, login: userDetails.user.login, avatar_url: userDetails.user.avatar_url)
    }
    private func updateUI(title: String?, created_at: String?, closed_at: String?, login: String?, avatar_url: String ) {
        self.title.text = title
        self.userName.text = login
        self.createdDate.text = convertDateFormatter(created_at)
        self.closedDate.text = convertDateFormatter(closed_at)
//        self.userImage.image = UIImage(avatar_url)
        guard let userImageURL = URL(string: avatar_url) else {
            self.userImage.image = UIImage(named: "noImageAvailable")
            return
        }
        //Before downloading the image, remove the previous one
        self.userImage.image = nil
        getImageData(url: userImageURL)
    }
    
    func getImageData(url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            guard let data = data else {
                print("Empty Data")
                return
            }
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self.userImage.image = image
                }
            }
        }.resume()
    }
    // Convert Date format
    func convertDateFormatter(_ date: String?) -> String {
        var fixDate = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let oldDate = date {
            if let newDate = dateFormatter.date(from: oldDate) {
                dateFormatter.dateFormat = "dd.MM.yyyy"
                fixDate = dateFormatter.string(from: newDate)
            }
        }
        return fixDate
    }
}
