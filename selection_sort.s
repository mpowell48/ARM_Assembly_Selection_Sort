@@ Mitchell Powell & Drew Becker
@@ ITEC 352 Fall 2016
@@ Project 1

@ License: CC Attribution Non-Commercial 4.0 International
@    See short hand summary here:
@        http://creativecommons.org/licenses/by-nc/4.0/
@    See legal specifications here:
@        http://creativecommons.org/licenses/by-nc/4.0/legalcode
@
@    Reuse of code allowed under the conditions in the link above.

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@ selection_sort.s:                                 @@
@@ selection_sort.s is an ARM Assembly program.      @@
@@ This program takes an array that is initialized   @@
@@ in memory, and sorts the values from least to     @@
@@ greatest, using a selection sort algorithm.       @@
@@ The largest value is then returned after the      @@
@@ the program has finished executing.               @@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@



@***************************************************************@
@*  Register Aliases:                                	       *@
@*  The purpose of using aliases to refer to certain registers *@
@*  is to make the program easier to understand. If a register *@
@*  is used for only one or two purposes, throughout the       *@
@*  the program, it is helpful to give it an alias that        *@
@*  relates to the purpose of the register. Code comments will *@
@*  refer to a given register's alias in order to be clear     *@
@*  about what a given line of code is doing.                  *@
@*                                                             *@
@*  r0 - return register: Value contained within is returned   *@
@*  upon end of program.                                       *@
@*                                                             *@
@*  r1 - comp_val: This register holds the value that is       *@
@*  being compared to the current minimum to determine which   *@
@*  is smaller.                                                *@
@*                                                             *@
@*  r3 - swap_val: This register holds the value that will be  *@
@*  swapped in the array with the minimum remaining unsorted   *@
@*  value.                                                     *@
@*                                                             *@
@*  r6 - i: This register holds the value of the counter for   *@
@*  the outer loop.                                            *@
@*                                                             *@
@*  r7 - j: This register holds the value of the counter for   *@
@*  the inner loop.                                            *@
@*                                                             *@
@*  r8 - min: This register holds the value of the minimum     *@
@*  remaining unsorted value.                                  *@
@*                                                             *@
@*  r9 - imin: This register holds the value of the index      *@
@*  of the minimum remaining unsorted value.                   *@
@*                                                             *@
@*  r12 - (no alias): Used to transfer the line register (lr)  *@
@*  into memory.                                               *@
@***************************************************************@

.data

array: .word 1   @ADJUST                @  Array that holds the values
       .word 32  @ARRAY                 @  to be sorted
       .word 10  @VALUES
       .word 8   @HERE
       .word 3   @!!!!

main_lr: .word 0                        @  Stores the line register of
                                        @  main in memory @
outer_loop_lr: .word 0                  @  Stores the line register of
                                        @  outer_loop in memory
inner_loop_lr: .word 0                  @  Stores the line register of
                                        @  inner_loop in memory

.text
.global main

@+---------------------------------------------------+@
@|  The purpose of main is to call the outer_loop    |@
@|  function and to load the largest value of the    |@
@|  sorted array into the return register.           |@
@+---------------------------------------------------+@

.func main
main:
                                        @  FUNCTION CALL: outer_loop
    ldr r12, addr_main_lr               @  Load in the location to store the lr
    str lr, [r12]                       @  Store the lr in memory
    bl outer_loop                       @  Branch to outer_loop
    ldr r12, addr_main_lr               @  Use the address of the lr
    ldr lr, [r12]                       @  to load the lr from memory, and
                                        @  restore it

    ldr r0, addr_array                  @  Use the address of the array
    ldr r0, [r0, #16]                   @  to load the last value in the array
                                        @  (the largest value) into the return
                                        @  register
    bx lr
.endfunc

@+----------------------------------------------------+@
@|  The purpose of outer_loop function is to loop     |@
@|  through the array, and call inner_loop. However,  |@
@|  the counter "i" is used in inner_loop to specify  |@
@|  the index of "comp_val" and initialize "j".       |@
@+----------------------------------------------------+@

.func outer_loop
outer_loop:

    mov r6, #0                          @  Initialize "i" to be 0

    out_loop:

        cmp r6, #15	                    @  Check "i" > 15 (end condition)
        bgt end_out_loop                @  and exit loop if true

                                        @  FUNCTION CALL: inner_loop
        ldr r12, addr_outer_loop_lr     @  Load in the location to store the lr
        str lr, [r12]                   @  Store the lr in memory
        bl inner_loop                   @  Branch to inner_loop
        ldr r12, addr_outer_loop_lr     @  Use the address of the lr
        ldr lr, [r12]                   @  to load the lr from memory, and
                                        @  restore it

        add r6, r6, #4                  @  Increment "i"

        b out_loop                      @  Branch to the top of the loop

    end_out_loop:

    @mov r0, r6                         @@  debug line: What was the final  @@
                                        @@ 	            value of "i"?       @@

    bx lr
.endfunc

@+----------------------------------------------------+@
@|  The purpose of the inner_loop function is to      |@
@|  compare find the minimum remaining unsorted value |@
@|  in the array, and then calling the swap function  |@
@|  to swap the two.                                  |@
@+----------------------------------------------------+@

.func inner_loop
inner_loop:

    ldr r8, addr_array                  @  Load in the array, and assign "min"
    ldr r8, [r8, r6]                    @  to be the value at the index "i"
    mov r9, r6                          @  Move the index into "imin"

    add r7, r6, #4                      @  Initialize "j" to be "i" plus 4

    in_loop:

	cmp r7, #19                         @  Check if "j" > 19 (end condition)
	bgt end_in_loop                     @  and exit loop if true

	ldr r1, addr_array                  @  Load in the array, and assign
	ldr r1, [r1, r7]                    @  "comp_val" to be the "j"th value in
                                        @  the array

	cmp r1, r8                          @  Check if "comp_val" < "min" and
	blt reassign_min		            @  branch to reassign_min if true

    back_in_loop:

	add r7, r7, #4                      @  Increment "j"

	b in_loop                           @  Branch to the top of the loop

    end_in_loop:

                                        @  FUNCTION CALL: swap
    ldr r12, addr_inner_loop_lr         @  Load in the location to store the lr
    str lr, [r12]                       @  Store the lr in memory
    bl swap                             @  Branch to swap
    ldr r12, addr_inner_loop_lr         @  Use the address of the lr
    ldr lr, [r12]                       @  to load the lr from memory, and
                                        @  restore it

    @mov r0, r7                         @@  debug line: What was the final   @@
                                        @@              value of j?          @@
    @mov r0, r8                         @@  debug line: What was "min" for   @@
                                        @@              this pass? (adjust   @@
                                        @@              outer_loop to tune)  @@
    @mov r0, r9                         @@  debug line: What was the "imin"? @@

    bx lr

    reassign_min:

    mov r8, r1                          @  Reassign "min" to be "comp_val"
    mov r9, r7                          @  Reassign "imin" to be "j"
    b back_in_loop                      @  Branch back to loop

.endfunc

@+--------------------------------------------------+@
@|  The purpose of the swap function is to take the |@
@|  minimum remaining unsorted value, and assign it |@
@|  to the "i"th location of the array in memory,   |@
@|  and take the "i"th value that is currently in   |@
@|  the array, and assign it to index of the 	    |@
@|  minimum remaining unsorted value.               |@
@+--------------------------------------------------+@

.func swap
swap:

    ldr r2, addr_array                  @  Load in the array, and assign
    ldr r3, [r2, r6]                    @  "swap_val" to be the "i"th value in
                                        @  the array

    str r3, [r2, r9]                    @  Store "swap_val" in the "imin"th
                                        @  value of the array
    str r8, [r2, r6]                    @  Store "min" in the "i"th value of
                                        @  the array
    bx lr
.endfunc

addr_array: .word array                 @  Memory address of the array

addr_main_lr: .word main_lr             @  Memory address of the main lr
addr_outer_loop_lr: .word outer_loop_lr @  Memory address of the outer loop lr
addr_inner_loop_lr: .word inner_loop_lr @  Memory address of the inner loop lr