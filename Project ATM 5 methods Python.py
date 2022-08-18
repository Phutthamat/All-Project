## https://colab.research.google.com/drive/1BWg9ojeHtOX31qrXr1WhEPXDaM9FIWT8?usp=sharing

class Atm:
    def __init__(self, name, account_number, balance):
        self.name = name
        self.account_number = account_number 
        self.balance = balance

    def __str__(self):
        return "*******WELCOME TO BANK OF Bangkok Rockie*******"


    def deposit(self):
        amount = int(input("How much you want to deposit: "))
        self.amount = amount
        self.balance = self.balance + self.amount
        print(f"Current account balance: {self.balance} Baht")

    def withdraw(self):
        amount = int(input("How much you want to withdraw: "))
        self.amount = amount
        if self.amount > self.balance :
            print("Insufficient fund")
            print(f"Your balance is {self.balance} only. Try with lesser amount than balance.")
        else:
            self.balance = self.balance - self.amount 
            print("Withdrawal successful!")
            print(f"Current account balance: {self.balance} Baht")

    def check_balance(self):
        print(f"Current account balance: {self.balance} Baht")


    def transfer(self):
        trans_Acc_to = int(input("What account do you want to transfer? : "))
        trans_money = float(input("How much you want to tranfer ? : "))
        self.trans_money = trans_money
        if self.trans_money > self.balance :
            print("The process can't be done. Please check your account balance.")
            print(f"Your balance is {self.balance} only. Try with lesser amount than balance.")
        else:
            self.balance = self.balance - self.trans_money
            print("Your transfer was successful!")
            print(f"Current account balance: {self.balance} Baht")

    import random as r
    def get_otp():
        otp = ""
        for i in range(4):
            otp += str(r.randint(1,9))
        print ("OTP of 4 digits: ", otp)
   
customer1 = Atm("Fern", "1112223333", 100000)
print(customer1)

customer1.deposit()

customer1.withdraw()

customer1.check_balance()

customer1.transfer()

get_otp()
  
  
