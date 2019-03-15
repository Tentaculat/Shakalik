program shakalik;
 uses graph,crt,shak;
type
 klt=record
      kolch:0..3;
      col:0..4;
      mon:0..20;
      open:0..1;
      sea:0..1;
     end;
var
 x,y,x1,y1:integer;
 i:integer;
 money:array[1..4] of byte;
 chelonship:array[1..4] of 0..3;
 chelmoney:array[1..3,1..4] of 0..1;
 livchel:array[0..3,1..4] of 0..1;
 ch:char;
 turnunit:0..4;
 cheihod:1..5;
 mm:array[-1..13,-1..13] of klt;

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

procedure prmprin;
{1-pusto,2-boloto2,3-boloto3,4-boloto4,5-boloto5,6-moneta1,7-moneta2,
8-moneta3,9-moneta4,10-moneta5,11-osminog,12-ejik,13-ostrov,14-ostrovsneg,
15-djin,16-akula,17-krab,18-zvezda,19-vodovorot,20-konek,21-cherepaha,
22-strelvverh,23-stvniz,24-stvpravo,25-stvlevo,26-stlevoniz,27-stlevoverh,
28-stpravoverh,29-stpravoniz,30-diagstrel,31-stlevopravo,32-stverhniz,
33-stvergor,34-stvovsestor,35-st'/',36-st'\'}
const
 kolvo:array[1..kolkart] of 1..42=(42,5,4,3,1,5,5,3,2,1,4,2,3,1,1,1,4,2,4,
                                   2,4,1,1,1,1,1,1,1,1,3,2,1,3,2,2,1);
var
 scht:0..20;
 rxy:byte;
 rnx,rny:integer;
 i:kart;
begin
 randomize;
 for rnx:=-1 to 13 do
  for rny:=-1 to 13 do
   matrprin[rnx,rny]:=0;
 for i:=1 to kolkart do
  begin
   scht:=0;
   while scht<kolvo[i] do
    begin
     rxy:=random(121);
     rnx:=(rxy mod 11)+1;
     rny:=(rxy div 11)+1;
     if matrprin[rnx,rny]=0 then
         begin
          matrprin[rnx,rny]:=i;
          scht:=scht+1;
         end;
    end;
  end;
end;

procedure prisvbegin;
var
 i,j,k:integer;
begin
 for i:=1 to 4 do
  if igr[i]<>0 then
   begin
    money[i]:=0;
    for j:=0 to 3 do
     begin
      chelmoney[j,i]:=0;
      livchel[j,i]:=1;
     end;
    chelonship[i]:=3;
   end;
   for i:=4 downto 1 do
    if igr[i]<>0 then cheihod:=i;
   chelmoney[3,1]:=1;
   turnunit:=0;
    for i:=-1 to 13 do
     for j:=-1 to 13 do
      with mm[i,j] do
       begin
        open:=0;
        mon:=0;
        kolch:=0;
        col:=0;
        if (j<1) or (j>11) or (i<1) or (i>11) then
        sea:=1 else sea:=0;
       end;
end;

procedure rischel(x,y,i,j:integer);
var
 xx,yy,xx1,yy1:integer;
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
 setfillstyle(1,0);
 bar(xx,yy,xx1,yy1);
 putimage(xx,yy,pchel[i,j]^,1);
end;

procedure showstatus(i:byte);
var
 j:byte;
 s:string;
begin
 {  for j:=1 to 4 do
    chelonship[j]:=3;}
   setfillstyle(1,0);
   bar(487,i*91-79,628,i*91+8);
   if igr[i]=0 then
    begin
     setcolor(colorplay[i]);
     settextstyle(0,0,3);
     outtextxy(525,i*91-45,'off');
    end
   else
     begin
      setcolor(colorplay[i]);
      settextstyle(0,0,1);
      outtextxy(555-(length(playnamestr[i])*4),i*91-74,playnamestr[i]);
      putimage(500,i*91-60,pship[i]^,1);
      if chelonship[i]<>0 then
       putimage(520,i*91-60,pchel[chelonship[i],i]^,1);
      putimage(500,i*91-30,pmoney^,1);
      str(money[i],s);
      outtextxy(525,i*91-25,s);
       for j:=1 to 3 do
        if livchel[j,i]=1 then
         begin
          putimage(575,i*91+j*15-55,pchel[1,i]^,1);
          if chelmoney[j,i]=1 then putimage(585,i*91+j*15-55,pchelm^,1);
         end;
      putimage(575,i*91-62,pship[i]^,1);
      if cheihod=i then
           begin
            putimage(605,i*91-60,phod^,1);
            putimage(560,i*92+turnunit*15-58,pstrl^,1);
           end;
     end;
end;

procedure movun(i,un:byte;ch:char;var eot:boolean);
label a100;
var
 nap:integer;
 m:integer;
 napx,napy:integer;
 x,y:integer;
 ii,jj:integer;
begin
 if un=0 then    { hod korablem }
  begin
   nap:=getnap(ch,shipkord[i]);
   m:=shipkord[i]+nap;
   if m>47 then m:=0;
   if m<0 then m:=47;
   if shipmatr[m]=0 then
    begin
     ochship(shipkord[i]);
     shipmatr[shipkord[i]]:=0;
     shipkord[i]:=m;
     shipmatr[m]:=i;
     risship(shipkord[i],i);
     eot:=true;
    end;
  end
   else
    begin;    { hodit chelovek; }
       napx:=0; napy:=0;
       case ch of
           left,left2,'a': napx:=-1;
         right,right2,'d': napx:=1;
               up,up2,'w': napy:=-1;
           down,down2,'x': napy:=1;
       leftup,leftup2,'q': begin napx:=-1; napy:=-1; end;
     rightup,rightup2,'e': begin napx:=1; napy:=-1;  end;
 rightdown,rightdown2,'c': begin napx:=1; napy:=1;   end;
   leftdown,leftdown2,'z': begin napx:=-1; napy:=1;  end;
       end;
         x:=chelkord[un,i,1]+napx;
         y:=chelkord[un,i,2]+napy;
       if (chelkord[un,i,1]=shipx(shipkord[i])) and  { esli  }
          (chelkord[un,i,2]=shipy(shipkord[i])) then { na korable }
     begin
         if (matrprin[x,y]>12) and (matrprin[x,y]<16) and
            (mm[x,y].kolch>0) and { esli hodit na ostrov }
            (mm[x,y].col<>i) then { gde chujoi chelovek  }
            goto a100;
         if (mm[x,y].sea=0) then
          begin
           {movtoklet(un,i,x,y);}
           if mm[x,y].col<>i then
            begin    { sbivaem chujogo pirata }
             jj:=mm[x,y].col;
             mm[x,y].col:=i;
             mm[x,y].kolch:=1;
              for ii:=1 to 3 do
               if (chelkord[ii,jj,1]=x) and (chelkord[ii,jj,2]=y) then
                begin

                end;
            end;
          end;
     end;
    end;
a100:
end;

procedure gameturn;
var
 eot:boolean;
 i:1..4;
begin
 eot:=false;
   begin
    wrt('Ваш ход,',colorplay[i],2,1);
    wrt(playnamestr[cheihod],colorplay[cheihod],3,0);
    showstatus(cheihod);
    repeat
     repeat
      ch:=readkey;
     until (ch=tab) or (ch=esc) or (ch=right) or (ch=left) or (ch=up) or
           (ch=down);
     if ch=tab then
      repeat
       turnunit:=turnunit+1;
       if turnunit>3 then turnunit:=0;
      until livchel[turnunit,cheihod]=1;

     if (ch=left) or (ch=right) or (ch=up) or (ch=down) then
        movun(cheihod,turnunit,ch,eot);

      showstatus(cheihod);
     { if ch=esc then eot:=true; }
    until eot;
    i:=cheihod;
     repeat
      cheihod:=cheihod+1;
      if cheihod>4 then cheihod:=1;
     until igr[cheihod]<>0;
     showstatus(i);
   end;
end;
{***********************************************************************}
{-----------------------------------------------------------------------}
{***********************************************************************}


{***********************************************************************}
{-----------------------------------------------------------------------}
{***********************************************************************}


BEGIN
{ prmprin; }
 gr;
 prpoint;
{ spros;}
 for i:=1 to 4 do
 igr[i]:=1;
 playnamestr[1]:='Vasia';
 playnamestr[2]:='Gravis Ultrasound';
 playnamestr[3]:='egavga.bgi';
 playnamestr[4]:='turbo.exe';

 prisvbegin;
 rispole;
  for i:=1 to 4 do
   showstatus(i);
 placeship;
  for i:=1 to 4 do
   gameturn;
 readln;
 closegraph;
 freem;
END;

