//
//  SecondViewController.swift
//  TopMovies
//
//  Created by Vipin Jain on 03/10/23.
//

import UIKit

class SecondViewController: UIViewController {

  var recieveData : Movie?
    
    private lazy var containerVw :UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        return vw
    }()
    private lazy var contentStackVw :UIStackView = {
        let stackVw = UIStackView()
        stackVw.translatesAutoresizingMaskIntoConstraints = false
        stackVw.spacing = 4
        stackVw.axis = .vertical
        return stackVw
    }()
    private lazy var titleLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.font = .systemFont(ofSize: 18, weight: .bold)
        return lbl
    }()
    private lazy var yearLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.font = .systemFont(ofSize: 15, weight: .light)
        return lbl
    }()
    private lazy var imdbLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.font = .systemFont(ofSize: 15, weight: .light)
        return lbl

    }()
    private lazy var descriptionLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.font = .systemFont(ofSize: 15, weight: .light)
        return lbl
    }()
    private lazy var imgLbl : UIImageView = {
        let imgVw = UIImageView()
        imgVw.contentMode = .scaleAspectFit
        imgVw.translatesAutoresizingMaskIntoConstraints = false
      
        return imgVw
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.configure()
       
    }
    func configure()
    {
        view.addSubview(containerVw)
        containerVw.addSubview(self.imgLbl)
        containerVw.addSubview(titleLbl)
        
        containerVw.addSubview(contentStackVw)
        contentStackVw.addArrangedSubview(yearLbl)
        contentStackVw.addArrangedSubview(imdbLbl)
        contentStackVw.addArrangedSubview(descriptionLbl)
        if let title = recieveData?.title {
            titleLbl.text = "\(title)"
        }
        if let year = recieveData?.year {
            yearLbl.text = "Year: \(year)"
        }
       // print(item.title)

       // print(item.year)
        imdbLbl.text = "Imdb: \(String(describing: recieveData?.rating ?? ""))"
        descriptionLbl.text = recieveData?.description
       
        if let imageUrl = URL(string: recieveData?.image ?? "https://www.pexels.com/photo/green-tree-268533/") {
            URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
                if error == nil, let imageData = data {
                    // Update the UI on the main thread
                    DispatchQueue.main.async {
                        self.imgLbl.image = UIImage(data: imageData)
                    }
                }
            }.resume()
        }
        NSLayoutConstraint.activate([
            
            containerVw.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerVw.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            containerVw.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            containerVw.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            imgLbl.topAnchor.constraint(equalTo: containerVw.topAnchor, constant: 10),
            imgLbl.leadingAnchor.constraint(equalTo: containerVw.leadingAnchor, constant: 5),
            imgLbl.trailingAnchor.constraint(equalTo: containerVw.trailingAnchor, constant: -5),
            imgLbl.widthAnchor.constraint(equalToConstant: 500),
            titleLbl.topAnchor.constraint(equalTo: imgLbl.bottomAnchor, constant: 8),
      
            contentStackVw.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 5),
            contentStackVw.leadingAnchor.constraint(equalTo: containerVw.leadingAnchor, constant: 8),
            contentStackVw.trailingAnchor.constraint(equalTo: containerVw.trailingAnchor, constant: -8)
        ])

    }
  
    
    
    
}
// MARK: - Unit Testing
#if DEBUG
extension SecondViewController {
  var testHooks: TestHooks {
    return TestHooks(target: self)
  }
  struct TestHooks {
    private let target: SecondViewController
    fileprivate init(target: SecondViewController) {
      self.target = target
    }
    var titleLbl: UILabel {
      target.titleLbl
    }
    var yearLbl: UILabel {
      target.yearLbl
    }
    var imdbLbl: UILabel {
      target.imdbLbl
    }

    func configure() {
        target.configure()
    }
  }
}
#endif

