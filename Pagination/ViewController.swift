//
//  ViewController.swift
//  Pagination
//
//  Created by George Kyrylenko on 11/21/18.
//  Copyright © 2018 George Kyrylenko. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    var movies = Variable<[Result]>([])
    var page = 0
    let disposeBag = DisposeBag()
    @IBOutlet weak var moviestableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviestableView.estimatedRowHeight = 135
        registrCells()
        bindToTableView()
        getFilms()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func registrCells(){
        moviestableView.register(UINib(nibName: Cells.film.rawValue, bundle: nil), forCellReuseIdentifier: Cells.film.rawValue)
    }
    
    func bindToTableView(){
        movies.asObservable().bind(to: moviestableView.rx.items(cellIdentifier: Cells.film.rawValue,
                                                                    cellType: Film.self)){ (row, element, cell) in
                cell.setData(film: element)
            }.disposed(by: disposeBag)
        
        moviestableView.rx.willDisplayCell.subscribe(onNext: {[weak self] cellInfo in
            let (_, indexPath) = cellInfo
            guard let this = self else { return }
            if indexPath.row == this.movies.value.count - 1,
                this.page == this.movies.value.count/20
            {
                this.getFilms()
            }
        }).disposed(by: disposeBag)
    }
    
    func getFilms(){
        page += 1
        let provider = MoyaProvider<ApiAPI>()
        provider.rx.request(.Request(api_key: "e5ab414f43f4eb21d01075301f4bcddf", page: page)).retry(3).subscribe(onSuccess: {[weak self] (response) in
            do{
                let data = response.data
                let json = try JSONDecoder().decode(Films.self, from: data)
                guard let results = json.results else { return }
                self?.movies.value += results
            }catch let error{
                self?.showAlert(text: error.localizedDescription)
            }
        }) {[weak self] (error) in
            self?.showAlert(text: error.localizedDescription)
            }.disposed(by: disposeBag)
    }
    
    func showAlert(text: String){
        let alert = UIAlertController(title: text, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

enum Cells: String{
    case film = "Film"
}
