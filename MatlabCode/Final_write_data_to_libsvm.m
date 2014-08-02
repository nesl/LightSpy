clear all
close all
clc

% Load the feature matrices
pmArray= load('FellowshipFeatureArray.mat');
fmArray= load('PelennorFeatureArray.mat');
dxArray= load('PhantomMenaceFeatureArray.mat');
jpArray= load('300FeatureArray.mat');
m001Array = load('BatmanBegins_FinalSceneFeatureArray.mat');
m002Array = load('BatmanBegins_TrainingSceneFeatureArray.mat');
m003Array = load('BatmanBegins_RasAlGhulFightFeatureArray.mat');
m004Array = load('TheDarkKnight_BankRobberyFeatureArray.mat');
m005Array = load('TheDarkKnight_JokersFinalSceneFeatureArray.mat');
%%m006Array = load('TheDarkKnightRises_CleanSlateFeatureArray.mat');
m007Array = load('HarryPotter_1_WizardsChessFeatureArray.mat');
m008Array = load('HarryPotter_2_DuelingClubFeatureArray.mat');
m009Array = load('HarryPotter_2_BattlingBaseliskFeatureArray.mat');
m010Array = load('HarryPotter_2_EnemiesBewareFeatureArray.mat');
m011Array = load('HarryPotter_3_RiddikulusFeatureArray.mat');
m012Array = load('HarryPotter_4_SecondTaskFeatureArray.mat');
m013Array = load('HarryPotter_4_BartyCrouchRevealedFeatureArray.mat');
m014Array = load('HarryPotter_4_ThirdTaskFeatureArray.mat');
m015Array = load('HarryPotter_5_DumbledoresArmyFeatureArray.mat');
m016Array = load('HarryPotter_5_DisciplinaryHearingFeatureArray.mat');
m017Array = load('HarryPotter_6_FelixFelicisFeatureArray.mat');
m018Array = load('HarryPotter_6_HarryIsDeadFeatureArray.mat');
m019Array = load('LionKing_Hakuna_MatataFeatureArray.mat');
m020Array = load('LionKing_CantWaitToBeKingFeatureArray.mat');
m021Array = load('BeautyAndTheBeast_BelleFeatureArray.mat');
m022Array = load('BeautyAndTheBeast_TaleAsOldAsTimeFeatureArray.mat');
m023Array = load('Aladdin_WholeNewWorldFeatureArray.mat');
m024Array = load('DrHorribleSingAlongBlog_Act1FeatureArray.mat');
m025Array = load('DrHorribleSingAlongBlog_Act2FeatureArray.mat');
m026Array = load('DrHorribleSingAlongBlog_Act3FeatureArray.mat');
m027Array = load('StarWarsEpIV_TheseAreNotTheDroidsFeatureArray.mat');
m028Array = load('StarWarsEpIV_TrashCompactorFeatureArray.mat');
m029Array = load('StarWarsEpIV_DeathStarBattleFeatureArray.mat');
m030Array = load('StarWarsEpV_BattleOfHothFeatureArray.mat');
m031Array = load('StarWarsEpV_RaisingTheXWingFeatureArray.mat');
m032Array = load('StarWarsEpVI_BattleOfEndorFeatureArray.mat');
m033Array = load('AnchorMan_CompleteFightSceneFeatureArray.mat');
m034Array = load('FastAndFurious_FinalRaceFeatureArray.mat');
m035Array = load('FastAndFurious_MiglioriSceneFeatureArray.mat');
m036Array = load('t2Fast2Furious_RaceSceneFeatureArray.mat');
m037Array = load('TokyoDrift_GarageSceneFeatureArray.mat');
m038Array = load('TokyoDrift_RaceSceneFeatureArray.mat');
m039Array = load('Aliens_CombatDropFeatureArray.mat');
m040Array = load('Aliens_ColonialMarinesFeatureArray.mat');
m041Array = load('AlienResurrection_ToTheWallFeatureArray.mat');
m042Array = load('RHPS_SweetTransvestiteFeatureArray.mat');
m043Array = load('TransformersRevenge_ShanghaiSceneFeatureArray.mat');
m044Array = load('Transformers2_ForestBattleFeatureArray.mat');
m045Array = load('TransformersRevenge_OpVsMegatronFeatureArray.mat');
m046Array = load('Transformers3_BuildingCollapseFeatureArray.mat');
m047Array = load('TropicThunder_EndingCreditsFeatureArray.mat');
m048Array = load('BurtWonderstone_ExtendedClipFeatureArray.mat');
m049Array = load('DjangoUnchained_FreeingTheSlavesFeatureArray.mat');
m050Array = load('KillBill_LucyLiuHeadSeverFeatureArray.mat');
m051Array = load('KillBill2_BuriedAliveFeatureArray.mat');
m052Array = load('KillBill_VernitaGreenFeatureArray.mat');
m053Array = load('KillBill2_EstebanVihaioFeatureArray.mat');
m054Array = load('Inception_ExplainingDreamWorldFeatureArray.mat');
m055Array = load('Inception_EndingSceneFeatureArray.mat');
m056Array = load('Inception_ZeroGravitySceneFeatureArray.mat');
m057Array = load('Inception_DisappointedSceneFeatureArray.mat');
m058Array = load('Inception_AriadneBuildsDreamFeatureArray.mat');
m059Array = load('Inception_MrCharlesFeatureArray.mat');
m060Array = load('Inception_MombasaSceneFeatureArray.mat');
m061Array = load('Inception_MalsDeathFeatureArray.mat');
m062Array = load('KnockedUp_BeardJokesFeatureArray.mat');
m063Array = load('ForgettingSarahMarshall_SurfSceneFeatureArray.mat');
m064Array = load('TheMummy_BattleSceneFeatureArray.mat');
m065Array = load('IndependenceDay_FirstAirBattleFeatureArray.mat');
m066Array = load('IndependenceDay_FinalAirBattleFeatureArray.mat');
m067Array = load('Terminator_CopshopShootoutFeatureArray.mat');
m068Array = load('Terminator2_OpeningSceneFeatureArray.mat');
m069Array = load('Terminator2_HospitalFightFeatureArray.mat');
m070Array = load('Terminator2_TerminatorEncounterFeatureArray.mat');
m071Array = load('IndianTerminator_BestSceneFeatureArray.mat');
m072Array = load('Terminator3_SkynetTakesOverFeatureArray.mat');
m073Array = load('Terminator3_FinalSceneFeatureArray.mat');
m074Array = load('TopGun_MaverickVsJesterFeatureArray.mat');
m075Array = load('TopGun_DogFightSceneFeatureArray.mat');
m076Array = load('Bloodsport_FinalSceneFeatureArray.mat');
m077Array = load('Bloodsport_BeginningFightSceneFeatureArray.mat');
m078Array = load('Bloodsport_TrainingFeatureArray.mat');
m079Array = load('Bloodsport2_FinalFightFeatureArray.mat');
m080Array = load('KarateKid_SandTheFloorFeatureArray.mat');
m081Array = load('KarateKid2_FinalSceneFeatureArray.mat');
m082Array = load('KungFuPanda2_BoatSceneFeatureArray.mat');
m083Array = load('KungFuPanda_FreeToEatFeatureArray.mat');
m084Array = load('KungFuPanda2_PosChildhoodFeatureArray.mat');
m085Array = load('KungFuPanda_TaiLungEscapeFeatureArray.mat');
m086Array = load('KungFuPand2_FinalBattleFeatureArray.mat');
m087Array = load('KungFuPanda2_TowerBattleFeatureArray.mat');
m088Array = load('TheAvengers_FinalBattleFeatureArray.mat');
m089Array = load('IronMan_TerroristFightFeatureArray.mat');
m090Array = load('IronMan2_MonacoFightFeatureArray.mat');
m091Array = load('IronMan3_FinalSceneFeatureArray.mat');
m092Array = load('IronMan2_FinalSceneFeatureArray.mat');
m093Array = load('TheMatrix_LobbySceneFeatureArray.mat');
m094Array = load('TheMatrix_PillSceneFeatureArray.mat');
m095Array = load('TheMatrix_FirstFightFeatureArray.mat');
m096Array = load('TheMatrix_NeoVsMorpheusFeatureArray.mat');
m097Array = load('TheMatrix_MorpheusRescueFeatureArray.mat');
m098Array = load('TheMatrixReloaded_HighwayFightFeatureArray.mat');
m099Array = load('TheMatrixReloaded_ChateauFightFeatureArray.mat');
m100Array = load('TheMatrixReloaded_NeoVsSmithsFeatureArray.mat');
m101Array = load('TheMatrixReloaded_CausalityFeatureArray.mat');
m102Array = load('TheMatrixRevolutions_FinalSceneFeatureArray.mat');
m103Array = load('TheMatrixRevolutions_BigFightFeatureArray.mat');
m104Array = load('TheMatrixRevolutions_SmithMeetsOracleFeatureArray.mat');
m105Array = load('TheMatrix_BigMachineGunsFeatureArray.mat');
m106Array = load('IndianaJones_OpeningTheArkFeatureArray.mat');
m107Array = load('JurassicPark_LunchFeatureArray.mat');
m108Array = load('JurassicPark_RaptorsInTheKitchenFeatureArray.mat');
m109Array = load('JurassicPark2_DowntownRampageFeatureArray.mat');
m110Array = load('VForVendetta_TheDominoesFallFeatureArray.mat');
m111Array = load('VForVendetta_FinalFightFeatureArray.mat');
m112Array = load('VForVendetta_EveyRebornFeatureArray.mat');
m113Array = load('IRobot_InterrogationFeatureArray.mat');
m114Array = load('SpiderMan_GreenGoblinFightFeatureArray.mat');
m115Array = load('CrouchingTiger_RooftopSceneFeatureArray.mat');
m116Array = load('Oldboy_HallwayFightFeatureArray.mat');
m117Array = load('KillBill_GogoFightFeatureArray.mat');
m118Array = load('IpMan_FightScene2FeatureArray.mat');
m119Array = load('IpMan_CottonMillFightFeatureArray.mat');
m120Array = load('IpMan_FinalFightFeatureArray.mat');
m121Array = load('Rocky_FinalFightFeatureArray.mat');
m122Array = load('EnterTheDragon_FinalFightFeatureArray.mat');
m123Array = load('XMen_FightSceneFeatureArray.mat');
m124Array = load('XMen_FirstClass_FireFeatureArray.mat');
m125Array = load('POTC2_WaterfallSceneFeatureArray.mat');
m126Array = load('BookOfEli_BarFightFeatureArray.mat');
m127Array = load('TheExpendables2_FinalSceneFeatureArray.mat');
m128Array = load('TheExpendables_FinalSceneFeatureArray.mat');
m129Array = load('DieHard2_FightSceneFeatureArray.mat');
m130Array = load('CrouchingTiger_ForestSceneFeatureArray.mat');
m131Array = load('RockyIV_HesCutFeatureArray.mat');
m132Array = load('RockyVI_FinalFightFeatureArray.mat');
m133Array = load('RockyIII_FinalSceneFeatureArray.mat');
m134Array = load('RockyII_FinalRoundFeatureArray.mat');
m135Array = load('RockyV_FinalFightFeatureArray.mat');
m136Array = load('StarWarsEpV_IAmYourFatherFeatureArray.mat');
m137Array = load('StarWarsEpVI_FinalBattleFeatureArray.mat');
m138Array = load('Transformers1_BaseAttackFeatureArray.mat');
%%m139Array = load('KnockedUp_BeardJokesFeatureArray.mat');
ndArray= load('NoDataFeatureArray.mat');

% Set the training samples
training_samples = [pmArray.featureArray; fmArray.featureArray; dxArray.featureArray; jpArray.featureArray; m001Array.featureArray; m002Array.featureArray;...
    m003Array.featureArray; m004Array.featureArray; m005Array.featureArray;  m007Array.featureArray; m008Array.featureArray; ...
    m009Array.featureArray; m010Array.featureArray; m011Array.featureArray; m012Array.featureArray; m013Array.featureArray; m014Array.featureArray; ...
    m015Array.featureArray; m016Array.featureArray; m017Array.featureArray; m018Array.featureArray; m019Array.featureArray; m020Array.featureArray; ...
    m021Array.featureArray; m022Array.featureArray; m023Array.featureArray; m024Array.featureArray; m025Array.featureArray; m026Array.featureArray; ...
    m027Array.featureArray; m028Array.featureArray; m029Array.featureArray; m030Array.featureArray; m031Array.featureArray; m032Array.featureArray; ...
    m033Array.featureArray; m034Array.featureArray; m035Array.featureArray; m036Array.featureArray; m037Array.featureArray; m038Array.featureArray; ...
    m039Array.featureArray; m040Array.featureArray; m041Array.featureArray; m042Array.featureArray; m043Array.featureArray; m044Array.featureArray; ...
    m045Array.featureArray; m046Array.featureArray; m047Array.featureArray; m048Array.featureArray; m049Array.featureArray; m050Array.featureArray; ...
    m051Array.featureArray; m052Array.featureArray; m053Array.featureArray; m054Array.featureArray; m055Array.featureArray; m056Array.featureArray; ...
    m057Array.featureArray; m058Array.featureArray; m059Array.featureArray; m060Array.featureArray; m061Array.featureArray; m062Array.featureArray; ...
    m063Array.featureArray; m064Array.featureArray; m065Array.featureArray; m066Array.featureArray; m067Array.featureArray; m068Array.featureArray; ...
    m069Array.featureArray; m070Array.featureArray; m071Array.featureArray; m072Array.featureArray; m073Array.featureArray; m074Array.featureArray; ...
    m075Array.featureArray; m076Array.featureArray; m077Array.featureArray; m078Array.featureArray; m079Array.featureArray; m080Array.featureArray; ...
    m081Array.featureArray; m082Array.featureArray; m083Array.featureArray; m084Array.featureArray; m085Array.featureArray; m086Array.featureArray; ...
    m087Array.featureArray; m088Array.featureArray; m089Array.featureArray; m090Array.featureArray; m091Array.featureArray; m092Array.featureArray; ...
    m093Array.featureArray; m094Array.featureArray; m095Array.featureArray; m096Array.featureArray; m097Array.featureArray; m098Array.featureArray; ...
    m099Array.featureArray; m100Array.featureArray; m101Array.featureArray; m102Array.featureArray; m103Array.featureArray; m104Array.featureArray; ...
    m105Array.featureArray; m106Array.featureArray; m107Array.featureArray; m108Array.featureArray; m109Array.featureArray; m110Array.featureArray; ...
    m111Array.featureArray; m112Array.featureArray; m113Array.featureArray; m114Array.featureArray; m115Array.featureArray; m116Array.featureArray;  ...
    m117Array.featureArray; m118Array.featureArray; m119Array.featureArray; m120Array.featureArray; m121Array.featureArray; m122Array.featureArray; ...
    m123Array.featureArray; m124Array.featureArray; m125Array.featureArray; m126Array.featureArray; m127Array.featureArray; m128Array.featureArray; ...
    m129Array.featureArray; m130Array.featureArray; m131Array.featureArray; m132Array.featureArray; m133Array.featureArray; m134Array.featureArray; ...
    m135Array.featureArray; m136Array.featureArray; m137Array.featureArray; m138Array.featureArray; ndArray.featureArray];

% get the number of samples in each movie
pm_sample_number = size(pmArray.featureArray, 1);
fm_sample_number = size(fmArray.featureArray, 1);
dx_sample_number = size(dxArray.featureArray, 1);
jp_sample_number = size(jpArray.featureArray, 1);
m001_sample_number = size(m001Array.featureArray, 1);
m002_sample_number = size(m002Array.featureArray, 1);
m003_sample_number = size(m003Array.featureArray, 1);
m004_sample_number = size(m004Array.featureArray, 1);
m005_sample_number = size(m005Array.featureArray, 1);
%%m006_sample_number = size(m006Array.featureArray, 1);
m007_sample_number = size(m007Array.featureArray, 1);
m008_sample_number = size(m008Array.featureArray, 1);
m009_sample_number = size(m009Array.featureArray, 1);
m010_sample_number = size(m010Array.featureArray, 1);
m011_sample_number = size(m011Array.featureArray, 1);
m012_sample_number = size(m012Array.featureArray, 1);
m013_sample_number = size(m013Array.featureArray, 1);
m014_sample_number = size(m014Array.featureArray, 1);
m015_sample_number = size(m015Array.featureArray, 1);
m016_sample_number = size(m016Array.featureArray, 1);
m017_sample_number = size(m017Array.featureArray, 1);
m018_sample_number = size(m018Array.featureArray, 1);
m019_sample_number = size(m019Array.featureArray, 1);
m020_sample_number = size(m020Array.featureArray, 1);
m021_sample_number = size(m021Array.featureArray, 1);
m022_sample_number = size(m022Array.featureArray, 1);
m023_sample_number = size(m023Array.featureArray, 1);
m024_sample_number = size(m024Array.featureArray, 1);
m025_sample_number = size(m025Array.featureArray, 1);
m026_sample_number = size(m026Array.featureArray, 1);
m027_sample_number = size(m027Array.featureArray, 1);
m028_sample_number = size(m028Array.featureArray, 1);
m029_sample_number = size(m029Array.featureArray, 1);
m030_sample_number = size(m030Array.featureArray, 1);
m031_sample_number = size(m031Array.featureArray, 1);
m032_sample_number = size(m032Array.featureArray, 1);
m033_sample_number = size(m033Array.featureArray, 1);
m034_sample_number = size(m034Array.featureArray, 1);
m035_sample_number = size(m035Array.featureArray, 1);
m036_sample_number = size(m036Array.featureArray, 1);
m037_sample_number = size(m037Array.featureArray, 1);
m038_sample_number = size(m038Array.featureArray, 1);
m039_sample_number = size(m039Array.featureArray, 1);
m040_sample_number = size(m040Array.featureArray, 1);
m041_sample_number = size(m041Array.featureArray, 1);
m042_sample_number = size(m042Array.featureArray, 1);
m043_sample_number = size(m043Array.featureArray, 1);
m044_sample_number = size(m044Array.featureArray, 1);
m045_sample_number = size(m045Array.featureArray, 1);
m046_sample_number = size(m046Array.featureArray, 1);
m047_sample_number = size(m047Array.featureArray, 1);
m048_sample_number = size(m048Array.featureArray, 1);
m049_sample_number = size(m049Array.featureArray, 1);
m050_sample_number = size(m050Array.featureArray, 1);
m051_sample_number = size(m051Array.featureArray, 1);
m052_sample_number = size(m052Array.featureArray, 1);
m053_sample_number = size(m053Array.featureArray, 1);
m054_sample_number = size(m054Array.featureArray, 1);
m055_sample_number = size(m055Array.featureArray, 1);
m056_sample_number = size(m056Array.featureArray, 1);
m057_sample_number = size(m057Array.featureArray, 1);
m058_sample_number = size(m058Array.featureArray, 1);
m059_sample_number = size(m059Array.featureArray, 1);
m060_sample_number = size(m060Array.featureArray, 1);
m061_sample_number = size(m061Array.featureArray, 1);
m062_sample_number = size(m062Array.featureArray, 1);
m063_sample_number = size(m063Array.featureArray, 1);
m064_sample_number = size(m064Array.featureArray, 1);
m065_sample_number = size(m065Array.featureArray, 1);
m066_sample_number = size(m066Array.featureArray, 1);
m067_sample_number = size(m067Array.featureArray, 1);
m068_sample_number = size(m068Array.featureArray, 1);
m069_sample_number = size(m069Array.featureArray, 1);
m070_sample_number = size(m070Array.featureArray, 1);
m071_sample_number = size(m071Array.featureArray, 1);
m072_sample_number = size(m072Array.featureArray, 1);
m073_sample_number = size(m073Array.featureArray, 1);
m074_sample_number = size(m074Array.featureArray, 1);
m075_sample_number = size(m075Array.featureArray, 1);
m076_sample_number = size(m076Array.featureArray, 1);
m077_sample_number = size(m077Array.featureArray, 1);
m078_sample_number = size(m078Array.featureArray, 1);
m079_sample_number = size(m079Array.featureArray, 1);
m080_sample_number = size(m080Array.featureArray, 1);
m081_sample_number = size(m081Array.featureArray, 1);
m082_sample_number = size(m082Array.featureArray, 1);
m083_sample_number = size(m083Array.featureArray, 1);
m084_sample_number = size(m084Array.featureArray, 1);
m085_sample_number = size(m085Array.featureArray, 1);
m086_sample_number = size(m086Array.featureArray, 1);
m087_sample_number = size(m087Array.featureArray, 1);
m088_sample_number = size(m088Array.featureArray, 1);
m089_sample_number = size(m089Array.featureArray, 1);
m090_sample_number = size(m090Array.featureArray, 1);
m091_sample_number = size(m091Array.featureArray, 1);
m092_sample_number = size(m092Array.featureArray, 1);
m093_sample_number = size(m093Array.featureArray, 1);
m094_sample_number = size(m094Array.featureArray, 1);
m095_sample_number = size(m095Array.featureArray, 1);
m096_sample_number = size(m096Array.featureArray, 1);
m097_sample_number = size(m097Array.featureArray, 1);
m098_sample_number = size(m098Array.featureArray, 1);
m099_sample_number = size(m099Array.featureArray, 1);
m100_sample_number = size(m100Array.featureArray, 1);
m101_sample_number = size(m101Array.featureArray, 1);
m102_sample_number = size(m102Array.featureArray, 1);
m103_sample_number = size(m103Array.featureArray, 1);
m104_sample_number = size(m104Array.featureArray, 1);
m105_sample_number = size(m105Array.featureArray, 1);
m106_sample_number = size(m106Array.featureArray, 1);
m107_sample_number = size(m107Array.featureArray, 1);
m108_sample_number = size(m108Array.featureArray, 1);
m109_sample_number = size(m109Array.featureArray, 1);
m110_sample_number = size(m110Array.featureArray, 1);
m111_sample_number = size(m111Array.featureArray, 1);
m112_sample_number = size(m112Array.featureArray, 1);
m113_sample_number = size(m113Array.featureArray, 1);
m114_sample_number = size(m114Array.featureArray, 1);
m115_sample_number = size(m115Array.featureArray, 1);
m116_sample_number = size(m116Array.featureArray, 1);
m117_sample_number = size(m117Array.featureArray, 1);
m118_sample_number = size(m118Array.featureArray, 1);
m119_sample_number = size(m119Array.featureArray, 1);
m120_sample_number = size(m120Array.featureArray, 1);
m121_sample_number = size(m121Array.featureArray, 1);
m122_sample_number = size(m122Array.featureArray, 1);
m123_sample_number = size(m123Array.featureArray, 1);
m124_sample_number = size(m124Array.featureArray, 1);
m125_sample_number = size(m125Array.featureArray, 1);
m126_sample_number = size(m126Array.featureArray, 1);
m127_sample_number = size(m127Array.featureArray, 1);
m128_sample_number = size(m128Array.featureArray, 1);
m129_sample_number = size(m129Array.featureArray, 1);
m130_sample_number = size(m130Array.featureArray, 1);
m131_sample_number = size(m131Array.featureArray, 1);
m132_sample_number = size(m132Array.featureArray, 1);
m133_sample_number = size(m133Array.featureArray, 1);
m134_sample_number = size(m134Array.featureArray, 1);
m135_sample_number = size(m135Array.featureArray, 1);
m136_sample_number = size(m136Array.featureArray, 1);
m137_sample_number = size(m137Array.featureArray, 1);
m138_sample_number = size(m138Array.featureArray, 1);
%%m139_sample_number = size(m139Array.featureArray, 1);
nd_sample_number = size(ndArray.featureArray, 1);


% Get total number of samples and features
sample_number_num = size(training_samples, 1);
feature_num = size(training_samples, 2);
% classes
pm_training_labels = ones(pm_sample_number,1);
fm_training_labels = ones(fm_sample_number,1)*2;
dx_training_labels = ones(dx_sample_number,1)*3;
jp_training_labels = ones(jp_sample_number,1)*4;
m001_training_labels = ones(m001_sample_number,1)*5;
m002_training_labels = ones(m002_sample_number,1)*6;
m003_training_labels = ones(m003_sample_number,1)*7;
m004_training_labels = ones(m004_sample_number,1)*8;
m005_training_labels = ones(m005_sample_number,1)*9;
%%m006_training_labels = ones(m006_sample_number,1)*10;
m007_training_labels = ones(m007_sample_number,1)*11;
m008_training_labels = ones(m008_sample_number,1)*12;
m009_training_labels = ones(m009_sample_number,1)*13;
m010_training_labels = ones(m010_sample_number,1)*14;
m011_training_labels = ones(m011_sample_number,1)*15;
m012_training_labels = ones(m012_sample_number,1)*16;
m013_training_labels = ones(m013_sample_number,1)*17;
m014_training_labels = ones(m014_sample_number,1)*18;
m015_training_labels = ones(m015_sample_number,1)*19;
m016_training_labels = ones(m016_sample_number,1)*20;
m017_training_labels = ones(m017_sample_number,1)*21;
m018_training_labels = ones(m018_sample_number,1)*22;
m019_training_labels = ones(m019_sample_number,1)*23;
m020_training_labels = ones(m020_sample_number,1)*24;
m021_training_labels = ones(m021_sample_number,1)*25;
m022_training_labels = ones(m022_sample_number,1)*26;
m023_training_labels = ones(m023_sample_number,1)*27;
m024_training_labels = ones(m024_sample_number,1)*28;
m025_training_labels = ones(m025_sample_number,1)*29;
m026_training_labels = ones(m026_sample_number,1)*30;
m027_training_labels = ones(m027_sample_number,1)*31;
m028_training_labels = ones(m028_sample_number,1)*32;
m029_training_labels = ones(m029_sample_number,1)*33;
m030_training_labels = ones(m030_sample_number,1)*34;
m031_training_labels = ones(m031_sample_number,1)*35;
m032_training_labels = ones(m032_sample_number,1)*36;
m033_training_labels = ones(m033_sample_number,1)*37;
m034_training_labels = ones(m034_sample_number,1)*38;
m035_training_labels = ones(m035_sample_number,1)*39;
m036_training_labels = ones(m036_sample_number,1)*40;
m037_training_labels = ones(m037_sample_number,1)*41;
m038_training_labels = ones(m038_sample_number,1)*42;
m039_training_labels = ones(m039_sample_number,1)*43;
m040_training_labels = ones(m040_sample_number,1)*44;
m041_training_labels = ones(m041_sample_number,1)*45;
m042_training_labels = ones(m042_sample_number,1)*46;
m043_training_labels = ones(m043_sample_number,1)*47;
m044_training_labels = ones(m044_sample_number,1)*48;
m045_training_labels = ones(m045_sample_number,1)*49;
m046_training_labels = ones(m046_sample_number,1)*50;
m047_training_labels = ones(m047_sample_number,1)*51;
m048_training_labels = ones(m048_sample_number,1)*52;
m049_training_labels = ones(m049_sample_number,1)*53;
m050_training_labels = ones(m050_sample_number,1)*54;
m051_training_labels = ones(m051_sample_number,1)*55;
m052_training_labels = ones(m052_sample_number,1)*56;
m053_training_labels = ones(m053_sample_number,1)*57;
m054_training_labels = ones(m054_sample_number,1)*58;
m055_training_labels = ones(m055_sample_number,1)*59;
m056_training_labels = ones(m056_sample_number,1)*60;
m057_training_labels = ones(m057_sample_number,1)*61;
m058_training_labels = ones(m058_sample_number,1)*62;
m059_training_labels = ones(m059_sample_number,1)*63;
m060_training_labels = ones(m060_sample_number,1)*64;
m061_training_labels = ones(m061_sample_number,1)*65;
m062_training_labels = ones(m062_sample_number,1)*66;
m063_training_labels = ones(m063_sample_number,1)*67;
m064_training_labels = ones(m064_sample_number,1)*68;
m065_training_labels = ones(m065_sample_number,1)*69;
m066_training_labels = ones(m066_sample_number,1)*70;
m067_training_labels = ones(m067_sample_number,1)*71;
m068_training_labels = ones(m068_sample_number,1)*72;
m069_training_labels = ones(m069_sample_number,1)*73;
m070_training_labels = ones(m070_sample_number,1)*74;
m071_training_labels = ones(m071_sample_number,1)*75;
m072_training_labels = ones(m072_sample_number,1)*76;
m073_training_labels = ones(m073_sample_number,1)*77;
m074_training_labels = ones(m074_sample_number,1)*78;
m075_training_labels = ones(m075_sample_number,1)*79;
m076_training_labels = ones(m076_sample_number,1)*80;
m077_training_labels = ones(m077_sample_number,1)*81;
m078_training_labels = ones(m078_sample_number,1)*82;
m079_training_labels = ones(m079_sample_number,1)*83;
m080_training_labels = ones(m080_sample_number,1)*84;
m081_training_labels = ones(m081_sample_number,1)*85;
m082_training_labels = ones(m082_sample_number,1)*86;
m083_training_labels = ones(m083_sample_number,1)*87;
m084_training_labels = ones(m084_sample_number,1)*88;
m085_training_labels = ones(m085_sample_number,1)*89;
m086_training_labels = ones(m086_sample_number,1)*90;
m087_training_labels = ones(m087_sample_number,1)*91;
m088_training_labels = ones(m088_sample_number,1)*92;
m089_training_labels = ones(m089_sample_number,1)*93;
m090_training_labels = ones(m090_sample_number,1)*94;
m091_training_labels = ones(m091_sample_number,1)*95;
m092_training_labels = ones(m092_sample_number,1)*96;
m093_training_labels = ones(m093_sample_number,1)*97;
m094_training_labels = ones(m094_sample_number,1)*98;
m095_training_labels = ones(m095_sample_number,1)*99;
m096_training_labels = ones(m096_sample_number,1)*100;
m097_training_labels = ones(m097_sample_number,1)*101;
m098_training_labels = ones(m098_sample_number,1)*102;
m099_training_labels = ones(m099_sample_number,1)*103;
m100_training_labels = ones(m100_sample_number,1)*104;
m101_training_labels = ones(m101_sample_number,1)*105;
m102_training_labels = ones(m102_sample_number,1)*106;
m103_training_labels = ones(m103_sample_number,1)*107;
m104_training_labels = ones(m104_sample_number,1)*108;
m105_training_labels = ones(m105_sample_number,1)*109;
m106_training_labels = ones(m106_sample_number,1)*110;
m107_training_labels = ones(m107_sample_number,1)*111;
m108_training_labels = ones(m108_sample_number,1)*112;
m109_training_labels = ones(m109_sample_number,1)*113;
m110_training_labels = ones(m110_sample_number,1)*114;
m111_training_labels = ones(m111_sample_number,1)*115;
m112_training_labels = ones(m112_sample_number,1)*116;
m113_training_labels = ones(m113_sample_number,1)*117;
m114_training_labels = ones(m114_sample_number,1)*118;
m115_training_labels = ones(m115_sample_number,1)*119;
m116_training_labels = ones(m116_sample_number,1)*120;
m117_training_labels = ones(m117_sample_number,1)*121;
m118_training_labels = ones(m118_sample_number,1)*122;
m119_training_labels = ones(m119_sample_number,1)*123;
m120_training_labels = ones(m120_sample_number,1)*124;
m121_training_labels = ones(m121_sample_number,1)*125;
m122_training_labels = ones(m122_sample_number,1)*126;
m123_training_labels = ones(m123_sample_number,1)*127;
m124_training_labels = ones(m124_sample_number,1)*128;
m125_training_labels = ones(m125_sample_number,1)*129;
m126_training_labels = ones(m126_sample_number,1)*130;
m127_training_labels = ones(m127_sample_number,1)*131;
m128_training_labels = ones(m128_sample_number,1)*132;
m129_training_labels = ones(m129_sample_number,1)*133;
m130_training_labels = ones(m130_sample_number,1)*134;
m131_training_labels = ones(m131_sample_number,1)*135;
m132_training_labels = ones(m132_sample_number,1)*136;
m133_training_labels = ones(m133_sample_number,1)*137;
m134_training_labels = ones(m134_sample_number,1)*138;
m135_training_labels = ones(m135_sample_number,1)*139;
m136_training_labels = ones(m136_sample_number,1)*140;
m137_training_labels = ones(m137_sample_number,1)*141;
m138_training_labels = ones(m138_sample_number,1)*142;
%%m139_training_labels = ones(m139_sample_number,1)*143;
nd_training_labels = ones(nd_sample_number,1)*143;



training_labels = [pm_training_labels; fm_training_labels; dx_training_labels; jp_training_labels; m001_training_labels; m002_training_labels; ...
    m003_training_labels; m004_training_labels; m005_training_labels; m007_training_labels; m008_training_labels; ...
    m009_training_labels; m010_training_labels; m011_training_labels; m012_training_labels; m013_training_labels; m014_training_labels; ...
    m015_training_labels; m016_training_labels; m017_training_labels; m018_training_labels; m019_training_labels; m020_training_labels; ...
    m021_training_labels; m022_training_labels; m023_training_labels; m024_training_labels; m025_training_labels; m026_training_labels; ...
    m027_training_labels; m028_training_labels; m029_training_labels; m030_training_labels; m031_training_labels; m032_training_labels; ...
    m033_training_labels; m034_training_labels; m035_training_labels; m036_training_labels; m037_training_labels; m038_training_labels; ...
    m039_training_labels; m040_training_labels; m041_training_labels; m042_training_labels; m043_training_labels; m044_training_labels; ...
    m045_training_labels; m046_training_labels; m047_training_labels; m048_training_labels; m049_training_labels; m050_training_labels; ...
    m051_training_labels; m052_training_labels; m053_training_labels; m054_training_labels; m055_training_labels; m056_training_labels; ...
    m057_training_labels; m058_training_labels; m059_training_labels; m060_training_labels; m061_training_labels; m062_training_labels; ...
    m063_training_labels; m064_training_labels; m065_training_labels; m066_training_labels; m067_training_labels; m068_training_labels; ...
    m069_training_labels; m070_training_labels; m071_training_labels; m072_training_labels; m073_training_labels; m074_training_labels; ...
    m075_training_labels; m076_training_labels; m077_training_labels; m078_training_labels; m079_training_labels; m080_training_labels; ...
    m081_training_labels; m082_training_labels; m083_training_labels; m084_training_labels; m085_training_labels; m086_training_labels; ...
    m087_training_labels; m088_training_labels; m089_training_labels; m090_training_labels; m091_training_labels; m092_training_labels; ...
    m093_training_labels; m094_training_labels; m095_training_labels; m096_training_labels; m097_training_labels; m098_training_labels; ...
    m099_training_labels; m100_training_labels; m101_training_labels; m102_training_labels; m103_training_labels; m104_training_labels; ...
    m105_training_labels; m106_training_labels; m107_training_labels; m108_training_labels; m109_training_labels; m110_training_labels; ...
    m111_training_labels; m112_training_labels; m113_training_labels; m114_training_labels; m115_training_labels; m116_training_labels;  ...
    m117_training_labels; m118_training_labels; m119_training_labels; m120_training_labels; m121_training_labels; m122_training_labels; ...
    m123_training_labels; m124_training_labels; m125_training_labels; m126_training_labels; m127_training_labels; m128_training_labels; ...
    m129_training_labels; m130_training_labels; m131_training_labels; m132_training_labels; m133_training_labels; m134_training_labels; ...
    m135_training_labels; m136_training_labels; m137_training_labels; m138_training_labels; nd_training_labels];

% Random variation to the data
%random = rand(size(training_samples,1),size(training_samples,2))*(0.06) - 0.03;
perturbation = 0.3*training_samples;
training_samples = training_samples + perturbation;

% scale the training data as suggested by LIBSVM authors; also save it
%training_samples_scaled = (training_samples - repmat(min(training_samples,[],1),size(training_samples,1),1))*spdiags(1./(max(training_samples,[],1)-min(training_samples,[],1))',0,size(training_samples,2),size(training_samples,2));
training_samples_scaled = training_samples;
training_samples_scaled_str = 'Final_Samples_Scaled';
save(training_samples_scaled_str, 'training_samples_scaled');  

% open the libsvm format file
libsvm_info_str = 'Final_libsvm_testing_data_03.txt';
%libsvm_info_str = 'Final_libsvm_test_scaled.txt';

write_libsvm_file_flag = false;
if(write_libsvm_file_flag)
    fp1 = fopen(libsvm_info_str,'w');

    for j = 1:sample_number_num
        % write the class of the sample (1 or -1)
        fprintf(fp1, '%s', ([num2str(training_labels(j)), ' ']));
        for i = 1:feature_num-1
            % write the sample in the format of "feature number:sample value"
            % for the first (num_features -1) features because only those have
            % a space character
            fprintf(fp1, '%s', ([num2str(i), ':', num2str(training_samples_scaled(j,i)), ' ']));
        end
            % write the last one after the loop because there is no space char
            % at the end of it
            fprintf(fp1, '%s', ([num2str(feature_num), ':', num2str(training_samples_scaled(j,feature_num))]));

        fprintf(fp1, '\n');
    end

    fclose(fp1);
end

%copyfile(([pwd,'/',libsvm_info_str]), ([pwd, '/tools']));

%display('Please run grid.py to get parameters')
%r = input('What is the regularization parameter?');
%gam = input('What is the kernel coefficient?');
    
[label_vector, instance_matrix] = libsvmread(libsvm_info_str);
gamma = 8192;
%model = svmtrain2(label_vector, instance_matrix, (['-s 0 -t 2 -g ', num2str(gam), ' -r ', num2str(r)]));
model = svmtrain2(label_vector, instance_matrix, (['-s 0 -t 2 -c 8192 -g ', num2str(gamma)]));
%model.feature_weights = model.SVs' * model.sv_coef;
%[model.feature_weights_sort, model.feature_weights_idx] = sort(abs(model.feature_weights), 1, 'descend');
%plot(weights_sort, 'bo-');

libsvm_model_name_str = (['final_libsvm_model_scaled_', num2str(gamma)]);

save(libsvm_model_name_str, 'model');



