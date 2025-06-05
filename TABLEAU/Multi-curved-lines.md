I got something similar working by using a dataset which has two fields:


Field 1: numbers between 0 and 1

just a load of numbers in ascending order between 0 and 1 e.g. with generate rows tool


Field 2: Path ID

numbers 1 until however many rows you have in field 1


Then I used the line mark type with the two calcs:



up curve line:

MAKEPOINT(

([numbers between 0 and 1]*[location 2 lat] + (1-[numbers between 0 and 1])*[location 1 lat]) 

+ ABS(SIN([numbers between 0 and 1]*PI())*([location 2 lat]-[location 1 lat]))/2

,

[numbers between 0 and 1]*[location 2 long] + (1-[numbers between 0 and 1])*[location 1 long]

)


down curve line:

MAKEPOINT(

([numbers between 0 and 1]*[location 2 lat] + (1-[numbers between 0 and 1])*[location 1 lat]) 

- ABS(SIN([numbers between 0 and 1]*PI())*([location 2 lat]-[location 1 lat]))/2

,

[numbers between 0 and 1]*[location 2 long] + (1-[numbers between 0 and 1])*[location 1 long]

)


And then built the chart using map layers with the two calcs above as in the screenshot. You can either store your lats and longs in a parameter and have this additional dataset completely separate or you can relate the additional data source


replace location 1/2 lat/long in the curve calcs with your dynamic choices of lats and longs

You could probably get a cleaner curve with some fiddling with the parts of the makepoint calcs that make the latitude curve, and a smoother curve with just having more points between 0 and 1


Then to implement, I would most likely try something around an IF statement that checks if the line you are drawing is import or export, and then assign the up or down curve accordingly
