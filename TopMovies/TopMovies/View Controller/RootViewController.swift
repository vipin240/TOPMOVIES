

import UIKit

class RootViewController: UIViewController {
   var movies : [Movie]?

    private var tableVw : UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.estimatedRowHeight = 44
        tv.separatorStyle = .none
        tv.rowHeight = UITableView.automaticDimension
        tv.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieTableViewCell")
        return tv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        tableVw.dataSource = self
        setup()
        
        NetworkManager().callAPI{ [weak self] movies in
            DispatchQueue.main.async {
             self?.movies = movies
             self?.tableVw.reloadData()
            }
        }
    }

   
}
private extension RootViewController{
    func setup(){
        self.navigationController?.navigationBar.topItem?.title = "Top 100 Movies"
     //  self.navigationController?.navigationBar.prefersLargeTitles = true
        //tableVw.dataSource = self
        self.view.addSubview(tableVw)
//    tableVw.register( , forCellReuseIdentifier: MovieTableViewCell.cellId)
        self.navigationController?.navigationBar.backgroundColor = .white
        NSLayoutConstraint.activate([
            tableVw.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableVw.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            tableVw.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableVw.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)

        ])
    }
}


extension RootViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableVw.dequeueReusableCell(withIdentifier: MovieTableViewCell.cellId , for: indexPath) as? MovieTableViewCell {
            if let movie = movies?[indexPath.row] {
               // print(movie.title)
                cell.configure(with: movie , with: indexPath.row)
                cell.delegate = self
                return  cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // print(self.movies!.count)
        if let count = movies?.count {
            return count
        }
        return 0
    }
}
extension RootViewController :  MovieTableViewCellDelegate {
    func tableViewCellTap(for item : Movie){
        let vc2 = SecondViewController()
        vc2.recieveData = item
        navigationController?.pushViewController(vc2, animated: true)
    }
}
