# Raffle Maker
SwiftUI application using custom Raffle Ticket Creator [API](https://raffle-fs-app.herokuapp.com) with URLSession dataTask to send and receive
Application allows users to Create new raffles, add participants to existing raffles and if the user knows the secret token for the raffle then they can also draw a winner for the raffle

Instructions

1. Select New Raffle in top right to create a mew raffle
2. Raffle's require a name and a token for creation - both of type String
3. Press Create button and new raffle appears at the bottom of the list
4. Select created raffle - Sorted by raffle ID number on the main screen
5. Select new participant button to add new participant
6. Fill out the form as stated - phone number is optional (as section head hows)
7. Pressing clear will clear the form if mistakes were made
8. Pressing the save button will add new participant to the current raffle being views and dismiss the current view
9. Pressing select winning on details will randomly select someone from the Participants list to win the raffle

Have Fun!!

TODO List:
- [ ] Alert setup
- [ ] Sort Raffles
- [ ] Guard the ability to add to the participant list without the secret token
- [ ] Animation showing winner action
