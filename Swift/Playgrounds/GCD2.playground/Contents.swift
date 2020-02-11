import UIKit
import PlaygroundSupport

class MyViewController: UIViewController {
    var button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "vc1"
        
        self.view.backgroundColor = UIColor.white
        
        initButton()
        button.addTarget(self, action: #selector(pressAction), for: .touchUpInside)
        
//        afterBlock(seconds: 4, queue: .global()) {
//            print("Hello")
//            print(Thread.current)
//        }
        
        afterBlock(seconds: 4, queue: .main) {
            print("Hello")
            self.showAlert()
            print(Thread.current)
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: nil, message: "Hello", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        button.center = view.center
    }
    
    @objc func pressAction() {
        let vc = MyViewController2()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func initButton() {
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        button.setTitle("Press", for: .normal)
        button.backgroundColor = UIColor.green
        button.setTitleColor(UIColor.white, for: .normal)
        
        view.addSubview(button)
    }
    
    func afterBlock(seconds: Int, queue: DispatchQueue = DispatchQueue.global(), completion: @escaping () -> ()) {
        
        queue.asyncAfter(deadline: .now() + .seconds(seconds)) {
            completion()
        }
    }
}

class MyViewController2: UIViewController {
    var label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "vc2"
        self.view.backgroundColor = UIColor.white
        
        initLabel()
        
        
//        for i in 0...20000 {
//            print(i)
//        }
        
//        DispatchQueue.concurrentPerform(iterations: 2000) { (Int) in
//            print(Int)
//            print(Thread.current)
//        }
        
//        let queue = DispatchQueue.global(qos: .utility)
//        queue.async {
//            DispatchQueue.concurrentPerform(iterations: 20000) { (Int) in
//                print(Int)
//                print(Thread.current)
//            }
//        }
        
        myInactiveQueue()
    }
    
    func myInactiveQueue() {
        let inactiveQueue = DispatchQueue(label: "The Swift Dev", attributes: [.concurrent, .initiallyInactive])
        
        inactiveQueue.async {
            print("DONE!")
        }
        
        print("not started yet")
        inactiveQueue.activate()
        print("Activated!")
        inactiveQueue.suspend()
        print("paused!")
        inactiveQueue.resume()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        label.center = self.view.center
    }
    
    func initLabel() {
        label.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
        label.text = "Hello"
        label.textAlignment = .center
        self.view.addSubview(label)
    }
}


let vc = MyViewController()
let navbar = UINavigationController(rootViewController: vc)

PlaygroundPage.current.liveView = navbar
