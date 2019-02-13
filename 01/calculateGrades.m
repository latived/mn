% 8

% b

load('/home/alunoic/Documentos/latived/mn/01/classGrades.mat')

% c

namesAndGrades(1:5,:)

%{
ans =

    1.0000    2.5064    3.6529    2.4617    3.3022    2.5189    0.0963    4.6502
    2.0000    2.1586    3.2324    3.4737    0.2378    2.4480    0.4194    1.9951
    3.0000    4.9878       NaN    4.8637    1.7439    4.3852    4.8740    0.2370
    4.0000    4.0580    1.9914    1.6388    2.2567    1.7657    3.2567    1.7119
    5.0000    2.4283    3.7491    4.1890       NaN    2.2472    1.1562    3.6798
%}

% d

grades = namesAndGrades(:,2:end);

% e

%-% i

meanGrades = mean(grades)

%-% ii

meanGrades = mean(grades, 'omitnan')

%- f
%--- i

meanMatrix = ones(15,1) * meanGrades

%--- ii

curvedGrades = 3.5 .* (grades ./ meanMatrix);

%--- iii

mean(curvedGrades, 'omitnan')

%--- iv

curvedGrades(find(curvedGrades > 5)) = 5;
