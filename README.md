# Path-Finding-using-Qlearning
It was a maze creator and solver simulator designed in Matlab. You can create a maze and let the Q learning to solve it.
•	First of extract the file in matlab folder.
•	Open matlab by right clicking on matlab icon and selecting “run as administrator”.
•	Open “maze_solver_qlearning.m” and run it.
•	If it ask for an add folder than click on “add path”
•	The following will be opened

![image](https://user-images.githubusercontent.com/37823818/147207474-7c82d89c-b153-4e97-95ac-b7931c8df21f.png)


•	Slide the slider up and down the value of alpha will appear above slider. My suggestion is keep the slider value above 0.7 or on one because for low value the solution sometime stuck due to divergence.

![image](https://user-images.githubusercontent.com/37823818/147207530-d152c8f0-6b3b-4f41-9cfe-39a5a40e9e68.png) ![image](https://user-images.githubusercontent.com/37823818/147207553-e1471ec4-de2e-4788-babf-f04395741e92.png)

•	Click on load maze and select maze.mat from extracted folder it will load a maze.

![image](https://user-images.githubusercontent.com/37823818/147207606-a2a93e53-0b2c-4ef8-96d3-d39fbecb24b9.png)
![image](https://user-images.githubusercontent.com/37823818/147207620-ec49e3f1-44a5-445a-a985-7ad03695421a.png)
![image](https://user-images.githubusercontent.com/37823818/147207635-05db6756-2a8e-4d92-96f3-774097df7018.png)


•	Click on run and it will start solving until reset button is pressed.
•	Here is the solution which they give


![image](https://user-images.githubusercontent.com/37823818/147207658-b5140048-fe1b-4261-8f01-c508e20a8dbd.png)


•	For creating maze click on Reset to stop processing and click on create maze. Which will open the new window like the following.

![image](https://user-images.githubusercontent.com/37823818/147207674-686bfb66-035d-4a54-951b-1e800fdd6426.png)


Where you have to create your own maze by specifying paths from r1, c1 to r12, c12 like in the following image.


![image](https://user-images.githubusercontent.com/37823818/147207697-fa7b219f-22ac-4ea0-85b2-634bc80044e6.png)


Where tick shows the paths, click on Save Maze, save as maze123.mat, and close the window.
Then click on load maze in the first window and select maze123.mat


![image](https://user-images.githubusercontent.com/37823818/147207771-dba646aa-9740-4461-977e-b35b6654a7d9.png)


Click on run

![image](https://user-images.githubusercontent.com/37823818/147207798-33814cf3-ed13-42dc-b565-e9fca9baea5e.png)


In addition, random maze create maze for yours but I will not prefer because in most of cases it will never give you open path between start and end.
