import random as r
import re
from password_generator import PasswordGenerator
import string
import requests
import os
from dotenv import load_dotenv

load_dotenv()
APIKEY = os.getenv('KEY')


pwo = PasswordGenerator()

userList = []

# This opens the adjective file
adjFile = open("adj.txt", "r")
# reads file into a list of string
adj = adjFile.readlines()
# This splits then removes the extra characters including spaces
adj = [re.sub('[^A-Za-z0-9]+', '', x.strip()) for x in adj]

# This opens the noun file
nounFile = open("noun.txt", "r")
# reads file into a list of string
noun = nounFile.readlines()
# This splits then removes the extra characters including spaces
noun = [re.sub('[^A-Za-z0-9]+', '', x.strip()) for x in noun]

# runs a for loop to generate a random username with adjNounNum format if the length is above 15 for the username will regenerate
for i in range(25):
    generatedUsername = f"{adj[r.randint(0,len(adj)-1)]}{noun[r.randint(0,len(noun)-1)]}{r.randint(0,2000)}"
    generatedPassword = pwo.shuffle_password(
        string.ascii_lowercase+"0123456789", 8)
    while(len(generatedUsername) > 15):
        generatedUsername = f"{adj[r.randint(0,len(adj)-1)]}{noun[r.randint(0,len(noun)-1)]}{r.randint(0,2000)}"
    userList.append({"email": generatedUsername+"@tcsTampa.com",
                     "password": generatedPassword})

for i in userList:
    response = requests.post(
        f"https://identitytoolkit.googleapis.com/v1/accounts:signUp?key={APIKEY}", data={"email": i["email"], "password": i["password"], "returnSecureToken": "false"})


loginInfo = open("loginInfo.txt", "a")

[loginInfo.write(f"{i['email']}: {i['password']}\n") for i in userList]
