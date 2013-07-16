create or replace function fsum (n number,m  number)
return number
as
 LANGUAGE JAVA
   NAME 'Calc.addNums(int,int) return int';
