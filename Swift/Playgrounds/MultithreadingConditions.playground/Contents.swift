import UIKit

var condition = pthread_cond_t()
var mutex = pthread_mutex_t()

class StateKeeper {
    var available: Bool = false
    
    init(_ available: Bool) {
        self.available = available
    }
}

let stateKeeper: StateKeeper = StateKeeper(false)

class ConditionMutexPrinter: Thread {
    
    override init() {
        pthread_cond_init(&condition, nil)
        pthread_mutex_init(&mutex, nil)
    }
    
    override func main() {
        doPrint()
    }
    
    private func doPrint() {
        pthread_mutex_lock(&mutex)
        print("Print method called")
        
        while (!stateKeeper.available) {
            pthread_cond_wait(&condition, &mutex)
        }
        
        stateKeeper.available = false
        
        defer {
            pthread_mutex_unlock(&mutex)
        }
        
        print("Print exit")
    }
}

class ConditionMutexWriter: Thread {
    
    override init() {
        pthread_cond_init(&condition, nil)
        pthread_mutex_init(&mutex, nil)
    }
    
    override func main() {
        doWrite()
    }
    
    private func doWrite() {
        pthread_mutex_lock(&mutex)
        print("Write method called")
        stateKeeper.available = true
        
        pthread_cond_signal(&condition)
        
        defer {
            pthread_mutex_unlock(&mutex)
        }
        
        print("Write exit")
    }
}

let conditionMutexWriter = ConditionMutexWriter()
let conditionMutexPrint = ConditionMutexPrinter()

conditionMutexPrint.start()
conditionMutexWriter.start()


//--- NSCondition

let cond = NSCondition()
var available = false

class WriterThread: Thread {
    
    override func main() {
        cond.lock()
        print("Writer thread started")
        available = true
        cond.signal()
        cond.unlock()
        
        print("Writer thread exit")
    }
}

class PrinterThread: Thread {
    
    override func main() {
        cond.lock()
        print("Printer thread started")
        
        while (!available) {
            cond.wait()
        }
        
        available = false
        cond.unlock()
        
        print("Printer thread exit")
    }
}

let conditionThreadWriter = WriterThread()
let conditionThreadPrint = PrinterThread()

conditionThreadPrint.start()
conditionThreadWriter.start()
