---
title: Hello, world!
headerImg: sea.jpg
date: 2017-03-28
---

## Who am I?

![Nadia Polikarpova](https://cseweb.ucsd.edu/~npolikarpova/images/nadia_polikarpova.jpg){#fig:nadia .align-center width=25%}

- Assistant professor at CSE since 2017
- PhD at ETH Zurich
- Postdoc at MIT

### My Research

- Program Verification: how to *prove* the program is doing the right thing?
- Program Synthesis: how to *generate* a program that does the right thing?

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>


## The Crew

Teaching assistants:

* [Zheng Guo](https://aaronguo1996.github.io/)
* [Tristan Knoth](https://tjknoth.github.io/)
* [Alex Sanchez-Stern](http://alex.uwplse.org/)

Tutors:

* [David Hacker](https://dmhacker.github.io/)
* [Darya Verzhbinsky](https://www.linkedin.com/in/darya-ver)
* Daniel Wang


<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## What is CSE 130 **not** about?

Learning... 

- JavaScript in September
- Haskell in October
- C++ in November
- etc. 

### New languages come (and go ...)

There was no

- Python      30 years ago
- Java        25 years ago
- C#          20 years ago
- Rust        10 years ago
- WebAssembly 2 years ago


<br>
<br>
<br>
<br>
<br>
<br>

## What is CSE 130 about?

- Concepts in programming languages
- Language design and implementation


<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>



## A Programming Language

### Two Variables

- `x`, `y`

### Three Operations

- `x++`
- `x--`
- `x = 0 ? L1 : L2`


<br>
<br>
<br>
<br>
<br>
<br>


## Example Program

(What _does_ it do?)

```
L1: x++
    y--
    y = 0 ? L2 : L1
L2: ...
```


<br>
<br>
<br>
<br>
<br>
<br>

## The above language is "equivalent to" every PL!

But good luck writing 
- QuickSort
- Fortnite
- Spotify

<br>
<br>
<br>
<br>
<br>
<br>

## So Why Study Programming Languages?

![Federico Fellini](/static/img/fellini.png){#fig:fellini .align-center width=25%}

> A different language
> is
> a different vision
> of life.


<br>
<br>
<br>
<br>
<br>
<br>


## So Why Study Programming Languages?

> The principle of **linguistic relativity**
> holds that the structure of a language
> affects its speakers world view or cognition.

Or more simply:

> Programming Language
> shapes
> Programming Thought.

Language affects how ideas and computation are expressed



<br>
<br>
<br>
<br>
<br>
<br>



## Course Goals

![130 Brain](https://ucsd-cse130.github.io/wi20/static/img/galaxy-brain-130.jpg){#fig:morpheus .align-center width=40%}

> Free Your Mind.



<br>
<br>
<br>
<br>
<br>
<br>

## Goal: Learn the Anatomy of PL

![Anatomy](/static/img/anatomy.png){#fig:anatomy .align-center width=20%}


- What makes a programming language?
- Which features are **fundamental** and which are **syntactic sugar**? 





<br>
<br>
<br>
<br>
<br>
<br>


## Goal: Learn New Languages / Constructs

![Musical Score](/static/img/music-score.png){#fig:music .align-center width=30%}

New ways to **describe** and **organize** computation,
to create programs that are:

- **Correct**
- **Readable**
- **Extendable**
- **Reusable**



<br>
<br>
<br>
<br>
<br>
<br>






## Goal: How to Design new Languages

New hot lanuages being designed in industry as we speak:

- Flow, React @ Facebook     
- Rust @ Mozilla, 
- TypeScript @ Microsoft
- Swift @ Apple
- WebAsssembly @ Google + Mozilla + Microsoft

Buried in every large system is a (domain-specific) language

- DB: SQL
- Word, Excel: Formulas, Macros, VBScript
- Emacs: LISP
- Latex, shell scripts, makefiles, ...

If you work on a large system, you **will** design a new PL!



<br>
<br>
<br>
<br>
<br>
<br>

## Goal: Enable You To Choose Right PL

But isn't that decided by

- Libraries
- Standards
- Hiring
- Your Boss?!

Yes.

**My goal:** Educate tomorrow's leaders so you'll make **informed** choices.



<br>
<br>
<br>
<br>
<br>
<br>

## Course Syllabus

- Lambda calculus (2 weeks)
    - The simplest language on Earth
- Haskell (5 weeks)
    - A cool functional language
- Build your own language (3 weeks)
    - How do we implement a new language (in Haksell)?
    - How do we formalize a language and prove things about it?
    

<br>
<br>
<br>
<br>
<br>
<br>


## **QuickSort** in C

```c
void sort(int arr[], int beg, int end){
  if (end > beg + 1){
    int piv = arr[beg];
    int l = beg + 1;
    int r = end;
    while (l != r-1)
       if(arr[l] <= piv) l++;
       else swap(&arr[l], &arr[r--]);
    if(arr[l]<=piv && arr[r]<=piv)
       l=r+1;
    else if(arr[l]<=piv && arr[r]>piv)
       {l++; r--;}
    else if (arr[l]>piv && arr[r]<=piv)
       swap(&arr[l++], &arr[r--]);
    else r=l-1;
    swap(&arr[r--], &arr[beg]);
    sort(arr, beg, r);
    sort(arr, l, end);
  }
}
```



<br>
<br>
<br>
<br>
<br>
<br>

## **QuickSort** in Haskell

```Haskell
sort []     = []
sort (x:xs) = sort ls ++ [x] ++ sort rs
  where
    ls      = [ l | l <- xs, l <= x ]
    rs      = [ r | r <- xs, x <  r ]
```

(not a wholly [fair comparison...](http://stackoverflow.com/questions/7717691/why-is-the-minimalist-example-haskell-quicksort-not-a-true-quicksort))



<br>
<br>
<br>
<br>
<br>
<br>



<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>


## Course Logistics

- [webpage](https://nadia-polikarpova.github.io/cse130-web)
    - calendar, lecture notes/recordings, programming assignments, ...
- [canvas](https://canvas.ucsd.edu/courses/12776)
    - to-go place if you have a question or need help  



<br>
<br>
<br>
<br>
<br>
<br>

## Grading

- 40% Homework assignments
- 25% Midterm
- 30% Final
- 05% Canvas discussion
    - To **top 20** best participants
    
<br>
<br>
<br>
<br>
<br>
<br>    

## Assignments

- 6 programming assignments
- Released [online](https://nadia-polikarpova.github.io/cse130-web/assignments.html), at least a week before due date
- Due on **Wednesday at 11:59pm**
    - no assignment this and next Wednesday
- Eight late days, no more than 4 late days per assignment
    - used atomically (5 mins late = 1 late day)
- Submission instructions in the assignment
- Solve in **groups of two**
    - we will randomly assign you a partner on Canvas
    - your partner will be in the same or nearby time zone so you can do remote pair programming
    - if this absolutely doesn't work for you, let me know this week
    - submit assignments **individually**

<br>
<br>
<br>
<br>
<br>
<br>     
    
## Exams    

- Midterm on *May 4*
    - most likely format: same as homework but individual and with 24h timespan
- Final: *June 12*
    - same format as midterm
- You can use any resources you want, but not ask anyone for help
- The final is cumulative
- Midterm grade is calculated as `midterm > 0 ?  max(final, midterm) : 0`
    - you get a second chance if you don’t do well on the midterm
    - you must turn in both the midterm and the final




<br>
<br>
<br>
<br>
<br>
<br>

## Lecture Format

Live lecture over Zoom during scheduled lecture time

- Two ways to ask a question:
    1. "Raise your hand" in zoom and I will call on you
    2. Type into zoom chat
- Same if I ask you a question
- Quizzes via Zoom polls
    - Polls make class interactive
    - Help *you* and *me* understand what's tricky
    - We will randomly assign you to *breakout rooms* to discuss quizzes
    
<br>
<br>
<br>
<br>
<br>
<br>

## Quiz Protocol

1. **Solo Vote**
    - Think for yourself, select answer

2. **Discuss**
    - Go into your *breakout room*
    - Analyze problem with your groups
    - Reach consensus
    - I will "call you back" from the room when time's up

3. **Group Vote**
    - Everyone in group votes
    - Hopefully the same way but not enforced

4. **Class Discuss**
    - What was easy or tricky?    

<br>
<br>
<br>
<br>
<br>
<br>


## TEST QUIZ

How are you supposed to turn in your 130 homework assignment?

- **A**  only one of the partners must turn in the solution

- **B**  both partners must turn in (potentially the same) solution

- **C**  working in pairs is not allowed

- **D** there are no homework assignments in 130



<br>
<br>
<br>
<br>
<br>
<br>


## Your Resources

- Discussion section: Fri 5pm, same Zoom link
- Office hours
    - every day, check calendar
    - I expect you to come to my office hours at least once this quarter
- Canvas
    - we answer during work hours
- **No text**        
    - online lecture notes and links



<br>
<br>
<br>
<br>
<br>
<br>






## Academic Integrity

Programming assignments: do not copy from classmates or from previous years

Exams done **alone**

  - Zero Tolerance
  - Offenders punished ruthlessly
  - Please see academic integrity statement


<br>
<br>
<br>
<br>
<br>
<br>


## Students with Disabilites

Students requesting accommodations for this course due to a disability or current functional limitation must provide 
a current **Authorization for Accommodation (AFA)** letter issued by the Office for Students with Disabilities (OSD) 
which is located in University Center 202 behind Center Hall.
  
Students are required to present their AFA letters to Faculty (please make arrangements to contact me privately) 
and to the CSE OSD Liaison in advance so that accommodations may be arranged.

<br>
<br>
<br>
<br>
<br>
<br>


## Diversity and Inclusion

Our goal is to create a diverse and inclusive learning environment where all students feel comfortable and can thrive. 
If there is a way we can make you feel more included please let one of the course staff know, 
either in person, via email/discussion board, or even in a note under the door.
Our learning about diverse perspectives and identities is an ongoing process, and we welcome your perspectives and input.  

We also expect that you, as a student in this course, will honor and respect your classmates, 
abiding by the UCSD [Principles of Community](https://ucsd.edu/about/principles.html).
Please understand that others’ backgrounds, perspectives and experiences may be different than your own,
and help us to build an environment where everyone is respected and feels comfortable.

If you experience any sort of **harassment or discrimination**, please contact the [Office of Prevention of Harassment and Discrimination](https://ophd.ucsd.edu/).
Students may receive confidential assistance at the [Sexual Assault Resource Center](http://care.ucsd.edu) at (858) 534-5793
or [Counseling and Psychological Services](http://caps.ucsd.edu.) (CAPS) at (858) 534-3755.

<br>
<br>
<br>
<br>
<br>
<br>

## Basic Needs

- Are you eating properly?
- Do you have adequate access to nutritious food?
- Do you have stable housing?
- Are you homeless or couch surfing?

If you or someone you know has food and/or housing insecurity, be aware of [Basic Needs](http://basicneeds.ucsd.edu)

- The [Triton Food Pantry](https://www.facebook.com/tritonfoodpantry/) (in the old Student Center), is free and anonymous, and includes produce. 
- Financial aid resources, the possibility of emergency grant funding, and off-campus housing referral resources are available.
- CAPS and college deans can connect students to the above resources, as well as other community resources and support.  


<br>
<br>
<br>
<br>
<br>
<br>




