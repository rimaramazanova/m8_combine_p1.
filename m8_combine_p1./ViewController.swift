//
//  ViewController.swift
//  m8_combine_p1.
//
//  Created by Sadyk on 12.02.2023.
//

import UIKit
import Combine
//import Playground





extension Notification.Name {
    static let test = Notification.Name("Test")
}


struct Event {
    let title:String
   // let scheduledOn: Date
}


class ViewController: UIViewController {
    
 
    
    var myTextView = UITextView()
    var myLabel = UILabel()
    var myButton = UIButton()
    var randomInt = [1...100]
    var  subscription:AnyCancellable?
   var cancellabels = Set <AnyCancellable>()
    
    @Published var canPost:Bool = false
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setuoPublisherAndSubscriber()
        
    
        myTextView = UITextView()
        // Do any additional setup after loading the view.
        
        myTextView = UITextView(frame: CGRect(x: 100, y: 150, width: 250, height: 200))
        myTextView.contentInset = UIEdgeInsets(top: 100, left: 110, bottom: 0, right: 0)
        myTextView.text = "Some text"
        myTextView.backgroundColor = .green
        myTextView.font = UIFont.systemFont(ofSize: 17)
//        myTextView.textPublisher.sink { value in
//            print(value)
//
//        }.store(in: &cancellabels)
        
        
   
       
       // myLabel = UILabel(frame: self.view.bounds)
      let labelFrame = CGRect(x: 0, y: 0, width: 150, height: 50)
        myLabel.frame = labelFrame
        myLabel.text = "My Label"
        myLabel.font = UIFont.boldSystemFont(ofSize:  24)
        myLabel.center = self.view.center
        myLabel.backgroundColor = .orange
      
        myButton = UIButton(type: .roundedRect)
        myButton.frame = CGRect(x: 100, y: 520, width: 100, height: 44)
        myButton.setTitle("My Button", for: .normal)
        myButton.backgroundColor = .green
        
        
        
       let postBlog = Event(title: "name Rima")
        NotificationCenter.default.post(name: .test, object: postBlog)
        print("My name:\(myLabel.text!)")
        
    
       self.view.addSubview(myLabel)
        self.view.addSubview(myTextView)
        self.view.addSubview(myButton)
        
        
        $canPost.receive(on: DispatchQueue.main).assign(to:\.isEnabled, on: myButton)
    
    }
    
   func setuoPublisherAndSubscriber() {
        
       let publish = NotificationCenter.Publisher(center: .default, name:.test, object: nil)
           .map ({ (notification) ->String? in
               return (notification.object as? Event)?.title ?? ""
               
           })

       let cubscribe = Subscribers.Assign(object: myLabel, keyPath: \.text)
       publish.subscribe(cubscribe)
       
          
   }
       
     }

    

//
//extension UITextView{
//    var textPublisher:AnyPublisher<String,Never>{
//        NotificationCenter.default
//            .publisher(for:
//                    UITextView
//                .textDidChangeNotification,
//                       object: self)
//            .compactMap{$0.object as? UITextView}
//            .map{$0.text ?? ""}
//            .receive(on: DispatchQueue.main) // Removing this makes it work
//            .assign(to: \.text, on: myLabel)
//            .eraseToAnyPublisher()
//
//    }
//}
    
        



