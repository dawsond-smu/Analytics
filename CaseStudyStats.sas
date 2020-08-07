proc import datafile = '/folders/myfolders/SASInput.csv'
 out = work.Train
 dbms = CSV replace
 ;
run;
proc import datafile = '/folders/myfolders/SASOutput.csv'
 out = work.Test
 dbms = CSV
 ;
run;
DATA TEST_Log;
SET TEST;
LogSalePrice = .;
run;
DATA TRAIN;
SET TRAIN (DROP = GRLIVAREA);
LIVING = ROUND(LIVING,100);
RUN;
PROC SQL;CREATE TABLE NEIGHBORHOODS AS SELECT DISTINCT NEIGHBORHOOD FROM TRAIN;QUIT;
DATA AMES_IOWA;
SET TRAIN
(WHERE=(INDEX(NEIGHBORHOOD,'AMES') > 0 OR INDEX(NEIGHBORHOOD,'IOWA') > 0));
RUN;
ods graphics on;
/*

Forward

*/
proc glmselect data=Train TESTDATA= work.TEST_Log plots=all;
	CLASS Alley	BldgType	BsmtCond	BsmtExposure	BsmtFinType1	BsmtFinType2	
	BsmtQual	CentralAir	Condition1	Condition2	Electrical	ExterCond	ExterQual	
	Exterior1st	Exterior2nd	Fence	FireplaceQu	Foundation	Functional	GarageCond	
	GarageFinish	GarageQual	GarageType	Heating	HeatingQC	HouseStyle	KitchenQual	
	LandContour	LandSlope	LotConfig	LotFrontage	LotShape	MSZoning	MasVnrType	
	MiscFeature	Neighborhood	PavedDrive	PoolQC	RoofMatl	RoofStyle	SaleCondition
	SaleType	Street	Utilities
;
   model LogSalePrice = MSSubClass	MSZoning	LotFrontage	LotArea	Street	Alley	LotShape	
   LandContour	Utilities	LotConfig	LandSlope	Neighborhood	Condition1	Condition2	BldgType
   HouseStyle	OverallQual	OverallCond	YearBuilt	YearRemodAdd	RoofStyle	RoofMatl	Exterior1st
   Exterior2nd	MasVnrType	MasVnrArea	ExterQual	ExterCond	Foundation	BsmtQual	BsmtCond	
   BsmtExposure	BsmtFinType1	BsmtFinSF1	BsmtFinType2	BsmtFinSF2	BsmtUnfSF	TotalBsmtSF	
   Heating	HeatingQC	CentralAir	Electrical	_1stFlrSF	_2ndFlrSF	LowQualFinSF
   BsmtFullBath	BsmtHalfBath	FullBath	HalfBath	BedroomAbvGr	KitchenAbvGr	KitchenQual
   TotRmsAbvGrd	Functional	Fireplaces	FireplaceQu	GarageType	GarageYrBlt	GarageFinish	GarageCars
   GarageArea	GarageQual	GarageCond	PavedDrive	WoodDeckSF	OpenPorchSF	EnclosedPorch	_3SsnPorch
   ScreenPorch	PoolArea	PoolQC	Fence	MiscFeature	MiscVal	MoSold	YrSold	SaleType	SaleCondition
   Living	LogLiving
/ selection = Forward(select = ADJRSQ stop = CV SLE = .15) /*details=all stats=all*/;
run;
/*

Backward

*/
proc glmselect data=Train TESTDATA= work.TEST_Log plots=all;
	CLASS Alley	BldgType	BsmtCond	BsmtExposure	BsmtFinType1	BsmtFinType2	
	BsmtQual	CentralAir	Condition1	Condition2	Electrical	ExterCond	ExterQual	
	Exterior1st	Exterior2nd	Fence	FireplaceQu	Foundation	Functional	GarageCond	
	GarageFinish	GarageQual	GarageType	Heating	HeatingQC	HouseStyle	KitchenQual	
	LandContour	LandSlope	LotConfig	LotFrontage	LotShape	MSZoning	MasVnrType	
	MiscFeature	Neighborhood	PavedDrive	PoolQC	RoofMatl	RoofStyle	SaleCondition
	SaleType	Street	Utilities
;
   model LogSalePrice = MSSubClass	MSZoning	LotFrontage	LotArea	Street	Alley	LotShape	
   LandContour	Utilities	LotConfig	LandSlope	Neighborhood	Condition1	Condition2	BldgType
   HouseStyle	OverallQual	OverallCond	YearBuilt	YearRemodAdd	RoofStyle	RoofMatl	Exterior1st
   Exterior2nd	MasVnrType	MasVnrArea	ExterQual	ExterCond	Foundation	BsmtQual	BsmtCond	
   BsmtExposure	BsmtFinType1	BsmtFinSF1	BsmtFinType2	BsmtFinSF2	BsmtUnfSF	TotalBsmtSF	
   Heating	HeatingQC	CentralAir	Electrical	_1stFlrSF	_2ndFlrSF	LowQualFinSF	
   BsmtFullBath	BsmtHalfBath	FullBath	HalfBath	BedroomAbvGr	KitchenAbvGr	KitchenQual
   TotRmsAbvGrd	Functional	Fireplaces	FireplaceQu	GarageType	GarageYrBlt	GarageFinish	GarageCars
   GarageArea	GarageQual	GarageCond	PavedDrive	WoodDeckSF	OpenPorchSF	EnclosedPorch	_3SsnPorch
   ScreenPorch	PoolArea	PoolQC	Fence	MiscFeature	MiscVal	MoSold	YrSold	SaleType	SaleCondition
   Living	LogLiving
/ selection = Backward(select = ADJRSQ stop = CV CHOOSE = CV) /*details=all stats=all*/;
run;
/*

Stepwise

*/
proc glmselect data=Train TESTDATA= work.TEST_Log plots=all;
	CLASS Alley	BldgType	BsmtCond	BsmtExposure	BsmtFinType1	BsmtFinType2	
	BsmtQual	CentralAir	Condition1	Condition2	Electrical	ExterCond	ExterQual	
	Exterior1st	Exterior2nd	Fence	FireplaceQu	Foundation	Functional	GarageCond	
	GarageFinish	GarageQual	GarageType	Heating	HeatingQC	HouseStyle	KitchenQual	
	LandContour	LandSlope	LotConfig	LotFrontage	LotShape	MSZoning	MasVnrType	
	MiscFeature	Neighborhood	PavedDrive	PoolQC	RoofMatl	RoofStyle	SaleCondition
	SaleType	Street	Utilities
;
   model LogSalePrice = MSSubClass	MSZoning	LotFrontage	LotArea	Street	Alley	LotShape	
   LandContour	Utilities	LotConfig	LandSlope	Neighborhood	Condition1	Condition2	BldgType
   HouseStyle	OverallQual	OverallCond	YearBuilt	YearRemodAdd	RoofStyle	RoofMatl	Exterior1st
   Exterior2nd	MasVnrType	MasVnrArea	ExterQual	ExterCond	Foundation	BsmtQual	BsmtCond	
   BsmtExposure	BsmtFinType1	BsmtFinSF1	BsmtFinType2	BsmtFinSF2	BsmtUnfSF	TotalBsmtSF	
   Heating	HeatingQC	CentralAir	Electrical	_1stFlrSF	_2ndFlrSF	LowQualFinSF	
   BsmtFullBath	BsmtHalfBath	FullBath	HalfBath	BedroomAbvGr	KitchenAbvGr	KitchenQual
   TotRmsAbvGrd	Functional	Fireplaces	FireplaceQu	GarageType	GarageYrBlt	GarageFinish	GarageCars
   GarageArea	GarageQual	GarageCond	PavedDrive	WoodDeckSF	OpenPorchSF	EnclosedPorch	_3SsnPorch
   ScreenPorch	PoolArea	PoolQC	Fence	MiscFeature	MiscVal	MoSold	YrSold	SaleType	SaleCondition
   Living	LogLiving
/ selection = STEPWISE(select = ADJRSQ stop = CV slentry = .15 SLE = .15) /*details=all stats=all*/;
run;
/*

Custom Model

*/
proc glm data = Train PLOTS=all;
	CLASS Neighborhood MSZoning HouseStyle CentralAir GarageFinish SaleCondition 
	BsmtQual ExterQual KitchenQual LotFrontage BsmtFinType1;
   model LogSalePrice = LogLiving Neighborhood MSZoning
   		HouseStyle GarageArea  GarageCars OverallQual 
   		TotalBsmtSF CentralAir GarageFinish ExterQual SaleCondition KitchenQual BsmtQual BsmtFinType1 BsmtFinType1*TotalBsmtSF LotFrontage Neighborhood*LogLiving/ solution;
run;
ods graphics off;