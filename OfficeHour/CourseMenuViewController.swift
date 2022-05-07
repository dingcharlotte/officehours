//
//  CourseMenuViewController.swift
//  OfficeHour
//
//  Created by Charlotte Ding on 5/1/22.
//

import UIKit

/**
 class RequestsViewController: UIViewController {

     let requestsTableView = UITableView()
     let requestReuseIdentifier = "requestReuseIdentifier"

     var requestsData: [Request] = []
     var sentRequestData: [Request] = [
         Request(id: 1, senderId: 5, senderName: "five", senderUsername: "fv55", receiverId: 6, receiverName: "six"),
         Request(id: 3, senderId: 5, senderName: "five", senderUsername: "fv55", receiverId: 7, receiverName: "seven")
     ]
     var receivedRequestData: [Request] = [
         Request(id: 2, senderId: 6, senderName: "six", senderUsername: "sx66", receiverId: 5, receiverName: "five"),
         Request(id: 4, senderId: 7, senderName: "seven", senderUsername: "sv77", receiverId: 5, receiverName: "five")
     ]

     override func viewDidLoad() {
         super.viewDidLoad()
         navigationItem.title = "All Requests"
         view.backgroundColor = .white

         requestsData = sentRequestData + receivedRequestData

         setupViews()
         setupConstraints()
 //        refreshData()
     }

     ///  Orders 'requestsData' from oldest to newest.
     func sortRequestsData() {
         requestsData.sort { (leftPost, rightPost) -> Bool in
             return leftPost.id < rightPost.id
         }
     }

     func setupViews() {
         requestsTableView.dataSource = self
         requestsTableView.delegate = self
         requestsTableView.register(RequestsTableViewCell.self, forCellReuseIdentifier: requestReuseIdentifier)
         requestsTableView.translatesAutoresizingMaskIntoConstraints = false
         view.addSubview(requestsTableView)
     }

     func setupConstraints() {
         NSLayoutConstraint.activate([
             requestsTableView.topAnchor.constraint(equalTo: view.topAnchor),
             requestsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
             requestsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             requestsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
         ])
     }

 }

 */

class CourseMenuViewController: UIViewController {

    let coursesTableView = UITableView()
    let coursesReuseIdentifier = "coursesReuseIdentifier"

    var subjects: [Subject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Courses"

        // MARK: use getAllSubjects
        NetworkManager.getAllSubjects { [weak self] subjects in
            guard let self = self else { return }
            self.subjects = subjects
            self.coursesTableView.reloadData()
        }

        setupViews()
        setupConstraints()
    }

    func setupViews() {
        coursesTableView.dataSource = self
        coursesTableView.delegate = self
        coursesTableView.register(UITableViewCell.self, forCellReuseIdentifier: coursesReuseIdentifier)
        coursesTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(coursesTableView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            coursesTableView.topAnchor.constraint(equalTo: view.topAnchor),
            coursesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            coursesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            coursesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
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

extension CourseMenuViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: coursesReuseIdentifier, for: indexPath)
        let subject = subjects[indexPath.row]
        cell.textLabel?.text = subject.name
        return cell
    }
}

extension CourseMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let courseViewController = CourseViewController()
        courseViewController.subjectId = subjects[indexPath.row].id
        courseViewController.subjectName = subjects[indexPath.row].name
        navigationController?.pushViewController(courseViewController, animated: true)
    }
}
