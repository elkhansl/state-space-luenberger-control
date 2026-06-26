%% DC MOTOR DURUM UZAYI KONTROLÜ, GÖZLEMLEYİCİ VE İNTEGRAL AKSİYONU
clear; clc;

% --- 1. SİSTEM PARAMETRELERİ ---
bm = 4.6723;
Kt = 5.6627;
Kw = 6.2;
R  = 0.973;
L  = 0.0199;

% Atalet Momentleri (Ödev yönergesine göre ayrılmış)
Jeq_design = 1.72; % Tasarım (Gözlemleyici ve Kontrolcü) için
Jeq_sim    = 2.72; % Simülasyon (Fiziksel Plant) için

% --- 2. TASARIM MATRİSLERİ (Jeq = 1.72) ---
A = [0 1 0; 
     0 -bm/Jeq_design Kt/Jeq_design; 
     0 -Kw/L -R/L];
B = [0; 0; 1/L];
C = [1 0 0];

% --- 3. SİMÜLASYON MATRİSLERİ (Jeq = 2.72) ---
% Bu matrisler sadece Simulink'teki fiziksel modelin (Plant) içinde kullanılacak
A_sim  = [0 1 0; 
          0 -bm/Jeq_sim Kt/Jeq_sim; 
          0 -Kw/L -R/L];
B_sim  = [0; 0; 1/L];
Dw_sim = [0; -1/Jeq_sim; 0];

% --- 4. BAZ KONTROLCÜ VE GÖZLEMLEYİCİ TASARIMI ---
% Kontrolcü Kutupları
K = acker(A, B, [-10 -10 -10]);

% Gözlemleyici Kutupları (-50) ve Başlangıç Koşulu
L_obs = acker(A', C', [-50 -50 -50])';
x0_hat = [1; 1; 1];

% --- 5. İNTEGRAL AKSİYONU TASARIMI (25p) ---
% Genişletilmiş (Augmented) Sistem Matrisleri
A_aug = [A zeros(3,1); 
        -C 0];
B_aug = [B; 0];

% Genişletilmiş sistem için 4 kutup atanır
K_aug = acker(A_aug, B_aug, [-10 -10 -10 -10]);

% Kazançları Ayrıştırma: u = N_int*ref - K_new*x + Ki*integral(e)
K_new = K_aug(1:3); % Yeni Durum Geri Besleme Kazancı (Simulink'teki K matrisi)
Ki    = -K_aug(4);  % İntegral Kazancı

% Yönergede belirtilen İntegral Aksiyonu referans katsayısı
N_int = K(1)/2; 

disp('Matrisler ve kazançlar başarıyla hesaplandı. Simulink modeline geçebilirsiniz.');