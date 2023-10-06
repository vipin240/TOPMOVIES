

import UIKit
protocol MovieTableViewCellDelegate : AnyObject {
    func tableViewCellTap(for item : Movie)
}

 class MovieTableViewCell : UITableViewCell{
    static let cellId = "MovieTableViewCell"
     weak var delegate : MovieTableViewCellDelegate?
      var dataPass : Movie?
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
        lbl.font = .systemFont(ofSize: 15, weight: .bold)
        return lbl
    }()
    private lazy var yearLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.font = .systemFont(ofSize: 12, weight: .light)
        return lbl
    }()
    private lazy var imdbLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.font = .systemFont(ofSize: 12, weight: .light)
        return lbl

    }()
    private lazy var descriptionLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.font = .systemFont(ofSize: 12, weight: .light)
        return lbl
    }()
    private lazy var imgLbl : UIImageView = {
        let imgVw = UIImageView()
        imgVw.contentMode = .scaleAspectFit
        imgVw.translatesAutoresizingMaskIntoConstraints = false
      
        return imgVw
    }()
    private lazy var nxtbtn: UIButton = {
       let myButton = UIButton()
        myButton.setTitle("See More", for: .normal)
              myButton.setTitleColor(.white, for: .normal)
              myButton.backgroundColor = .blue
              myButton.layer.cornerRadius = 8
        myButton.translatesAutoresizingMaskIntoConstraints = false
        return myButton
        
    }()
    
    func configure(with item: Movie , with index : Int){
      
        titleLbl.text = "\(index + 1). \(item.title)"
       // print(item.title)
        yearLbl.text = "Year: \(String(item.year))"
       // print(item.year)
        imdbLbl.text = "Imdb: \(item.rating)"
        descriptionLbl.text = item.description
        nxtbtn.addTarget(self, action: #selector(tableViewCellTap), for: .touchUpInside)
        dataPass = item
        if let imageUrl = URL(string: item.image) {
            URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
                if error == nil, let imageData = data {
                    // Update the UI on the main thread
                    DispatchQueue.main.async {
                        self.imgLbl.image = UIImage(data: imageData)
                    }
                }
            }.resume()
        }

    }
     
       
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addConstraint() {
        self.contentView.addSubview(self.containerVw)
        containerVw.backgroundColor = .systemGray6
        self.containerVw.addSubview(self.imgLbl)
       
        self.containerVw.addSubview(self.contentStackVw)
        self.contentStackVw.addArrangedSubview(titleLbl)
        titleLbl.textAlignment = .center
        
        self.contentStackVw.addArrangedSubview(yearLbl)
        self.contentStackVw.addArrangedSubview(imdbLbl)
        self.contentStackVw.addArrangedSubview(descriptionLbl)
        self.contentStackVw.addArrangedSubview(nxtbtn)
        
        NSLayoutConstraint.activate(
        [
            containerVw.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            containerVw.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
            containerVw.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            containerVw.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
            contentStackVw.topAnchor.constraint(equalTo: self.containerVw.topAnchor, constant: 2),
            contentStackVw.bottomAnchor.constraint(equalTo: self.containerVw.bottomAnchor, constant: -8),
            contentStackVw.leadingAnchor.constraint(equalTo: self.imgLbl.trailingAnchor, constant: 8),
            contentStackVw.trailingAnchor.constraint(equalTo: self.containerVw.trailingAnchor, constant: -8),
            imgLbl.heightAnchor.constraint(equalToConstant: 100),
            imgLbl.widthAnchor.constraint(equalToConstant: 100),
            imgLbl.topAnchor.constraint(equalTo: contentStackVw.topAnchor, constant: 4),
            imgLbl.leadingAnchor.constraint(equalTo: containerVw.leadingAnchor, constant: 8)

          
        
        ])
    }
     @objc func tableViewCellTap(){
         delegate?.tableViewCellTap(for : self.dataPass!)
     }
    
}


// MARK: - Unit Testing
#if DEBUG
extension MovieTableViewCell {
  var testHooks: TestHooks {
    return TestHooks(target: self)
  }
  struct TestHooks {
    private let target: MovieTableViewCell
    fileprivate init(target: MovieTableViewCell) {
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

    func configure(movie: Movie, index: Int) {
        target.configure(with: movie, with: index)
    }
  }
}
#endif
