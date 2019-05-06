# Tree-Hollow

<img width="200" src="https://user-images.githubusercontent.com/48665960/57200297-3ba53a00-6f58-11e9-9017-649ec13928de.png">

1. App Name: Tree Hollow

2. App Tagline: A digital, safe tree hollow that collects your secrets

3. Screenshots:
<img width="400" src="https://user-images.githubusercontent.com/48665960/57200339-bb330900-6f58-11e9-945b-c3e06ed2342f.png">

<img width="980" alt="Screen Shot 2019-05-03 at 2 27 44 PM" src="https://user-images.githubusercontent.com/48665960/57188571-ed982400-6ece-11e9-93f7-24ccf2eef0e3.png">

4. Description:
<br>Do you sometimes have something in mind and desperately want to share with someone but fear judgments on your usual social networks? That is where TreeHollow comes in! This app is a safe, digital “tree hollow” where you can post your long-buried secrets with nicknames and read others’ secrets.

5. Design Process:
<br>Prototype: https://www.figma.com/file/H1R9Eph08egyGk0sLhG0M80Y/Tree-Hollow?node-id=0%3A1

6. A list of how your app addresses each of the requirements (iOS / Backend):
<br>iOS:
<br>1. AutoLayout using NSLayoutConstraint
<br>2. The main feed using UITableView
<br>3. Used UINavigationController to navigate between screens
<br>4. Used Google Sign-In API and other backend APIs to communicate with the backend
<br><br>Backend:
<br>1. Designing an API: https://paper.dropbox.com/doc/Tree-Hallow-API-Spec-SPRING-2019-Hack-Challenge--AcmdZZUnF6fReP6JQue~rL8FAQ-CYtc1MkABkyhYpZywj9df
<br>2. Deployment to Google Cloud: http://34.74.247.147/

7. Please note:
<br>To run the app smoothly, please kindly add a new Keys.plist file, which should contain your own Google Sign-in Client ID, under TreeHollow/TreeHollow/ 
<br>For any questions related to it, please contact Kevin Chan. He helped me with that. Thank you!  
<br>Although it is a simple app, I tried to make it as perfect as possible. For example, with the same Google account, the user will go through the on-boading process only once no matter how many times (s)he signs in. The users cannot type nothing when they choose nickname or create new posts to enter next step. Besides, the posts are in reverse chronological order.
