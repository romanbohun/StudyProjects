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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
}

class MyViewController2: UIViewController {
    var image = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "vc2"
        self.view.backgroundColor = UIColor.white
        
        initImage()
        
//        let imageUrl: URL = URL(string: "https://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg")!
//
//        if let data = try? Data(contentsOf: imageUrl) {
//            self.image.image = UIImage(data: data)
//        }
        
        loadImage("https://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        image.center = self.view.center
    }
    
    func initImage() {
        image.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        
        self.view.addSubview(image)
    }
    
    func loadImage(_ adress: String) {
        let imageUrl: URL = URL(string: adress)!
        
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            if let data = try? Data(contentsOf: imageUrl) {
                DispatchQueue.main.async {
                    self.image.image = UIImage(data: data)
                }
            }
        }
    }
}

let vc = MyViewController()
let navbar = UINavigationController(rootViewController: vc)

PlaygroundPage.current.liveView = navbar
