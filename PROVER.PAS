var
 chelonship:array[1..4] of 0..3;
 igr:array[1..4] of byte;
 money:array[1..4] of byte;
 chelmoney:array[1..3,1..4] of 0..1;
 livchel:array[1..3,1..4] of 0..1;
 cheihod:1..5;
 turnunit:0..4;
procedure prisvbegin;
var
 i,j:byte;
begin
 for i:=1 to 4 do
  if igr[i]<>0 then
   begin
    money[i]:=0;
    chelonship[i]:=3;
    for j:=0 to 3 do
     begin
      chelmoney[j,i]:=0;
      livchel[j,i]:=1;
     end;
   end;
   for i:=4 downto 1 do
    if igr[i]<>0 then cheihod:=i;
   chelmoney[3,1]:=1;
   turnunit:=0;
end;
begin
 igr[2]:=1;
 prisvbegin;
 write(chelonship[2]);
 readln;
end.