%membersihkan
clc
clear all

%import data
Data2016nilai=cell2mat(table2cell(readtable('Data2016nilai.csv','Delimiter',';')));
Data2017nilai=cell2mat(table2cell(readtable('Data2017nilai.csv','Delimiter',';')));
Data2018nilai=cell2mat(table2cell(readtable('Data2018nilai.csv','Delimiter',';')));

Data2016jurusan=table2cell(readtable('Data2016jurusan.csv'));
Data2017jurusan=table2cell(readtable('Data2017jurusan.csv'));
Data2018jurusan=table2cell(readtable('Data2018jurusan.csv'));

%combine data
Nilai201620172018 = [Data2016nilai; Data2017nilai; Data2018nilai;];
Jurusan201620172018 = [Data2016jurusan; Data2017jurusan; Data2018jurusan;];
panjangtabel=length(Jurusan201620172018);

%normalisasi minmax 1-10
for i = 1:length(Nilai201620172018)
    readbyline = Nilai201620172018(i,:);
    for j = 1:6
        readcol=readbyline(1,j:j);
        minim = min(Nilai201620172018(1:end,j));
        maxim = max(Nilai201620172018(1:end,j));
        norm10(j)=(((readcol-minim)*(10-1))/(maxim-minim))+1;
    end
    resultnorm10(i,:)=norm10(:,:);
end
partisi = panjangtabel/3;
partisi = round(partisi);
n=1
m=1
%partisi uji
partisi1 = resultnorm10(1:partisi,n:m);
partisi2 = resultnorm10(partisi+1:partisi+partisi,n:m);
partisi3 = resultnorm10(partisi+partisi+1:end,n:m);
partisijurusan1 = Jurusan201620172018(1:partisi,1);
partisijurusan2 = Jurusan201620172018(partisi+1:partisi+partisi,1);
partisijurusan3 = Jurusan201620172018(partisi*2+1:end,1);

%partisi latih
latihpartisi1 = [partisi2; partisi3];
latihpartisi2 = [partisi1; partisi3];
latihpartisi3 = [partisi1; partisi2];
latihpartisijurusan1 = [partisijurusan2; partisijurusan3];
latihpartisijurusan2 = [partisijurusan1; partisijurusan3];
latihpartisijurusan3 = [partisijurusan1; partisijurusan2];

%panjang tiap partisi
panjangpartisi1 = length(partisi1);
panjangpartisi2 = length(partisi2);
panjangpartisi3 = length(partisi3);
panjangpartisilatih1 = length(latihpartisi1);
panjangpartisilatih2 = length(latihpartisi2);
panjangpartisilatih3 = length(latihpartisi3);

%knn
nilaik=5;

for i = 1:panjangpartisi1
    readbyline = partisi1(i:i,:);
       kelashasil=knnclassify(readbyline,latihpartisi1,latihpartisijurusan1,nilaik);
       hasilbos1(i)=[kelashasil];
end
hasilbostrans1=hasilbos1';
hasilmatrik1=confusionmat(partisijurusan1,hasilbostrans1);
akurasi1=(sum(diag(hasilmatrik1))/sum(sum(hasilmatrik1)))*100;
plotConfMat(hasilmatrik1);
%kfold ke 2 dan akurasi
for i = 1:panjangpartisi2
    readbyline = partisi2(i:i,:);
       kelashasil=knnclassify(readbyline,latihpartisi2,latihpartisijurusan2,nilaik);
       hasilbos2(i)=[kelashasil];
end
hasilbostrans2=hasilbos2';
hasilmatrik2=confusionmat(partisijurusan2,hasilbostrans2);
akurasi2=(sum(diag(hasilmatrik2))/sum(sum(hasilmatrik2)))*100;
plotConfMat(hasilmatrik2);
%kfold ke 3 dan akurasi
for i = 1:panjangpartisi3
    readbyline3 = partisi3(i:i,:);
       kelashasil=knnclassify(readbyline3,latihpartisi3,latihpartisijurusan3,nilaik);
       hasilbos3(i)=[kelashasil];
end
hasilbostrans3=hasilbos3';
hasilmatrik3=confusionmat(partisijurusan3,hasilbostrans3);
akurasi3=(sum(diag(hasilmatrik3))/sum(sum(hasilmatrik3)))*100;
plotConfMat(hasilmatrik3);
rataakurasi=((akurasi1+akurasi2+akurasi3)/3);
%data tunggal
% asda = [65 86 67.5 58 69.13	276.50];
% for j = 1:6
%         readcol=asda(1,j:j);
%         minim = min(Nilai201620172018(1:end,j));
%         maxim = max(Nilai201620172018(1:end,j));
%         norm10(j)=(((readcol-minim)*(10-1))/(maxim-minim))+1;
% end
% 
% coba = funknn(norm10,resultnorm10,Jurusan201620172018,3);
% kNNModel = fitcknn(resultnorm10,Jurusan201620172018,'NumNeighbors',3);
% % coba = knn(resultnorm10, Jurusan201620172018, norm10,3);
% Group = predict(kNNModel,norm10);
% disp(Group);