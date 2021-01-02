direc = [pwd];
filenames = dir('*.io');

for i = 1:length(filenames)
file = filenames(i).name

fid = fopen([direc '\' file]);
dat = textscan(fid,' %s','delimiter','\n');
fclose(fid);
dat = dat{:};

fline = 0;
tmp = dat{1};
while isempty(strfind(tmp,'1-'))
  fline=fline+1;
  tmp=dat{fline};
end

cnt = 1;
clear('new');
new{cnt,1} = regexp(tmp,'\d*-       (.*)','tokens'){1}{1};

while 1
  cnt = cnt+1;
  fline = fline+1;
  tmp = dat{fline};
  if ~isempty(regexp(tmp,'\d*-\s*(.*)'))
    new{cnt,1} = regexp(tmp,'\d*-       (.*)','tokens'){1}{1};
  elseif or(~isempty(strfind(tmp,'warning.')), ~isempty(strfind(tmp,'comment.')))
    cnt = cnt-1;
    continue
  else
    break;
  endif
  
end

fid = fopen(file(1:end-1),'w');
for i = 1:length(new)
  fprintf(fid,'%s \n',new{i})
endfor

fclose(fid)

addline1 = lower('c Begin surface cards');
addline2 = lower('c begin data cards');

endfor