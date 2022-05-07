//
//  CourseViewController.swift
//  OfficeHour
//
//  Created by Charlotte Ding on 5/1/22.
//

import UIKit

class CourseViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    
    private var tutors: [Person] = [    // dummy data
//        Person(id: 1, username: "cd494", name: "Charlotte Ding", bio: "so tired", price: 10, isAvailable: true, subjects: [Subject(id: 1, name: "MATH"), Subject(id: 2, name: "ECON")], sentRequests: [], receivedRequests: []),
//        Person(id: 2, username: "dc692", name: "Daniela Carmona", bio: "cool", price: 11, isAvailable: true, subjects: [Subject(id: 1, name: "MATH"), Subject(id: 2, name: "ECON"), Subject(id: 3, name: "PHYSICS")], sentRequests: [], receivedRequests: []),
//        Person(id: 3, username: "jwz28", name: "Julia Zeng", bio: "great", price: 9, isAvailable: true, subjects: [Subject(id: 3, name: "PHYSICS")], sentRequests: [], receivedRequests: [])
    ]
    
    private let cardCellReuseIdentifier = "cardCellReuseIdentifier"

    var subjectId: Int = 0
    var subjectName: String = ""
    
    let padding: CGFloat = 15

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = subjectName
        NetworkManager.getAllTutors(subjectId: subjectId) { [weak self] tutors in
            guard let self = self else {return}
            self.tutors = tutors
            self.collectionView.reloadData()
        }
//        print(tutors)

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = padding // optional
        layout.minimumInteritemSpacing = padding // optional

        collectionView = UICollectionView(frame: .zero, collectionViewLayout:
        layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CardCollectionViewCell.self,
        forCellWithReuseIdentifier: cardCellReuseIdentifier)
        
        
        view.addSubview(collectionView)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
    }
    
    private func showAlert(title: String, body: String) {
        let alertController = UIAlertController(title: title, message: body, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in }
        alertController.addAction(okAction)
        present(alertController, animated: true)
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

extension CourseViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tutors.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cardCellReuseIdentifier, for: indexPath) as! CardCollectionViewCell
        let person = tutors[indexPath.item]
        //cell.configure(for: card)
        cell.configure(for: person, completion: { [weak self] in self?.showAlert(title: "Request sent!", body: "Request sent to \(person.name).")} )
        return cell
    }
}

extension CourseViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numItemsPerRow: CGFloat = 2.0
        let size = (collectionView.frame.width - (numItemsPerRow - 1) * padding) / numItemsPerRow
        return CGSize(width: size, height: size * 5/4)
    }
}
