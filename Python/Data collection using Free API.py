# https://colab.research.google.com/drive/1FCt5zeis20BaYtAnIXgTO0pclyDqFr97?usp=sharing
# Free API : https://jsonplaceholder.typicode.com/

from requests import get 

# check endpoint
url = "https://jsonplaceholder.typicode.com/comments/1"
response = get(url)
response.status_code


--------------------------------------------

from requests import get 

base_url = "https://jsonplaceholder.typicode.com/comments/"

postId = []
id = []
name = []
email = []
body = []

for i in range(20):
    url = base_url + str(i+1)
    response = get(url)
    postId.append(response.json()['postId'])
    id.append(response.json()['id'])
    name.append(response.json()['name'])
    email.append(response.json()['email'])
    body.append(response.json()['body'])

import pandas as pd 
df = pd.DataFrame(
    { "postId" : postId, "id" : id ,"name": name, "email": email, "body": body}
)
df.head()
