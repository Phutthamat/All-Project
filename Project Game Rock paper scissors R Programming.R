## https://colab.research.google.com/drive/1PRfQ1W-Sn-PxmwI53RIQRXMdoNULlvq3?usp=sharing

game_rps <- function () {
  ## setting
  win <- 0
  lose <- 0
  tie <- 0
  move <- c("rock", "paper", "scissors", "quit")
  
    ## start Game
    while (T){
        player_choice <- as.numeric(readline("Rock Scissors Paper Game !! \nEnter a choice rock [1], paper [2], scissors [3], or quit [4]: "))
        player_choice <- move[player_choice]
        computer_choice <- sample(move[1:3], 1)
    
        ## Condition
        if(player_choice == "quit" ) {
          break 
        } else if (player_choice == "rock" & computer_choice == "paper") {
          print("I lose :(")
          lose <- lose + 1
        } else if (player_choice == "paper" & computer_choice == "scissors") {
          print("I lose :(")
          lose <- lose + 1
        } else if (player_choice == "scissors" & computer_choice == "rock") {
          print("I lose :(")
          lose <- lose + 1
        } else if (player_choice == "rock" & computer_choice == "scissors") {
          print("I win! :D")
          win <- win + 1
        } else if (player_choice == "paper" & computer_choice == "rock") {
          print("I win! :D")
          win <- win + 1
        } else if (player_choice == "scissors" & computer_choice == "paper" ) {
          print("I win! :D")
          win <- win + 1
        } else {
          print("We are tied !!")
          tie <- tie + 1
        }

        message("Player = ", player_choice," / Computer = ", computer_choice)
        message("Your Score : ", "  Win :  ", win, " / Lose : ", lose, " / Tie : ", tie)
        
        
      }
}
game_rps()
