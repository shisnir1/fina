

import UIKit

class HomeViewController: UIViewController {
    

    @IBOutlet weak var moviesTableView: UITableView!
     let apiManager = Api()
        var trendingMovies: [MovieResultModel] = []
        var popularMovies: [MovieResultModel] = []
        var bestDrama: [MovieResultModel] = []
        
        
        override func viewDidLoad() {
            super.viewDidLoad()

            // Do any additional setup after loading the view.
            let nib = UINib(nibName: "moviesTableViewCell", bundle: nil)
            moviesTableView.register(nib, forCellReuseIdentifier: "moviesTableViewCell")
            
            self.moviesTableView.dataSource = self
            self.moviesTableView.delegate = self
            
            
            apiManager.getTrendingMovies { (response, error) in
                if let response = response as? [MovieResultModel] {
                    
                        self.trendingMovies = response
                        //print(item)
                    //print(self.trendingMovies)
                    DispatchQueue.main.async {
                        self.moviesTableView.reloadData()
                    }
                    print("data from trending API is recieved")
                }
            }
            
            apiManager.getPopularMovies { (response, error) in
                if let response = response as? [MovieResultModel] {
                        self.popularMovies = response
                        //print(item)
                    //print(self.popularMovies)
                    DispatchQueue.main.async {
                        self.moviesTableView.reloadData()
                    }
                    print("data from popular movies API is recieved")
                    
                }
            }
            
            apiManager.getBestDrama { (response, error) in
                if let response = response as? [MovieResultModel] {
                   
                        self.bestDrama = response
                    
                    //print(self.bestDrama)
                    DispatchQueue.main.async {
                        self.moviesTableView.reloadData()
                    }
                    print("data from best drama API is recieved")
                }
            }
            
        }
    }

    extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 3
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = moviesTableView.dequeueReusableCell(withIdentifier: "moviesTableViewCell", for: indexPath) as! moviesTableViewCell
            if indexPath.section == 0 {
                cell.movieArray = trendingMovies
                cell.trending = true
            }
            else if indexPath.section == 1 {
                cell.movieArray = popularMovies
                cell.trending = false
            }
            else {
                cell.movieArray = bestDrama
                cell.trending = false
            }
            cell.index = indexPath.row
            cell.delegate  = self
            return cell
            
    }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 300
        }
        
}

    extension HomeViewController: MovieCellTableViewDelegate {
        func selectedRow(withArray array: [MovieResultModel], index: Int) {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(identifier: "MovieDetailsViewController") as! MovieDetailsViewController
            vc.arrayOfMovieResult = array
            vc.indexOfMovie = index
            self.navigationController?.pushViewController(vc, animated: true)
        }

    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



