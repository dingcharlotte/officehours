//
//  RequestsViewController.swift
//  OfficeHour
//
//  Created by Charlotte Ding on 5/1/22.
//

import UIKit

class RequestsViewController: UIViewController {
    
    let requestsTableView = UITableView()
    let requestReuseIdentifier = "requestReuseIdentifier"
    
    private let refreshControl = UIRefreshControl()
    
    var requestsData: [Request] = []
    var sentRequestData: [Request] = []
    var receivedRequestData: [Request] = []
   
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "All Requests"
        view.backgroundColor = .white
        
        // requestsData = sentRequestData + receivedRequestData
        
        setupViews()
        setupConstraints()
//        refreshData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshData()
        
    }
    
    ///  Orders 'requestsData' from oldest to newest.
    func sortRequestsData() {
        requestsData.sort { (leftPost, rightPost) -> Bool in
            return leftPost.id > rightPost.id
        }
    }
    
    func setupViews() {
        requestsTableView.dataSource = self
        requestsTableView.delegate = self
        requestsTableView.register(RequestsTableViewCell.self, forCellReuseIdentifier: requestReuseIdentifier)
        requestsTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(requestsTableView)
        
        if #available(iOS 10.0, *) {
            requestsTableView.refreshControl = refreshControl
        } else {
            requestsTableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            requestsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            requestsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            requestsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            requestsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @objc func refreshData() {
        /**
         We want to retrieve data from the server here upon refresh. Make sure to
         1) Sort the posts with `sortPostData`
         2) Update `postData` & `shownPostData` and reload `postTableView`
         3) End the refreshing on `refreshControl`
        */
        NetworkManager.getUser(id: User.instance.id, completion: { [weak self] person in
            guard let self = self else {return}
            self.sentRequestData = person.sentRequests ?? []
            self.receivedRequestData = person.receivedRequests ?? []
            self.requestsData = self.sentRequestData + self.receivedRequestData
            self.sortRequestsData()
            self.requestsTableView.reloadData()
            self.refreshControl.endRefreshing()
        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension RequestsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requestsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: requestReuseIdentifier, for: indexPath) as! RequestsTableViewCell
        let request = requestsData[indexPath.row]
        cell.configure(with: request)
        return cell
    }
}

extension RequestsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    }
}
