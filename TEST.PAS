var
 x,y,m:byte;

function shipm(x,y:integer):integer;
begin
 if (x=0) and (y>0) then shipm:=48-y;
 if y=0 then shipm:=x;
 if x=12 then shipm:=12+y;
 if y=12 then shipm:=36-x;
end;

procedure writ;
begin
 writeln(x,'  ',y,' m=',m);
end;

begin
 m:=0;
 repeat
  writeln('Enter x and y');
  readln(x,y);
  m:=shipm(x,y);
  writ;
  readln;
 until (x=0) and (y=0);
end.
