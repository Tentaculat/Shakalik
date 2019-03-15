uses graph,crt;
{label a;     }
var
main_matr:array[1..11,1..11] of integer;
i1,i,x,y,x1,y1,gd,gm,size1,size2,per,vtor:integer;
p,p1,p2:pointer;
{------------------------------------------------------------------}
procedure ris;
begin
setcolor(red);
setfillstyle(1,2);
bar(20,20,460,460);
x:=20;
y:=20;
x1:=460;
y1:=20;
for i:=1 to 11 do
begin
line(x,y,x1,y1);
y:=y+40;
y1:=y1+40;
end;
x:=20;
y:=20;
x1:=20;
y1:=460;
for i:=1 to 11  do
begin
line(x,y,x1,y1);
x:=x+40;
x1:=x1+40;
end;
{setlinestyle(0,0,2); }
line(500,0,500,480);
line(501,0,501,480);
line(502,0,502,480);
line(639,0,639,480);
line(638,0,638,480);
line(637,0,637,480);
line(500,0,639,0);
line(500,1,639,1);
line(500,2,639,2);
line(500,479,639,479);
line(500,478,639,478);
line(500,477,639,477);
end;
{------------------------------------------------------------------}
procedure ris_i_zapom_igr;
begin
setfillstyle(1,magenta);
bar(1,1,19,19);
size1:=imagesize(1,1,20,20);
getmem(p1,size1);
getimage(1,1,20,20,p1^);
putimage(1,1,p1^,1);
{putimage(600,10,p1^,1);}

setfillstyle(1,cyan);
bar(600,300,620,320);
size2:=imagesize(599,299,621,321);
getmem(p2,size2);
getimage(599,299,621,321,p2^);
putimage(599,299,p2^,1);
{putimage(600,460,p2^,1); }
end;
{------------------------------------------------------------------}
procedure pris;
begin
{for i:=1 to 11  do
 for i1:=1 to 11 do
main_matr[i,i1]:=0;}
for i:=1 to 42  do
begin
per:=random(12);
vtor:=random(12);
if per=0 then i:=i-1 else
if vtor=0 then i:=i-1 else
if main_matr[per,vtor]=1
then   i:=i-1  else
main_matr[per,vtor]:=1;
end;
end;








{------------------------------------------------------------------}
begin
randomize;
initgraph(gd,gm,'F:\tp7\bgi');
gd:=detect;
ris;
ris_I_ZAPOM_IGR;
pris;
readln;
closegraph;
for i:=1 to 11  do
for i1:=1 to 11 do
write(main_matr[i,i1]);









end.