import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

class DispatchWorkItem1 {
    private let queue = DispatchQueue(label: "DispatchWorkItem1", attributes: .concurrent)
    
    func create() {
        let workItem = DispatchWorkItem {
            print(Thread.current)
            print("Start task")
        }
        
        workItem.notify(queue: .main) {
            print(Thread.current)
            print("Task finished")
        }
        
        queue.async(execute: workItem)
    }
}

//let dispatchWorkItem1 = DispatchWorkItem1()
//dispatchWorkItem1.create()


class DispatchWorkItem2 {
    private let queue = DispatchQueue(label: "DispatchWorkItem2")
    
    func create() {
        queue.async {
            print(Thread.current)
            sleep(1)
            print("Task 1")
        }
        
        queue.async {
            print(Thread.current)
            sleep(1)
            print("Task 2")
        }
        
        let workItem = DispatchWorkItem {
            print(Thread.current)
            print("Start wotk item task")
        }
        
        queue.async(execute: workItem)
        workItem.cancel()
    }
}

//let dispatchWorkItem2 = DispatchWorkItem2()
//dispatchWorkItem2.create()

var view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
var eiffelImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))

eiffelImage.backgroundColor = UIColor.yellow
eiffelImage.contentMode = .scaleAspectFit

view.addSubview(eiffelImage)
PlaygroundPage.current.liveView = view

let imageUrl = URL(string: "https://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg")!

func fetchImage() {
    let queue = DispatchQueue.global(qos: .utility)
    
    queue.async {
        if let data = try? Data(contentsOf: imageUrl) {
            DispatchQueue.main.async {
                eiffelImage.image = UIImage(data: data)
            }
        }
    }
}

//fetchImage()

func fetchImage2() {
    var data: Data? = nil
    let queue = DispatchQueue.global(qos: .utility)
    
    let workItem = DispatchWorkItem(qos: .userInteractive) {
        data = try? Data(contentsOf: imageUrl)
        print(Thread.current)
    }
    
    workItem.notify(queue: .main) {
        print(Thread.current)
        if let imageData = data {
            eiffelImage.image = UIImage(data: imageData)
        }
    }
    
    queue.async(execute: workItem)
}

//fetchImage2()

func fetchImage3() {
    let task = URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
        print(Thread.current)
        
        if let imageData = data {
            DispatchQueue.main.async {
                eiffelImage.image = UIImage(data: imageData)
            }
        }
    }
    
    task.resume()
}

fetchImage3()
