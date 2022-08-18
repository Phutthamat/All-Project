
## https://colab.research.google.com/drive/1yXcWf4UklTkFLXwMeQdUeMAN_mwHR4t5?usp=sharing
## function start Game
def rsp_game():
    import random
    move = ["rock","paper","scissors"]
    computer_score = 0 
    player_score = 0
    while True:
        player_choice = input("Rock Scissors Paper game ! please enter your choice(Rock,Paper,Scissors) or quit if you want to stop: ").lower()
        computer_choice = random.choice(move)

## Condition
        if player_choice == "quit" :
            print("Good bye")
            break 
        elif player_choice == "rock" and computer_choice == "paper" : 
            print("I lose.")
            computer_score += 1
        elif player_choice == "paper" and computer_choice == "scissors" : 
            print("I lose.")
            computer_score += 1
        elif player_choice == "scissors" and computer_choice == "rock" :
            print("I lose.")
            computer_score += 1
        elif player_choice == "rock" and computer_choice == "scissors" :
            print("I win!")
            player_score += 1
        elif player_choice == "paper" and computer_choice == "rock" :
            print("I win!")
            player_score += 1
        elif player_choice == "scissors" and computer_choice == "paper" :
            print("I win!")
            player_score += 1
        else :
            print("We are tied !!")
            
        print(f"Player = {player_choice} / Computer = {computer_choice}")
        print(f"Your Score : {player_score} / computer_score : {computer_score} ")

