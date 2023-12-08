import Foundation

let concurrentQueue = DispatchQueue(label: "com.example.concurrentQueue", attributes: .concurrent)
var accountBalance = 1000
let balanceSemaphore = DispatchSemaphore(value: 1)

func withdraw(amount: Int) {
  concurrentQueue.async {
    balanceSemaphore.wait()
    defer {
      balanceSemaphore.signal()
    }
    
    if accountBalance >= amount { // Simulate delay for demonstration purposes
      Thread.sleep(forTimeInterval: 1)
      accountBalance -= amount
      print("Withdrawal successful. Remaining balance: \(accountBalance)")
    } else {
      print("Insufficient funds")
    }
  }
}

func refillBalance(amount: Int) {
  concurrentQueue.async {
    balanceSemaphore.wait()
    defer {
      balanceSemaphore.signal()
    }
    
    // Simulate delay for demonstration purposes
    Thread.sleep(forTimeInterval: 1)
    accountBalance += amount
    print("Refill successful. Remaining balance: \(accountBalance)")
  }
}

// Simulate multiple withdrawals happening concurrently
for _ in 1...5 {
  withdraw(amount: 150)
  refillBalance(amount: 200)
}
