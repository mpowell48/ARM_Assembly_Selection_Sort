Selection Sort in ARM Assembly
ITEC 352: Computer Organization
Professor: Andrew Ray
Radford University Fall 2016

Authors:

- Mitchell Powell
- Drew Becker

Overview:

This program is a selection sort coded entirely in the
ARM Assembly Language. The program takes a hard coded array
of integers as input, sorts them in ascending order, using
a selection sort algorithm, and stores them in temporary
memory. The program leaves the largest value in the return
register.

Execution:

This program is designed to run on any machine able to execute
ARM Assembly. Any Raspberry Pi (or Raspberry Pi emulator), running
RaspianOS will work. Open the command line, and navigate to the folder
containing this README and the file named selection_sort.s.
Type the following commands to execute:

1) make selection_sort

2) ./selection_sort; $echo