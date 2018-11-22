//
//  Film.swift
//  Pagination
//
//  Created by George Kyrylenko on 11/21/18.
//  Copyright © 2018 George Kyrylenko. All rights reserved.
//

import UIKit
import Kingfisher

class Film: UITableViewCell {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var filmDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(film: Result){
        title.text = film.title
        filmDescription.text = film.overview
        guard let url = URL(string: "https://image.tmdb.org/t/p/w185_and_h278_bestv2\(film.posterPath ?? "")") else { return }
        photo.kf.setImage(with: url)
    }
    
}
