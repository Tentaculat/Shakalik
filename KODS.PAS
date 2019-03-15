uses crt;
var
 ch:char;
begin
 repeat
  ch:=readkey;
  write('Code of this key ("');
  write(ch);
  write('") is ');
  writeln(ord(ch));
 until ch=#27;
end.