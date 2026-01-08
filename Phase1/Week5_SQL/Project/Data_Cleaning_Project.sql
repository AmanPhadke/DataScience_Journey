-- Cleaning Data in SQL Queries



SELECT *
FROM PortfolioProject..Housing_Data
--------------------------------------------------------------------------------

-- Starndardize Date Format


SELECT SaleDate, CONVERT(Date,SaleDate)
FROM PortfolioProject..Housing_Data

UPDATE Housing_Data
SET SaleDate = CONVERT(Date,SaleDate)




---------------------------------------------------------------------------------

--Populate Property Address Data


SELECT *
FROM PortfolioProject..Housing_Data
--WHERE PropertyAddress IS NULL
ORDER BY ParcelID


SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM PortfolioProject..Housing_Data AS a 
JOIN PortfolioProject..Housing_Data AS b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID] <> b.[UniqueID]
WHERE a.PropertyAddress IS NULL

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM PortfolioProject..Housing_Data AS a
JOIN PortfolioProject..Housing_Data AS b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID] <> b.[UniqueID]
WHERE a.PropertyAddress IS NULL
 


---------------------------------------------------------------------------------

--Breaking out Address into Individual Columns

--INTO TWO COLUMNS 

SELECT *
FROM PortfolioProject..Housing_Data
--WHERE PropertyAddress IS NULL
--ORDER BY ParcelID

SELECT 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1) AS Address
, SUBSTRING(PropertyAddress,  CHARINDEX(',', PropertyAddress) + 1,  LEN(PropertyAddress)) AS Address


FROM PortfolioProject..Housing_Data


ALTER TABLE Housing_Data
ADD PropertySplitAddress Nvarchar(255)

UPDATE Housing_Data
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1) 


ALTER TABLE Housing_Data
ADD PropertySplitCity Nvarchar(255)

UPDATE Housing_Data
SET PropertySplitCity =  SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress))



---------------------------------------------------------------------------------

-- INTO THREE COLUMNS

SELECT *
FROM PortfolioProject..Housing_Data

ALTER TABLE Housing_Data
ADD OwnerSplitAddress Nvarchar(255)

UPDATE Housing_Data
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)


ALTER TABLE Housing_Data
ADD OwnerSplitCity Nvarchar(255)

UPDATE Housing_Data
SET OwnerSplitCity =  PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)


ALTER TABLE Housing_Data
ADD OwnerSplitState Nvarchar(255)

UPDATE Housing_Data
SET OwnerSplitState =  PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)


---------------------------------------------------------------------------------

-- Change 1 and 0 to Yes and No in 'Sold as Vacant' field

SELECT DISTINCT SoldAsVacant, COUNT(SoldAsVacant)
FROM PortfolioProject..Housing_Data
GROUP BY SoldAsVacant



SELECT *
FROM PortfolioProject..Housing_Data

UPDATE Housing_Data
SET SoldAsVacant = 
	CASE WHEN SoldAsVacant = 1 THEN 'Yes'
		 WHEN SoldAsVacant = 0 THEN 'No'
		 ELSE SoldAsVacant
END


---------------------------------------------------------------------------------

--Remove Duplicates

WITH RowNumCTE AS(
SELECT *,
	ROW_NUMBER() OVER(
		PARTITION BY ParcelID,
					 PropertyAddress,
					 SalePrice,
					 SaleDate,
					 LegalReference
					 ORDER BY 
						UniqueID
					 ) rowNum
FROM PortfolioProject..Housing_Data

)

SELECT *
FROM RowNumCTE
WHERE rowNum > 1
--ORDER BY PropertyAddress


---------------------------------------------------------------------------------

--Delete Unused Columns

SELECT *
FROM PortfolioProject..Housing_Data


ALTER TABLE PortfolioProject..Housing_Data
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress

ALTER TABLE PortfolioProject..Housing_Data
DROP COLUMN SaleDate
