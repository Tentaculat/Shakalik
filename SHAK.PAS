unit shak;

interface
const
 kolklet=11;
 shk=40;
 left=#75;      left2=#52;
 right=#77;     right2=#54;
 up=#72;        up2=#56;
 down=#80;      down2=#50;
 leftup=#71;    leftup2=#55;
 rightup=#73;   rightup2=#57;
 rightdown=#81; rightdown2=#51;
 leftdown=#79;  leftdown2=#49;
 space=#32;
 tab=#9;
 esc=#27;
 kolkart=36;
 colorplay:array[1..4] of byte=(1,2,4,14);
 shipstr:array[1..4] of string=('bluship','grnship','redship','yelship');
 chelstr:array[1..4] of string=('blue','green','red','yel');
type
 klet=1..kolklet;
 kart=1..kolkart;
var
 igr:array[1..4] of -1..3;
 p:array[1..kolkart] of pointer;
 matrprin:array[-1..13,-1..13] of integer;
 playnamestr:array[1..4] of string;
 shipkord:array[1..4] of integer;
 shipmatr:array[0..47] of 0..4;
 chelkord:array[0..3,1..4,1..2] of integer;
 pship:array[1..4] of pointer;
 pchel:array[1..3,1..4] of pointer;
 pmoney:pointer;
 phod:pointer;
 pchelm:pointer;
 pchelmsize:word;
 sizes:array[1..kolkart] of word;
 shipsizes:array[1..4] of word;
 chelsizes:array[1..3,1..4] of word;
 monsize:word;
 phodsize:word;
 pstrl:pointer;
 pstrlsize:word;

procedure zapomni(var p:pointer;size:word;path:string);
procedure prpoint;
procedure gr;
procedure rispole;
procedure enterkey(x,y,offs:integer;var s:string);
procedure spros;
procedure wrt(s:string;c:integer;stroka:byte;och:byte);
procedure ris1p(x,y:klet);
procedure risall;
procedure shipxy(m:byte;var x,y:byte);
function shipx(m:byte):byte;
function shipy(m:byte):byte;
procedure setshipkor(x,y:byte;var xx,yy:integer);
procedure ochship(m:byte);
procedure risship(m,col:byte);
function getnap(ch:char;m:integer):integer;
function shkr(ch:char;m:integer):byte;
procedure placeship;
procedure freem;

implementation

uses graph,crt;

 procedure zapomni(var p:pointer;size:word;path:string);
  var
   fl:file;
  begin
   Assign(fl,path);
   Reset(fl,1);
   size:=FileSize(fl);
   GetMem(p,size);
   BlockRead(fl,p^,size);
   Close(fl);
  end;

procedure prpoint;
 var
  i,j:integer;
  sss:string;
 begin
  for i:=1 to kolkart do
   begin
    str(i,sss);
    zapomni(p[i],sizes[i],'krt\'+sss+'.img');
   end;
  for i:=1 to 4 do
   zapomni(pship[i],shipsizes[i],'krt\'+shipstr[i]+'.img');
  for i:=1 to 3 do
   for j:=1 to 4 do
    begin
     str(i,sss);
     zapomni(pchel[i,j],chelsizes[i,j],'krt\'+sss+chelstr[j]+'.img');
    end;
  zapomni(pmoney,monsize,'krt\money.img');
  zapomni(pchelm,pchelmsize,'krt\chelm.img');
  zapomni(phod,phodsize,'krt\whot.img');
  zapomni(pstrl,pstrlsize,'krt\strl.img');
 end;

procedure gr;
 var
  gd,gm:integer;
 begin
  gd:=detect;
  initgraph(gd,gm,'F:\tp7\bgi');
 end;

procedure rispole;
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
 end;


procedure enterkey(x,y,offs:integer;var s:string);
var
 ch:char;
 xx:integer;
begin
 xx:=x;
 repeat
  ch:=readkey;
  if ch<>#13 then
   begin
    s:=s+ch;
    outtextxy(xx,y,ch);
    xx:=xx+offs;
   end;
 until ch=#13;
end;

procedure spros;
 var
  ch:char;
  i,i1:0..5;
  x:integer;
  forsh:1..4;
  s:string;
 begin
 repeat
  for forsh:=1 to 4 do
   igr[forsh]:=0;
  i:=1;  i1:=i;
   repeat
    for forsh:=1 to 4 do
     begin
     setcolor(colorplay[forsh]);
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
   for i:=1 to 4 do
    if igr[i]<>0 then
     begin
      str(i,s);
      setcolor(colorplay[i]);
      outtextxy(100,100,'Введите имя '+s+'-го игpока.');
      playnamestr[i]:='';
      enterkey(100,120,8,playnamestr[i]);
       cleardevice;
     end;
 end;



procedure wrt(s:string;c:integer;stroka:byte;och:byte);
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
end;

procedure ris1p(x,y:klet);
var i:integer;
begin
 putimage((x-1)*40+21,(y-1)*40+21,p[matrprin[x,y]]^,normalput);
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
 end;

procedure shipxy(m:byte;var x,y:byte);
begin
 case m of
  0..11: begin x:=m+1;  y:=0;    end;
 12..23: begin x:=12;   y:=m-11; end;
 24..35: begin x:=35-m; y:=12;   end;
 36..47: begin x:=0;    y:=47-m; end;
 end;
end;

function shipx(m:byte):byte;
begin
 case m of
  0..11: shipx:=m+1;
 12..23: shipx:=12;
 24..35: shipx:=35-m;
 36..47: shipx:=0;
 end;
end;

function shipy(m:byte):byte;
begin
 case m of
  0..11: shipy:=0;
 12..23: shipy:=m-11;
 24..35: shipy:=12;
 36..47: shipy:=47-m;
 end;
end;

procedure setshipkor(x,y:byte;var xx,yy:integer);
begin
 xx:=x*40-8; yy:=y*40-8;
 if x=0 then xx:=0;
 if x=12 then xx:=463;
 if y=0 then yy:=0;
 if y=12 then yy:=464;
end;

procedure ochship(m:byte);
var
 xx,yy:integer;
begin
 setshipkor(shipx(m),shipy(m),xx,yy);
 setfillstyle(1,0);
 bar(xx,yy,xx+15,yy+15);
end;

procedure risship(m,col:byte);
var
 xx,yy:integer;
begin
 setshipkor(shipx(m),shipy(m),xx,yy);
 setfillstyle(1,0);
 bar(xx,yy,xx+15,yy+15);
 putimage(xx,yy,pship[col]^,1);
end;

function getnap(ch:char;m:integer):integer;
begin
      case ch of
       left: case m of
           0..22,47: getnap:=-1;
             23..46: getnap:=1;
             end;
      right: case m of
              0..22: getnap:=1;
                 47: getnap:=1;
             23..46: getnap:=-1;
             end;
         up: case m of
              0..23: getnap:=-1;
             24..47: getnap:=1;
             end;
       down: case m of
              0..34: getnap:=1;
             35..47: getnap:=-1;
             end;
      end;
end;

function shkr(ch:char;m:integer):byte;
var
 nap:-1..1;
begin
        nap:=getnap(ch,m);
        repeat
         m:=m+nap;
         if m<0 then m:=47;
         if m>47 then m:=0;
        until shipmatr[m]=0;
       shkr:=m;
end;

procedure placeship;
var
 x,y,x1,y1,i:integer;
 ch:char;
 m,m1:integer;
begin
 for i:=-1 to 48 do
   shipmatr[i]:=0;
 for i:=1 to 4 do
  if igr[i]<>0 then
   begin
    settextstyle(0,0,1);
    wrt(playnamestr[i]+',',colorplay[i],2,1);
    wrt('select place',colorplay[i],3,0);
    wrt('for your ship',colorplay[i],4,0);
     case i of
      1: m:=5;
      2: m:=17;
      3: m:=29;
      4: m:=41;
     end;
     while shipmatr[m]<>0 do
      m:=random(48);
     m1:=m;
     repeat
      risship(m,i);
      ch:=readkey; if ch=#0 then ch:=readkey;
      if (ch=left) or (ch=right) or (ch=up) or (ch=down) then
       begin
        ochship(m1);
        m:=shkr(ch,m);
    {   risship(m,i);  }
        m1:=m;
       end;
     until ch=#13;
     shipkord[i]:=m;
     shipmatr[m]:=i;
      for x:=0 to 3 do
       begin
        chelkord[x,i,1]:=shipx(shipkord[i]);
        chelkord[x,i,2]:=shipy(shipkord[i]);
       end;
   end;
end;

procedure freem;
 var
  i,j:1..kolkart;
 begin
  for i:=1 to kolkart do
   freemem(p[i],sizes[i]);
  for i:=1 to 4 do
   freemem(pship[i],shipsizes[i]);
  for i:=1 to 3 do
   for j:=1 to 4 do
    freemem(pchel[i,j],chelsizes[i,j]);
  freemem(pmoney,monsize);
  freemem(pchelm,pchelmsize);
  freemem(phod,phodsize);
  freemem(pstrl,pstrlsize);
 end;

end.