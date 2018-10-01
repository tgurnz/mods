<h1><img src="resources/icon.png" />PyGlossary</h1>

Just a windows batch-file that makes working with this python-program easier.

First, if you do not have Python, get WinPython and place it in <code>C:\Python</code>, 
add <code>C:\Python\python-3.6.3</code> (might vary due to newer versions) to the system PATH, and reset the PC. 

Next download https://github.com/ilius/pyglossary/archive/master.zip and extract it anywhere 
(you may rename <code>pyglossary-master</code>), copy <code>pyglossary.cmd</code> to the same folder and run it as is or with any additional command-line argument you want. 
By default the batch-file already includes <code>--no-progress-bar --no-color --verbosity 4</code> (which you may change).

Note:
Converting BGL for example (babylon dictionaries) to plain-text will (sometimes) create an additional folder for the resources, check to see if there are any useful resources there you may use later (images/pdf/etc..).
