import UIKit
import FloatingPanel

class WatchListVC: UIViewController {
    
    private var searchTimer: Timer?
    private var panel: FloatingPanelController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Lifecycle
        
        view.backgroundColor = .systemBackground
        setupTitleView()
        setUpSearchResultsVC()
        setUpFloatingPanel()
    }
    
    // MARK: - Private
    
    private func setUpFloatingPanel() {
        let vc = NewVC()
        let panel = FloatingPanelController(delegate: self)
        
        panel.surfaceView.backgroundColor = .secondarySystemBackground
        panel.set(contentViewController: vc)
        
        panel.addPanel(toParent: self)
        panel.track(scrollView: vc.tableView)
    }
    
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
              let resultVC = searchController.searchResultsController as? SearchResultsVC,
              !query.trimmingCharacters(in: .whitespaces).isEmpty
        else {
            return
        }
        
        // Reset timer
        searchTimer?.invalidate()
        
        // Optimize to reduce number of searches for when user stops typing
        searchTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { _ in
            // Call API to search
            APICaller.shared.search(query: query) { result in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        resultVC.update(with: response.result)
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        resultVC.update(with: [])
                    }
                    print(error)
                }
            }
        }
    }
}

extension WatchListVC: SearchResultsVCDelegate {
    
    func searchResultsVCDidSelect(searchResult: SearchResult) {
        navigationItem.searchController?.searchBar.resignFirstResponder()
        
        let vc = StockDetailsVC()
        vc.title = searchResult.description
        
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true)
    }
    
}

extension WatchListVC: FloatingPanelControllerDelegate {
    func floatingPanelDidChangeState(_ fpc: FloatingPanelController) {
        navigationItem.titleView?.isHidden = fpc.state == .full
    }
}
