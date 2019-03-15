unit shaknew;

interface
uses graph,crt;
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

 klt=record
      prin:0..36;
      mon:0..20;
      open:0..1;
     end;

 chl=record
      liv:0..1;
      mon:0..1;
      x:0..12;
      y:0..12;
     end;
var
 igr:array[1..4] of -1..3;
 p:array[1..kolkart] of pointer;
 playnamestr:array[1..4] of string;
 pship:array[1..4] of pointer;
 pchel:array[1..3,1..4] of pointer;
 pmoney,phod,pchelm,pstrl,pstdown,pstup,ptarg,psmtarg:pointer;
 monsize,phodsize,pchelmsize,pstrlsize,pstdownsz,pstupsz,ptargsz,
 psmtargsz:word;
 sizes:array[1..kolkart] of word;
 shipsizes:array[1..4] of word;
 chelsizes:array[1..3,1..4] of word;
 mm:array[-1..13,-1..13] of klt;
 chel:array[0..3,1..4] of chl;

procedure zapomni(var p:pointer;size:word;path:string);
procedure prpoint;
procedure gr;
procedure rispole;
procedure enterkey(x,y,offs:integer;var s:string);
procedure spros;
procedure rispoint(x,y:integer;p:pointer;och:byte);
procedure rischel(x,y,i,j:integer);
procedure wrt(s:string;c:integer;stroka:byte;och:byte);
procedure ris1p(x,y:klet);
procedure risall;
procedure setshipkor(x,y:byte;var xx,yy:integer);
procedure ochship(x,y:byte);
procedure placeship;
procedure freem;

implementation


 procedure zapomni(var p:pointer;size:word;path:string);
  var
   fl:file;
  begin
   Assign(fl,'krt\'+path);
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
    zapomni(p[i],sizes[i],sss+'.img');
   end;
  for i:=1 to 4 do
   zapomni(pship[i],shipsizes[i],shipstr[i]+'.img');
  for i:=1 to 3 do
   for j:=1 to 4 do
    begin
     str(i,sss);
     zapomni(pchel[i,j],chelsizes[i,j],sss+chelstr[j]+'.img');
    end;
  zapomni(pmoney,monsize,'money.img');
  zapomni(pchelm,pchelmsize,'chelm.img');
  zapomni(phod,phodsize,'whot.img');
  zapomni(pstrl,pstrlsize,'strl.img');
  zapomni(pstdown,pstdownsz,'stdown.img');
  zapomni(pstup,pstupsz,'stup.img');
  zapomni(ptarg,ptargsz,'targ.img');
  zapomni(psmtarg,psmtargsz,'smtarg.img');
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

procedure rispoint(x,y:integer;p:pointer;och:byte);
var
 xx,yy:integer;
begin
 setshipkor(x,y,xx,yy);
 if och=1 then
 bar(xx,yy,xx+15,yy+15);
 putimage(xx,yy,p^,2);
end;

procedure rischel(x,y,i,j:integer);
var
 xx,yy,xx1,yy1:integer;
begin
 setfillstyle(1,0);
 if i=0 then
   rispoint(x,y,pship[j],1)
  else
 begin
  xx:=(x-1)*40+32;
  yy:=(y-1)*40+33;
  xx1:=xx+15;
  yy1:=yy+15;
  if i=1 then
   begin
    xx:=xx+4;
    yy:=yy+4;
    xx1:=xx+7;
    yy1:=yy+7;
   end;
  bar(xx,yy,xx1,yy1);
  putimage(xx,yy,pchel[i,j]^,1);
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
var i,j,k,kch:integer; s:string;
begin
 if mm[x,y].open=1 then
 begin
   putimage((x-1)*40+21,(y-1)*40+21,p[mm[x,y].prin]^,0);
   for i:=1 to 4 do
     begin
      kch:=0;
      for j:=0 to 3 do if (chel[j,i].x=x) and (chel[j,i].y=y) then
       inc(kch);
      if kch>0 then rischel(x,y,kch,i);
     end;
   if mm[x,y].mon>0 then            { esli na kletke est dengi }
    begin
     setcolor(yellow);
     str(mm[x,y].mon,s);
     bar((x-1)*40+21,(y-1)*40+21,(x-1)*40+21+length(s)*8,(y-1)*40+30);
     outtextxy((x-1)*40+22,(y-1)*40+22,s);
    end;
   setlinestyle(0,0,1);
   setcolor(lightblue);
   rectangle((x-1)*40+20,(y-1)*40+20,(x-1)*40+60,(y-1)*40+60);
 end;
end;

procedure risall;
 var
  i,j:1..11;
 begin
  for i:=1 to 11 do
   for j:=1 to 11 do
     begin
      mm[i,j].open:=1;
      ris1p(i,j);
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

procedure ochship(x,y:byte);
var
 xx,yy:integer;
begin
 setshipkor(x,y,xx,yy);
 setfillstyle(1,0);
 bar(xx,yy,xx+15,yy+15);
end;

procedure placeship;
var
 x,y,x1,y1,i,j:integer;
 ch:char;
 m,m1:integer;
begin
 for i:=1 to 4 do
  if igr[i]<>0 then
   begin
    settextstyle(0,0,1);
    wrt(playnamestr[i]+',',colorplay[i],2,1);
    wrt('select place',colorplay[i],3,0);
    wrt('for your ship',colorplay[i],4,0);
    repeat
     x:=random(13); y:=random(13);
     for j:=1 to 4 do if (chel[0,j].x=x) and (chel[0,j].y=y) then x:=5;
    until ((x=0) or (x=12)) and ((y=0) or (y=12));
     x1:=x; y1:=y;
     repeat
      rischel(x,y,0,i);
      ch:=readkey; if ch=#0 then ch:=readkey;
      case ch of
        left:dec(x);
       right:inc(x);
          up:dec(y);
        down:inc(y);
      end;
      for j:=1 to 4 do if (chel[0,j].x=x) and (chel[0,j].y=y) then x:=5;
       if not ((x=0) or (x=12)) and ((y=0) or (y=12)) then
        begin x:=x1; y:=y1; end;
       if (x<>x1) or (y<>y1) then
        begin
         ochship(x1,y1);
         rischel(x,y,0,i);
         x1:=x; y1:=y;
        end;
     until ch=#13;
      for j:=0 to 3 do
       begin
        chel[x,i].x:=x;
        chel[x,i].y:=y;
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
  freemem(pstdown,pstdownsz);
  freemem(pstup,pstupsz);
  freemem(ptarg,ptargsz);
  freemem(psmtarg,psmtargsz);
 end;

end.