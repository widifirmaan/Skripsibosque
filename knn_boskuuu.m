clc
clear all
Data2016nilai=cell2mat(table2cell(readtable('Data2016nilai.csv','Delimiter',';')));
Data2017nilai=cell2mat(table2cell(readtable('Data2017nilai.csv','Delimiter',';')));
Data2018nilai=cell2mat(table2cell(readtable('Data2018nilai.csv','Delimiter',';')));
Data2019nilai=cell2mat(table2cell(readtable('Data2019nilai.csv','Delimiter',';')));%baca tabel

Data2016jurusan=table2cell(readtable('Data2016jurusan.csv'));
Data2017jurusan=table2cell(readtable('Data2017jurusan.csv'));
Data2018jurusan=table2cell(readtable('Data2018jurusan.csv'));
Data2019jurusan=table2cell(readtable('Data2019jurusan.csv'));%bacajurusan

% Latih2016=[Data2016nilai,Data2016jurusan];
% Latih2017=[Data2017nilai,Data2017jurusan];
% Latih2018=[Data2018nilai,Data2018jurusan];
% Latih2019=[Data2019nilai,Data2019jurusan];%gabungannilaijurusanga dipakai

Nilai20162017 = [Data2016nilai; Data2017nilai;];
Nilai20162018 = [Data2016nilai; Data2018nilai;];
Nilai20172018 = [Data2017nilai; Data2018nilai;];
Jurusan20162017 = [Data2016jurusan; Data2017jurusan;];
Jurusan20162018 = [Data2016jurusan; Data2018jurusan;];
Jurusan20172018 = [Data2017jurusan; Data2018jurusan;];%gabungan2angkatan

%2017vs20162018
panjangtabel2017=length(Data2017jurusan);
for i = 1:panjangtabel2017
    readbyline2017 = Data2017nilai(i:i,:);
       disp(readbyline2017);
       kelashasil=knnclassify(readbyline2017,Nilai20162018,Jurusan20162018,1);
       disp(kelashasil);
end

%2016vs20172018
panjangtabel2016=length(Data2016jurusan);
for i = 1:panjangtabel2016
    readbyline2016 = Data2016nilai(i:i,:);
       disp(readbyline2016);
       kelashasil=knnclassify(readbyline2016,Nilai20172018,Jurusan20172018,1);
       disp(kelashasil);
end


%2018vs20172018
panjangtabel2018=length(Data2018jurusan);
for i = 1:panjangtabel2018
    readbyline2018 = Data2018nilai(i:i,:);
       disp(readbyline2018);
       kelashasil=knnclassify(readbyline2018,Nilai20162017,Jurusan20162017,1);
       disp(kelashasil);
end