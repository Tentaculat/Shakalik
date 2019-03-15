{procedure hodchel;
 begin
 x:=1; x1:=x;
 y:=1; y1:=y;
 rischel(x,y,1,1);
 repeat
  ch:=readkey;
  case ch of
   left:if x>1 then x:=x-1;
  right:if x<11 then x:=x+1;
     up:if y>1 then y:=y-1;
   down:if y<11 then y:=y+1;
  end;
  if (ch=up) or (ch=down) or (ch=left) or (ch=right) then
  begin
   ris1p(x1,y1);
   rischel(x,y,1,1);
   x1:=x;
   y1:=y;
  end;
 until ch=#27;
 end;}

{procedure wrtmatr;
 var
  i,j:1..11;
 begin
  for i:=1 to 11 do
   for j:=1 to 11 do
    write(matrprin[i,j],'  ');
 end;}

{procedure gr;
 var
  gd,gm:integer;
 begin
  gd:=detect;
  initgraph(gd,gm,'F:\tp7\bgi');
 end;}

{procedure rispole;
 var
  i:0..11;
 begin
  setcolor(lightblue);
  rectangle(20,20,460,460);
  setfillstyle(1,blue);
  floodfill(100,100,lightblue);
  for i:=1 to 10 do
   line(i*shk+20,20,i*shk+20,460);
  for i:=1 to 10 do
   line(20,i*shk+20,460,i*shk+20);
   setcolor(yellow);
   setlinestyle(0,1,3);
   rectangle(485,10,630,375);
    for i:=1 to 3 do
     line(485,i*91+10,630,i*91+10);
 end;   }

{procedure spros;
 var
  ch:char;
  i,i1:0..5;
  forsh:1..4;
 begin
 repeat
  for forsh:=1 to 4 do
   igr[forsh]:=0;
  i:=1;  i1:=i;
   repeat
    for forsh:=1 to 4 do
     begin
     case forsh of
      1:setcolor(1);
      2:setcolor(2);
      3:setcolor(4);
      4:setcolor(14);
     end;
      case igr[forsh] of
       0:outtextxy(forsh*100+70,185,'off');
       1:outtextxy(forsh*100+60,185,'human');
       2:outtextxy(forsh*100+50,185,'computer');
      end;
     end;
    setlinestyle(0,1,3);
    setcolor(14);
    rectangle(i*100+40,150,i*100+120,230);
    ch:=readkey;
     case ch of
      right:i:=i+1;
       left:i:=i-1;
         up:i:=i+1;
       down:i:=i-1;
      space:begin setfillstyle(1,0); bar(i*100+40,155,i*100+120,230);
                  igr[i]:=igr[i]+1; end;
     end;
      if igr[i]>2 then igr[i]:=0;
      if igr[i]<0 then igr[i]:=2;
      if i<1 then i:=4;
      if i>4 then i:=1;
      if i<>i1 then
       begin
        setcolor(0);
        rectangle(i1*100+40,150,i1*100+120,230);
        setcolor(14);
        rectangle(i*100+40,150,i*100+120,230);
       end;
       i1:=i;
   until ch=#13;
    i:=0;
    for forsh:=1 to 4 do
     if igr[forsh]<>0 then i:=i+1;
     if i<2 then
      begin
       cleardevice;
       outtextxy(100,100,'You must have 2 or more players.');
      end;
   until i>=2;
   cleardevice;
   setlinestyle(0,1,1);
 end;}

{procedure wrt(s:string;c:integer;stroka:byte;och:byte);
begin
 if och=1 then
  begin
   setfillstyle(1,0);
   bar(480,376,getmaxx,getmaxy);
  end;
 setcolor(c);
  case stroka of
   1:moveto(480,380);
   2:moveto(480,400);
   3:moveto(480,420);
   4:moveto(480,440);
   5:moveto(480,460);
  end;
 outtext(s);
end; }

{procedure ris1p(x,y:klet);
var i:integer;
begin
 setfillstyle(1,0);
 bar((x-1)*40+21,(y-1)*40+21,(x-1)*40+59,(y-1)*40+59);
 putimage((x-1)*40+21,(y-1)*40+21,p[matrprin[x,y]]^,1);
 setlinestyle(0,0,1);
 setcolor(lightblue);
 rectangle((x-1)*40+20,(y-1)*40+20,(x-1)*40+60,(y-1)*40+60);
end;

procedure risall;
 var
  i,j:1..11;
 begin
  for i:=1 to 11 do
   for j:=1 to 11 do
     ris1p(i,j);
 end;}
