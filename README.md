SoundNote

Project Overview
--------------------
	SoundNote is unlike any other note taking app you will find in the App store. It is convenient, extremely easy to use and most importantly, it takes notes for you using voice recognition. All you have to do is press a button and start speaking. SoundNote will automatically transcribe your voice into text. You will also be able to save it on your phone and edit your note later. It saves you a significant amount of time from typing your notes. SoundNote is your perfect goto note taking app. 

	SoundNote currently supports Chinese and English as voice input and is mainly designed for users who are fluent in both of these two languages. It is best for making small notes like your daily to-do list or your grocery shopping list. 


Motivation
--------------------
	This project serves as our final project for the iOS Programming course taught by professor Nathan Hull at New York University. However our goal was to make something that is beyond just an academic project. We wanted build a real app that will actually benefit its users. We started thinking about some small problems that we have in our daily lives and we realized that it is kind of annoying when people sometimes all of a sudden have an idea and they want to write it down, they always have to physically write on a piece of paper or type on their phone. However ideas tend to develop faster in our mind than we write and as a result people often lose track of their ideas eventually. So we decided to find a solution to this using today's technology and we figured that if we could build something that can record what we say in the form of text, that would save people a lot time because generally people speak much faster that they write. So we decided to make SoundNote whose main feature is to use speech recognition to trascribe voice input to text and have it saved and editable to its users. 

	Our targeted group of users is those who are fluent in both Chinese and English, like us. It is actually not a small group of people and we often times use a mix of these languages in casual writings and conversations for convenience. So we thought that being able to recognize both languages at the same time as voice input should be a feature of our app. 


Getting Started
--------------------
	These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. 
	Requirements:
	- SoundNote.zip
	- Xcode 8.3.2
	- An iPhone/iPad running iOS 10+
	- An Apple Developer Account

	How to run SoundNote:
	- On a macOS:
		1. Unzip SoundNote.zip 
		2. Open the file named "SoundNote.xcodeproj"
		3. The project will open in Xcode and it will be automatically installed in an iPhone simulator when you run it. 

	- On an iOS device , i.e an iPhone or iPad:
		1. Unzip SoundNote.zip
		2. Open the file named "SoundNote.xcodeproj"
		3. In the upper left corner, select SoundNote -> Generic devices
		4. Make sure in the signing field of the project, Log in as a developer 
		5. In the upper bar, Product -> Archive
		6. Windows -> Organizer, select Archive and export
		7. After saving the .ipa file, in windows -> devices, add the ipa file to your iOS device (it should have already connected to your computer)
		6. Run the app on your iOS device

	***IMPORTANT NOTES
	- It is highly recommended to run SoundNote on an actual iPhone because the simulator in macOS does not have microphone access so it will not recognize any voice input. 
	- When creating a new note, it will not be saved it if is not edited. 
	

Third Party Framework
--------------------
	We chose iflyMSC as our main speech recognition API for SoundNote for the following reasons. We initially used SpeechKit by Apple but the accuracy of speech to text trasncription was not satisfactory, especially in noisy background. We then tried the speech to text SDK by OpenEars but it does not recognize English and Chinese voice input at the same time. In the end fortunately we found iflyMSC, an API developed that supports both Chinese and English, which is exactly what we were looking for. Here is the reference to iflyMSC: https://github.com/1617176084/iflyMSC


Future Development
--------------------
	As of now - May 12, 2017, the main features of SoundNote (speech recognition, adding notes, editing notes, etc.) are fully functional. However as you can see we have a lot of codes that are dedicated to some more features but are not visible in the app when you run it but we wanted to add them to this project in the future. Some of these features include allowing users to customize background color and theme, letting users create their own profiles so users of SoundNote could shares notes and send messages, etc. That is why our home view controller is actually a tab bar view controller and we intend to add more tabs that will display these features in the future. 


Authors
--------------------
	Tom Li - App overall design, speech recognition API implementation, drafting documentations
	Rina Yu - Infrastructure implementation, UI design, code efficiency improvement


Questions & Contribution
--------------------
	If you have questions regarding any aspect of this project or are interested in contributing in any way, please feel free to email us. We'd love to hear from you! Here are our email addresses:
	- Tom Li: gl1147@nyu.edu
	- Rina Yu: jy1604@nyu.edu


Acknowledgments
--------------------
	We would really like to thank Professor Nathan Hull for giving us this opportunity and guiding us through this project as well as his teaching assistants Dawood Khan & Naman Kumar for helping us with the code. 
