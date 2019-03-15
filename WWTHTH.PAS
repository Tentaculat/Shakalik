type
 kkk=record
      o:integer;
      m:integer;
      d:integer;
     end;
var
 b:array[1..100] of kkk;
begin
 with b[3] do
  begin
   o:=4;
   m:=-10;
  end;

end.