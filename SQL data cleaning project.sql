select SaleDate, saledatecon from portfolioProjectsAlex.dbo.NashvilleHousing

update NashvilleHousing set SaleDate = CONVERT(date,saledate)

alter table nashvillehousing add saledatecon date;
update NashvilleHousing set saledatecon = CONVERT(date,saledate)

-----------------------------------------------------------------
select [UniqueID ], parcelid,propertyaddress  from NashvilleHousing
where ParcelID = ParcelID 

select a.uniqueid, a.parcelid, a.propertyaddress,b.uniqueid, b.parcelid, b.propertyaddress, isnull(a.propertyaddress,b.propertyaddress)
from NashvilleHousing a 
join NashvilleHousing b on a.ParcelID = b.ParcelID and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

update a set propertyaddress = isnull(a.propertyaddress,b.propertyaddress)
from NashvilleHousing a 
join NashvilleHousing b on a.ParcelID = b.ParcelID and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

select [UniqueID ],parcelid, propertyaddress from NashvilleHousing

----------------------------------------------------------------------------------------------------------------------------------
select propertyaddress, SUBSTRING(propertyaddress,1, CHARINDEX(',',PropertyAddress)-1) as address,
SUBSTRING(propertyaddress, CHARINDEX(',',PropertyAddress)+1, LEN(PropertyAddress)) as address
from NashvilleHousing

alter table nashvillehousing add propertysplitaddress nvarchar(255);
update NashvilleHousing set propertysplitaddress = SUBSTRING(propertyaddress,1, CHARINDEX(',',PropertyAddress)-1)

alter table nashvillehousing add propertysplitcity nvarchar(255);
update NashvilleHousing set propertysplitcity = SUBSTRING(propertyaddress, CHARINDEX(',',PropertyAddress)+1, LEN(PropertyAddress))

select * from NashvilleHousing

select PARSENAME(replace(OwnerAddress,',','.'),3),PARSENAME(replace(OwnerAddress,',','.'),3),PARSENAME(replace(OwnerAddress,',','.'),1)
from NashvilleHousing

alter table nashvillehousing add owernersplitaddress nvarchar(255)
update NashvilleHousing set owernersplitaddress = PARSENAME(replace(OwnerAddress,',','.'),3)

alter table nashvillehousing add owernersplitcity nvarchar(255)
update NashvilleHousing set owernersplitcity = PARSENAME(replace(OwnerAddress,',','.'),2)

alter table nashvillehousing add owernersplitstate nvarchar(255)
update NashvilleHousing set owernersplitstate = PARSENAME(replace(OwnerAddress,',','.'),1)

select * from NashvilleHousing
-----------------------------------------------------------------------------------------------------------------------------------
select soldasvacant,count(soldasvacant) from NashvilleHousing
group by SoldAsVacant
order by SoldAsVacant

select soldasvacant,
case when SoldAsVacant = 'Y' then 'Yes'
when SoldAsVacant = 'N' then 'No'
else SoldAsVacant
end
from NashvilleHousing

update NashvilleHousing 
set SoldAsVacant = 
case when SoldAsVacant = 'Y' then 'Yes'
when SoldAsVacant = 'N' then 'No'
else SoldAsVacant
end
from NashvilleHousing
---------------------------------------------------------------------------------------------------------------------------------------
with rownumCTE as(
select *, ROW_NUMBER() over (partition by parcelid,propertyaddress,saleprice,saledate,legalreference order by uniqueid) row_num
from NashvilleHousing
--order by parcelid
)
delete 
from rownumCTE 
where row_num > 1
--order by propertyaddress
-----------------------------------------------------------------------------------------------------------------------------------------
select * from NashvilleHousing

alter table nashvillehousing
drop column owneraddress,propertyaddress,taxdistrict

alter table nashvillehousing
drop column saledate








