uses graph,crt;
var
 gd,gm:integer;
 p:pointer;
 size:integer;

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

begin
  gd:=detect;
  initgraph(gd,gm,'F:\tp7\bgi');
  zapomni(p,size,'pusto.img');
  putimage(100,100,p^,1);
  readln;
  putimage(100,100,p^,1);
  closegraph;
  freemem(p,size);
end.
