
--CLEANING DATA IN SQL QUERIES

SELECT *
FROM PortfolioProject..NashvilleHousing

SELECT SaleDateConverted 
--CONVERT(Date,SaleDate) 
FROM PortfolioProject..NashvilleHousing



-- STANDARDIZE DATE FORMAT

SELECT SaleDate, CONVERT(Date,SaleDate) --THIS IS WHAT WE WANT IT TO LOOK LIKE
FROM PortfolioProject..NashvilleHousing

Update PortfolioProject..NashvilleHousing
set SaleDate = convert(Date,SaleDate) 


ALTER TABLE PortfolioProject..NashvilleHousing
add SaleDateConverted Date;


Update PortfolioProject..NashvilleHousing
set SaleDateConverted = convert(Date,SaleDate) 


--POPULATE PROPERTY ADDRESS DATA
-- IF THIS PERCELID HAS AN ADDRESS AND THIS(ANOTHER PERCELID WITH THE SAME NUMBER) DOES NOT HAVE AN ADDRESS, 
--LET'S POPULATE IT WITH THE ADDRESS THAT'S ALREADY POPULATED BECAUSE WE KNOW THIS ARE GOING TO BE THE SAME.

SELECT *
FROM PortfolioProject..NashvilleHousing
--where PropertyAddress is null
order by ParcelID


SELECT *
FROM PortfolioProject..NashvilleHousing a
join PortfolioProject..NashvilleHousing b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ]


SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM PortfolioProject..NashvilleHousing a
join PortfolioProject..NashvilleHousing b
	on a.ParcelID = b.ParcelID								----THIS IS EXACTLY WHAT I WANT TO SEE
	and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null


UPDATE a
set PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
from PortfolioProject..NashvilleHousing a
join PortfolioProject..NashvilleHousing b
	on a.ParcelID = b.ParcelID							
	and a.[UniqueID ] <> b.[UniqueID ]
	where a.PropertyAddress is null


	--BREAKING OUT ADDRESS INTO INDIVIDUAL COLUMNS (ADDRESS, CITY, STATE)
SELECT PropertyAddress
FROM PortfolioProject..NashvilleHousing
--where PropertyAddress is null
--order by ParcelID

select 
substring(PropertyAddress,1, charindex(',', PropertyAddress)) as address

from PortfolioProject..NashvilleHousing


select 
substring(PropertyAddress,1, charindex(',', PropertyAddress) -1) as address					-- THIS IS WHAT IT SHOULD LOOK LIKE (1)

from PortfolioProject..NashvilleHousing


select
substring(PropertyAddress, 1, charindex(',', PropertyAddress) -1) as address
, substring(PropertyAddress, charindex(',', PropertyAddress) + 1 , len(PropertyAddress)) as address			-- THIS IS WHAT IT SHOULD LOOK LIKE (2)

from PortfolioProject..NashvilleHousing



ALTER TABLE PortfolioProject..NashvilleHousing
add PropertySplitAddress Nvarchar (255);


Update PortfolioProject..NashvilleHousing
set PropertySplitAddress = substring(PropertyAddress, 1, charindex(',', PropertyAddress) -1)



ALTER TABLE PortfolioProject..NashvilleHousing
add PropertySplitCity Nvarchar (255);


Update PortfolioProject..NashvilleHousing
set PropertySplitCity =  substring(PropertyAddress, charindex(',', PropertyAddress) + 1 , len(PropertyAddress))




select
 PARSENAME(replace(OwnerAddress, ',', '.') ,1)		-- PARSENAME ARE ONLY USEFUL WITH PERIOD(.)
from PortfolioProject.dbo.NashvilleHousing			-- PARSENAME DOES THINGS BACKWARDS



select
PARSENAME(replace(owneraddress, ',', '.') , 3)			
,PARSENAME(replace(owneraddress, ',', '.') , 2)		
,PARSENAME(replace(owneraddress, ',', '.') , 1)			-- ANOTHER WAY YOU CAN DO IT
from PortfolioProject.dbo.NashvilleHousing

--(1)
ALTER TABLE PortfolioProject..NashvilleHousing
add ownerSplitAddress Nvarchar (255);


Update PortfolioProject..NashvilleHousing
set ownerSplitAddress = PARSENAME(replace(owneraddress, ',', '.') , 3)


--(2)
ALTER TABLE PortfolioProject..NashvilleHousing
add ownerSplitCity Nvarchar (255);


Update PortfolioProject..NashvilleHousing
set ownerSplitCity = PARSENAME(replace(owneraddress, ',', '.') , 2)

--(3)
ALTER TABLE PortfolioProject..NashvilleHousing
add ownerSplitState Nvarchar (255);


Update PortfolioProject..NashvilleHousing
set ownerSplitState = PARSENAME(replace(owneraddress, ',', '.') , 1)	


-- CHANGE Y AND N TO YES AND NO IN "SOLD AS VACANT" FIELD

SELECT Distinct(SoldAsVacant), COUNT(SoldAsVacant)
from PortfolioProject.dbo.NashvilleHousing
group by SoldAsVacant
order by 2



SELECT SoldAsVacant
, CASE when SoldAsVacant = 'Y' then 'Yes'
	   when SoldAsVacant = 'N' then 'No'
	   else SoldAsVacant
	   end
from PortfolioProject.dbo.NashvilleHousing


update PortfolioProject.dbo.NashvilleHousing
set SoldAsVacant = CASE when SoldAsVacant = 'Y' then 'Yes'
	   when SoldAsVacant = 'N' then 'No'
	   else SoldAsVacant
	   end





	   -- REMOVING DUPLICATES USING CTE, using row numbers and there are other ways

--select *,
--	ROW_NUMBER () OVER (
--	PARTITION BY ParcelID,
--			     PropertyAddress,						-- WE PARTITIONED IT ON THINGS THAT SHOULD BE UNIQUE TO EACH ROW
--				 SalePrice,
--				 SaleDate,
--				 LegalReference
--				 ORDER BY 
--				 UniqueID
--				 ) row_num

--from PortfolioProject.dbo.NashvilleHousing
--order by ParcelID


	WITH RowNumCTE AS (
select *,
	ROW_NUMBER () OVER (
	PARTITION BY ParcelID,
			     PropertyAddress,						
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY 
				 UniqueID
				 ) row_num

from PortfolioProject.dbo.NashvilleHousing
--order by ParcelID
)

SELECT * 
FROM RowNumCTE
WHERE row_num > 1
order by PropertyAddress

--WITH RowNumCTE AS (
--select *,
--	ROW_NUMBER () OVER (
--	PARTITION BY ParcelID,
--			     PropertyAddress,
--				 SalePrice,
--				 SaleDate,
--				 LegalReference								THIS IS THE FINAL QUERY TO DELETE DUPLICATES FROM OUR DATABASE(I DID NOT DELETE THEM)
--				 ORDER BY 
--				 UniqueID
--				 ) row_num

--from PortfolioProject.dbo.NashvilleHousing
----order by ParcelID
--)


--DELETE
--FROM RowNumCTE
--WHERE row_num > 1



SELECT *
from PortfolioProject.dbo.NashvilleHousing



--DELETE UNUSED COLUMNS

--SELECT *
--from PortfolioProject.dbo.NashvilleHousing
																		--- DID NOT DELETE THIS COLOUMN

--ALTER TABLE PortfolioProject.dbo.NashvilleHousing
--drop column OwnerAddress, TaxDistrict, PropertyAddress, SaleDate