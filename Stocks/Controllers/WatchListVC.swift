import UIKit

class WatchListVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Lifecycle
        
        view.backgroundColor = .systemBackground
        setupTitleView()
        setUpSearchResultsVC()
        
    }
    
    // MARK: - Private
    private func setupTitleView() {
        
        let titleView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: view.width,
                height: navigationController?.navigationBar.height ?? 100
            )
        )
        let label = UILabel(
            frame: CGRect(
                x: 10,
                y: 0,
                width: titleView.width - 20,
                height: titleView.height
            )
        )
        
        label.text = "Stocks"
        label.font = .systemFont(ofSize: 40, weight: .medium)
        titleView.addSubview(label)
        
        navigationItem.titleView = titleView
    }
    
    private func setUpSearchResultsVC() {
        let resultVC = SearchResultsVC()
        resultVC.delegate = self
        
        let searchVC = UISearchController(searchResultsController: resultVC)
        searchVC.searchResultsUpdater = self
        navigationItem.searchController = searchVC
    }
}

extension WatchListVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text,
              let resultVC = searchController.searchResultsUpdater as? SearchResultsVC,
              !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            print("r")
            return
        }
        print(query)
        // Call API to search
//        APICaller.shared.search(query: "app") { result in
//            switch result {
//            case .success(let response):
//                print(response)
////                DispatchQueue.main.async {
////                    resultVC.update(with: response.result)
////                    print(response.result)
////                }
//            case .failure(let error):
//                print(error)
//            }
//        }
        
        // Update results controllers
    }
}

extension WatchListVC: SearchResultsVCDelegate {
    
    func searchResultsVCDidSelect(searchResult: SearchResult) {
        print("Did select: \(searchResult)")
    }

}
