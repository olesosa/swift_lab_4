import Foundation

let concurrentQueue = DispatchQueue(label: "com.example.concurrentQueue", attributes: .concurrent)
var accountBalance = 1000
let balanceQueue = DispatchQueue(label: "com.example.balanceQueue")

func withdraw(amount: Int) {
  concurrentQueue.async {
    balanceQueue.sync {
      if accountBalance >= amount { // Simulate delay for demonstration purposes
        Thread.sleep(forTimeInterval: 1)
        accountBalance -= amount
        print("Withdrawal successful. Remaining balance: \(accountBalance)")
      } else {
        print("Insufficient funds")
      }
    }
  }
}

func refillBalance(amount: Int) {
  concurrentQueue.async {
    balanceQueue.sync {
      // Simulate delay for demonstration purposes
      Thread.sleep(forTimeInterval: 1)
      accountBalance += amount
      print("Refill successful. Remaining balance: \(accountBalance)")
    }
  }
}

// Simulate multiple withdrawals happening concurrently
for _ in 1...5 {
  withdraw(amount: 150)
  refillBalance(amount: 200)
}
