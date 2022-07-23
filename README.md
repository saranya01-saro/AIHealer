# AI_HEALER
To design a mobile application to analyse the mood of the user from their journal and on that basis, required contents like inspirational quotes are recommended to lift up their mood.
AI Healer is a mobile application which will recommend songs, food and quotes based on the mood of the user detected from the short notes that the user has given. 

Software requirements:
Front end - Flutter
Back end - Python

Libraries used:
Numpy
NLTK
Regex
Sklearn
Pandas

Flutter:
main.dart:
This file create route for all the screens in the app.

welcome_screen.dart:
This screen contains app logo and app name.
It also has two rounded button one for login and other for register.

login_screen.dart:
This screen contains two textfields and a roundedbutton to submit the information which includes mail id and password.
This is only for registered users.

registration_screen.dart:
This screen contains two textfields and a roundedbutton to submit the information which includes mail id and password.
This is for new users.

chat_screen.dart:
It contains a textfield where we get the user input.
The already collected inputs are stored in firebase and will be updated in the screen upon loading.
On submitting the details it will be redirected to recommendation page.

recomscreen.dart:
It contains three rounded buttons.
See foods button redirects to food recommendation page.
Hear Songs button redirects to music recommendation page.
See Quotes button redirects to quotes recommendation page.

fooddisplay.dart:
This page displays the recommended foods.

quotesdisplay.dart:
This page displays the recommended quote.

audioplayer_with_url.dart:
This page plays the recommended song.

These recommendations are done based on analysing the user input.
All these work are done using an api created using flask.

app.py:
'/emotion'
tweet_emotion.csv is the dataset containing twitter tweets and its emotion.
Preprocessing is done to the dataset and multiclass classification is performed and the model is stored as a pickle file(model.pkl).This file is loaded and used in the flask "app.py" to predict the emotion for user input.

'/quotes'
quotes_filtered_2.csv is the dataset containing quotes.Similarity is found between user input and quotes and the most similar quotes is returned.

'/song'
songs.csv contains link to songs and its emotion.Randomly a song which matches the emotion of the user is chosen.The link for the same is returned.

![alt text](https://github.com/harinioo/AI_HEALER/blob/main/images/first.jpeg?raw=true)
![alt text](https://github.com/harinioo/AI_HEALER/blob/main/images/second.jpeg?raw=true)
![alt text](https://github.com/harinioo/AI_HEALER/blob/main/images/third.jpeg?raw=true)
![alt text](https://github.com/harinioo/AI_HEALER/blob/main/images/four.jpeg?raw=true)
![alt text](https://github.com/harinioo/AI_HEALER/blob/main/images/five.jpeg?raw=true)
![alt text](https://github.com/harinioo/AI_HEALER/blob/main/images/six.jpeg?raw=true)
![alt text](https://github.com/harinioo/AI_HEALER/blob/main/images/seven.jpeg?raw=true)
![alt text](https://github.com/harinioo/AI_HEALER/blob/main/images/eight.jpeg?raw=true)



