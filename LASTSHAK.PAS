program shakalik;
 uses shaknew,graph,crt;
{type}
var
 x,y,x1,y1:integer;
 i:integer;
 money:array[1..4] of byte;
 ch:char;
 turnunit:0..4;
 cheihod:1..5;
{ mm:array[-1..13,-1..13] of klt;
 chel:array[0..3,1..4] of chl;}

{procedure zapomni(var p:pointer;size:word;path:string);
procedure prpoint;
procedure gr;
procedure rispole;
procedure enterkey(x,y,offs:integer;var s:string);
procedure spros;
procedure wrt(s:string;c:integer;stroka:byte;och:byte);
procedure ris1p(x,y:klet);
procedure risall;
procedure ochship(m:byte);
procedure risship(m,col:byte);
procedure placeship;
procedure freem; }

function strely(y:byte):byte;
begin
 if y>0 then strely:=y-1 else strely:=y+1;
end;

procedure zastavka;
const
 s:array[1..4] of string=('èpÆ£p†¨¨®·‚: Ä.Ç.ë.','ï„§Æ¶≠®™: Ä.Ç.ë.',
 'å„ßÎ™†: HÖí à HÖ ÅìÑÖí.','á¢„™®: HÖí à HÖ ÅìÑÖí');
var
 y,i:integer;
begin
 settextstyle(0,0,3);
 setbkcolor(1);
 y:=getmaxy;
  repeat
   for i:=1 to 4 do
    begin
     setcolor(5);
     outtextxy(100,y+i*50,s[i]);
     setcolor(0);
     outtextxy(100,y+10+i*50,s[i]);
     setcolor(5);
     outtextxy(100,y+i*50,s[i]);
    end;
   y:=y-10;
   delay(50);
  until (y<0) or keypressed;
  cleardevice;
  setbkcolor(0);
end;

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
   mm[rnx,rny].prin:=0;
 for i:=1 to kolkart do
  begin
   scht:=0;
   while scht<kolvo[i] do
    begin
     rxy:=random(121);
     rnx:=(rxy mod 11)+1;
     rny:=(rxy div 11)+1;
     if mm[rnx,rny].prin=0 then
         begin
          mm[rnx,rny].prin:=i;
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
      chel[j,i].mon:=0;
      chel[j,i].liv:=1;
     end;
   end;
   for i:=4 downto 1 do
    if igr[i]<>0 then begin cheihod:=i; end;
   turnunit:=0;
    for i:=-1 to 13 do
     for j:=-1 to 13 do
      with mm[i,j] do
       begin
        open:=0;
        mon:=0;
       end;
end;

procedure showstatus(i:byte);
var
 j,kch:byte;
 s:string;
begin
 {  for j:=1 to 4 do
    chelonship[j]:=3;}
  {----------------- ris strel --------------------
     x1strel:=xstrel; y1strel:=ystrel;
     ystrel:=strely(chel[turnunit,i].y);
     xstrel:=chel[turnunit,i].x;
     if y1strel>0 then rispoint(x1strel,y1strel,pstdown,0)
        else rispoint(x1strel,y1strel,pstup,0);
     if ystrel>0 then rispoint(xstrel,ystrel,pstdown,0)
        else rispoint(xstrel,ystrel,pstup,0);
  -----------------------------------------------------------------}
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
      kch:=0;
      for j:=1 to 3 do
       if (chel[j,i].x=chel[0,i].x) and (chel[j,i].y=chel[0,i].y) then inc(kch);
      if kch>0 then putimage(520,i*91-60,pchel[kch,i]^,1);
      putimage(500,i*91-30,pmoney^,1);
      str(money[i],s);
      outtextxy(525,i*91-25,s);
       for j:=1 to 3 do
        if chel[j,i].liv=1 then
         begin
          putimage(575,i*91+j*15-55,pchel[1,i]^,1);
          if chel[j,i].mon=1 then putimage(585,i*91+j*15-55,pchelm^,1);
         end;
      putimage(575,i*91-62,pship[i]^,1);
      if cheihod=i then
           begin
            putimage(605,i*91-60,phod^,1);
            putimage(560,i*92+turnunit*15-58,pstrl^,1);
           end;
     end;

end;

procedure mch(un,i,x,y,otbir:integer);
var
 x1,y1,k,j:integer;
begin
 x1:=chel[un,i].x;      { starie }
 y1:=chel[un,i].y;      { koordinati }
 chel[un,i].x:=x;       { novie }
 chel[un,i].y:=y;       { koordinati }
 if un=0 then
  begin
    for j:=1 to 3 do
     if (chel[j,i].x=x1) and (chel[j,i].y=y1) then
      begin
       chel[j,i].x:=x;
       chel[j,i].y:=y;
      end;
  end
   else
 begin
  if otbir=1 then
   if chel[un,i].mon=1 then     { otbiraem monetu }
     begin
      chel[un,i].mon:=0;
      inc(mm[x1,y1].mon);
     end;
 end;
end;

procedure reliv(i:byte);
label b10;
var
 n:byte;
begin
 for n:=1 to 3 do
  if chel[n,i].liv=0 then
   begin
    chel[n,i].liv:=1;
    chel[n,i].x:=chel[0,i].x;
    chel[n,i].y:=chel[0,i].y;
    goto b10;
   end;
 b10:
end;

procedure movtoklet(i,un,x,y:integer);
label a200;
var
 napx,napy,o,opn:integer;
begin
 napx:=x-chel[un,i].x;
 napy:=y-chel[un,i].y;
 if (x=0) or (x=12) or (y=0) or (y=12) then
  goto a200;
 opn:=mm[x,y].open;
 mm[x,y].open:=1; ris1p(x,y); o:=0;
 case mm[x,y].prin of
{1-pusto,2-boloto2,3-boloto3,4-boloto4,5-boloto5,6-moneta1,7-moneta2,
8-moneta3,9-moneta4,10-moneta5,11-osminog,12-ejik,13-ostrov,14-ostrovsneg,
15-djin,16-akula,17-krab,18-zvezda,19-vodovorot,20-konek,21-cherepaha,
22-strelvverh,23-stvniz,24-stvpravo,25-stvlevo,26-stlevoniz,27-stlevoverh,
28-stpravoverh,29-stpravoniz,30-diagstrel,31-stlevopravo,32-stverhniz,
33-stvergor,34-stvovsestor,35-st'/',36-st'\'}
    {  1: nefiga}
 {  2..5: boloto}
  6..10: if opn=0 then mm[x,y].mon:=mm[x,y].prin-5;
     11:  begin
          end;
     12: begin mch(un,i,chel[0,i].x,chel[0,i].y,0); goto a200; end;
     13: o:=1;
     14: begin reliv(i); o:=1; end;
     15: begin {djin(un,i);} o:=1; end;
     16: begin chel[un,i].liv:=0; goto a200; end;
     17: begin movtoklet(i,un,x,y); goto a200; end;
     18: begin {zvezda(un,i);} goto a200; end;
     19: begin chel[un,i].mon:=0; movtoklet(i,un,x,y);
               goto a200; end;
{     20: konek;
     21: cher;
 22..36: mstrel(mm[x,y].prin,un,i);}
 end;
   if (mm[x,y].mon>0) and (chel[un,i].mon=0) then
    begin
     mm[x,y].mon:=mm[x,y].mon-1;
     chel[un,i].mon:=1;
    end;
 mch(un,i,x,y,o);
a200:
  mm[x,y].open:=1;
  ris1p(x1,y1);
  ris1p(x,y);
end;

procedure movun(i,un:byte;ch:char;var eot:boolean);
label a100;
var
 nap:integer;
 m:integer;
 napx,napy:integer;
 x,y,x1,y1:integer;
 ii,jj:integer;
 s:string;
begin
 if un=0 then    { hod korablem }
  begin
   if ch=#27 then halt(1);
   x1:=chel[0,i].x;
   y1:=chel[0,i].y;
   if mm[shipx(m),shipy(m)].col=0 then
    begin
     mch(0,i,shipx(m),shipy(m),0);
     ochship(x1);
     rischel(shipx(m),shipy(m),0,i);
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
         x1:=chel[un,i].x;
         y1:=chel[un,i].y;
         x:=chel[un,i].x+napx;
         y:=chel[un,i].y+napy;
         if (mm[x,y].prin>12) and (mm[x,y].prin<16) and
            (mm[x,y].kolch>0) and { esli hodit na ostrov }
            (mm[x,y].col<>i) then { gde chujoi chelovek  }
            goto a100;
         if (chel[un,i].onship=1) and (napx<>0) and (napy<>0) then
            goto a100; {esli hodit s korablia po diagonali}
         if (mm[x1,y1].sea=0) and (mm[x,y].sea=1) and
            ((x<>chel[0,i].x) or (y<>chel[0,i].y)) then
            goto a100;  {esli hodit v more, no ne na korabl}
         if (chel[un,i].onship=1) and (mm[x,y].sea=1) then goto a100;
           if (mm[x,y].col<>i) and (mm[x,y].col>0) then
            begin    { sbivaem chujogo pirata }
             jj:=mm[x,y].col;
             mm[x,y].kolch:=0;
              for ii:=1 to 3 do
               if (chel[ii,jj].x=x) and (chel[ii,jj].y=y) then
                  mch(ii,jj,chel[0,jj].x,chel[0,jj].y,1);
             showstatus(jj);
            end;
             eot:=true;
             movtoklet(i,un,x,y,x1,y1);
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
    wrt('Ç†Ë ÂÆ§,',colorplay[i],2,1);
    wrt(playnamestr[cheihod],colorplay[cheihod],3,0);
    showstatus(cheihod);
    repeat
     repeat
      ch:=readkey;
      if ch=#27 then exit;
     until (ch=tab) or (ch=left) or (ch=right) or (ch=up) or (ch=down)
     or (ch=left2) or (ch=right2) or (ch=up2) or (ch=down2)
     or (ch='w') or (ch='a') or (ch='x') or (ch='d') or (ch='q')
     or (ch='e') or (ch='z') or (ch='c') or (ch=leftup)
     or (ch=leftdown) or (ch=rightup) or (ch=rightdown)
     or (ch=leftdown2) or (ch=rightup2) or (ch=rightdown2)
     or (ch=leftup2) or (ch=esc);

     if ch=tab then
      repeat
       turnunit:=turnunit+1;
       if turnunit>3 then turnunit:=0;
      until chel[turnunit,cheihod].liv=1;

     if (ch=left) or (ch=right) or (ch=up) or (ch=down)
     or (ch=left2) or (ch=right2) or (ch=up2) or (ch=down2)
     or (ch='w') or (ch='a') or (ch='x') or (ch='d') or (ch='q')
     or (ch='e') or (ch='z') or (ch='c') or (ch=leftup)
     or (ch=leftdown) or (ch=rightup) or (ch=rightdown)
     or (ch=leftdown2) or (ch=rightup2) or (ch=rightdown2)
     or (ch=leftup2) then
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
 prmprin;
 gr;
 prpoint;
 zastavka;
 putimage(100,100,ptarg^,1);
 readln;
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
  repeat
   gameturn;
  until ch=#27;
 closegraph;
 freem;
END.