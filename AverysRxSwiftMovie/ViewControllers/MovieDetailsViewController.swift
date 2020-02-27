//
//  MovieDetailViewController.swift
//  AverysRxSwiftMovie
//
//  Created by AveryW on 2/24/20.
//  Copyright © 2020 Avery. All rights reserved.
//

import UIKit
import RxSwift
import Nuke

final class MovieDetailsViewController: UIViewController {
    
    var movie: Movie!

    let scrollView = UIScrollView()
    let stackView = UIStackView()
    var movieTitleLabel : UILabel = UILabel()
    var movieOverviewLabel : UILabel = UILabel()
    var movieReleaseDateLabel : UILabel = UILabel()
    var moviePosterImageView : UIImageView = UIImageView()
    private let basePoster = "http://image.tmdb.org/t/p"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    fileprivate func configureUI() {
        self.view.backgroundColor = .white
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false;

        self.view.addSubview(self.scrollView)
        
        // Constrain scroll view
        self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true
        self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true
        
        // Add and setup stack view
        self.scrollView.addSubview(self.stackView)
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.axis = .vertical
        self.stackView.spacing = 10
        self.stackView.distribution = .fillProportionally

        // Constrain stack view to scroll view
        self.stackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor).isActive = true
        self.stackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        self.stackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor).isActive = true
        self.stackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
        
        self.stackView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor).isActive = true

        movieTitleLabel.numberOfLines = 0
        movieTitleLabel.lineBreakMode = .byWordWrapping
        movieTitleLabel.textAlignment = NSTextAlignment.center
        movieTitleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        movieTitleLabel.text = movie.title
        movieTitleLabel.contentMode = .scaleAspectFit
        
        let releaseDate = getDateString(movie.releaseDate!)
        movieReleaseDateLabel.numberOfLines = 0
        movieReleaseDateLabel.lineBreakMode = .byWordWrapping
        movieReleaseDateLabel.textAlignment = NSTextAlignment.center
        movieReleaseDateLabel.text = "Released: \(releaseDate ?? "Sorry no information is available")"
        movieReleaseDateLabel.contentMode = .scaleAspectFit
        
        movieOverviewLabel.lineBreakMode = .byWordWrapping
        movieOverviewLabel.textAlignment = NSTextAlignment.left
        movieOverviewLabel.numberOfLines = 0
        movieOverviewLabel.text = "Synopsis: \n\(movie.overview)"
        
        moviePosterImageView.contentMode = .scaleAspectFit
        
        // Get the url for the movie poster
        if let path = movie.posterPath, let imageBaseUrl = URL(string: basePoster) {
            let posterPath = imageBaseUrl
                .appendingPathComponent("w300")
                .appendingPathComponent(path)
            
            // Use Nuke to load the imageview with a url
            Nuke.loadImage(with: posterPath, into: moviePosterImageView)
        }
        
        self.stackView.addArrangedSubview(movieTitleLabel)
        self.stackView.addArrangedSubview(movieReleaseDateLabel)
        self.stackView.addArrangedSubview(moviePosterImageView)
        self.stackView.addArrangedSubview(movieOverviewLabel)
    }
    
    fileprivate func getDateString(_ dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let newFormat = DateFormatter()
        newFormat.dateFormat = "MMM dd, yyyy"
        if let date = dateFormatter.date(from: dateString) {
            return newFormat.string(from: date)
        } else {
            return nil
        }
    }
}

