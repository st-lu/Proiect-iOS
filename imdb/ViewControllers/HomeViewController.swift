//
//  HomeViewController.swift
//  imdb
//
//

import UIKit
import CoreData

class HomeViewController: UIViewController {
    
    @IBOutlet weak var reviewsTableView: UITableView!
    
    @IBOutlet weak var addReviewButton: UIButton!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var items:[Review]?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        reviewsTableView.dataSource = self
        reviewsTableView.delegate = self
        
        fetchReviews()
        
    }
    
    func fetchReviews(){
        do{
            self.items = try context.fetch(Review.fetchRequest())
                    
            DispatchQueue.main.async{
                self.reviewsTableView.reloadData()
            }
        }
        catch{
            //throw err
        }
    }
    
    @IBAction func addReviewTapped(_ sender: Any) {
        let alert = UIAlertController(title: "What is your name?", message:"", preferredStyle: .alert)
        
        alert.addTextField()
        
        let submitButton = UIAlertAction(title: "Next", style: .default){ (action) in
            let textfield = alert.textFields![0]
            
            let newReview = Review(context: self.context)
            
            newReview.name = textfield.text
            newReview.movie = "Pulp Fiction"
            newReview.rating = "10"
            newReview.reviewContents = "foarte tare"
            
            try! self.context.save()
            
            self.fetchReviews()
        }
        alert.addAction(submitButton)
        
        self.present(alert, animated: true, completion: nil)
    }
}



extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let review = self.items![indexPath.row]
        
        let alert = UIAlertController(title: "Edit Review", message:"Edit name:", preferredStyle: .alert)
        alert.addTextField()
        
        let textfield = alert.textFields![0]
        textfield.text = review.name
        
        let saveButton = UIAlertAction(title:"Save", style:.default){ (action) in
            let textfield = alert.textFields![0]
            
            review.name = textfield.text
            
            try! self.context.save()
            
            self.fetchReviews()
        }
        alert.addAction(saveButton)
        self.present(alert, animated:true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath)
        
        let review = self.items![indexPath.row]
        cell.textLabel?.text = review.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            let reviewToRemove = self.items![indexPath.row]
            
            self.context.delete(reviewToRemove)
            
            try! self.context.save()
            
            self.fetchReviews()
            
        }
        return UISwipeActionsConfiguration(actions:[action])
    }
}
