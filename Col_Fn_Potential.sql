USE [CCOps]
GO

/****** Object:  UserDefinedFunction [dbo].[Col_Fn_Potential]    Script Date: 10/27/2015 09:18:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






-- =============================================
-- Author:		Alper Özen
-- Create date: 24/01/2013
-- Description:	Değişkenleri belirtilen bir müşterinin hangi ayın potansiyelinde olduğunu döndürür
-- =============================================
CREATE FUNCTION [dbo].[Col_Fn_Potential]
(
@statu varchar(3),
@ekt datetime ,
@sot datetime 
)
RETURNS   varchar(100)
AS
BEGIN

DECLARE @dtDate DATETIME
DECLARE @dtDate2 DATETIME
DECLARE @dtDate3 DATETIME

DECLARE @aySonu DATETIME
DECLARE @aySonu2 DATETIME
DECLARE @aySonu3 DATETIME

DECLARE @potansiyelinsongunu DATETIME
DECLARE @potansiyelinsongunu2 DATETIME
DECLARE @potansiyelinsongunu3 DATETIME

declare @gunSirasi int
declare @gunSirasi2 int
declare @gunSirasi3 int

DECLARE @gunAdi varchar
DECLARE @pFlag varchar(100)


DECLARE @TRbuAy varchar(20)
DECLARE @TRgelecekAy varchar(20)
DECLARE @TRsonrakiAy varchar(20)
DECLARE @TRoburAy varchar(20)

/*
2- pazartesi
3- sali
4- carsamba
5- persembe
6- cuma
7- cumartesi
1- pazar
*/

SET @dtDate =  getdate()-- '8/18/2007'
SET @dtDate2 =  dateadd(m,1,getdate())-- '8/18/2007'
SET @dtDate3 =  dateadd(m,2,getdate())-- '8/18/2007'

set @aySonu= DATEADD(D,0,DATEADD(s,-1,DATEADD(mm, DATEDIFF(m,0,@dtDate)+1,0)))
set @aySonu2= DATEADD(D,0,DATEADD(s,-1,DATEADD(mm, DATEDIFF(m,0,@dtDate2)+1,0)))
set @aySonu3= DATEADD(D,0,DATEADD(s,-1,DATEADD(mm, DATEDIFF(m,0,@dtDate3)+1,0)))

set @gunSirasi=DATEpart(dw ,@aySonu) 
set @gunSirasi2=DATEpart(dw ,@aySonu2) 
set @gunSirasi3=DATEpart(dw ,@aySonu3) 

	if (@gunSirasi in(3,4,5,6,7)) 
	-- ayın son günü sali,carsamba,persembe,cuma,cumartesi ise potansiyel için bir düş
	begin
		set @potansiyelinsongunu=DATEADD(d,-1,@aySonu)
	end 
	if (@gunSirasi =2) 
	--ayın son gunu pazartesi ise
	begin
		set @potansiyelinsongunu=DATEADD(d,-3,@aySonu)
	end 
	if (@gunSirasi =1) 
	-- ayın son günü pazar ise
	begin
		set @potansiyelinsongunu=DATEADD(d,-2,@aySonu)
	 end 



if (@gunSirasi2 in(3,4,5,6,7)) 
-- ayın son günü sali,carsamba,persembe,cuma,cumartesi ise potansiyel için bir düş
begin
	set @potansiyelinsongunu2=DATEADD(d,-1,@aySonu2)
end 
if (@gunSirasi2 =2) 
--ayın son gunu pazartesi ise
begin
	set @potansiyelinsongunu2=DATEADD(d,-3,@aySonu2)
end 
if (@gunSirasi2 =1) 
-- ayın son günü pazar ise
begin
	set @potansiyelinsongunu2=DATEADD(d,-2,@aySonu2)
 end



if (@gunSirasi3 in(3,4,5,6,7)) 
-- ayın son günü sali,carsamba,persembe,cuma,cumartesi ise potansiyel için bir düş
begin
	set @potansiyelinsongunu3=DATEADD(d,-1,@aySonu3)
end 
if (@gunSirasi3 =2) 
--ayın son gunu pazartesi ise
begin
	set @potansiyelinsongunu3=DATEADD(d,-3,@aySonu3)
end 
if (@gunSirasi3 =1) 
-- ayın son günü pazar ise
begin
	set @potansiyelinsongunu3=DATEADD(d,-2,@aySonu3)
 end

 
select @TRbuAy  =case 
when datename(m,@potansiyelinsongunu) = 'February' then 'Şubat'
when datename(m,@potansiyelinsongunu) = 'January' then 'Ocak'
when datename(m,@potansiyelinsongunu) = 'March' then 'Mart'
when datename(m,@potansiyelinsongunu) = 'April' then 'Nisan'
when datename(m,@potansiyelinsongunu) = 'May' then 'Mayıs'
when datename(m,@potansiyelinsongunu) = 'June' then 'Haziran'
when datename(m,@potansiyelinsongunu) = 'July' then 'Temmuz'
when datename(m,@potansiyelinsongunu) = 'August' then 'Ağustos'
when datename(m,@potansiyelinsongunu) = 'September' then 'Eylül'
when datename(m,@potansiyelinsongunu) = 'October' then 'Ekim'
when datename(m,@potansiyelinsongunu) = 'December' then 'Aralık'
when datename(m,@potansiyelinsongunu) = 'November' then 'Kasım'
end

select @TRgelecekAy  =case 
when datename(m,@potansiyelinsongunu2) = 'February' then 'Şubat'
when datename(m,@potansiyelinsongunu2) = 'January' then 'Ocak'
when datename(m,@potansiyelinsongunu2) = 'March' then 'Mart'
when datename(m,@potansiyelinsongunu2) = 'April' then 'Nisan'
when datename(m,@potansiyelinsongunu2) = 'May' then 'Mayıs'
when datename(m,@potansiyelinsongunu2) = 'June' then 'Haziran'
when datename(m,@potansiyelinsongunu2) = 'July' then 'Temmuz'
when datename(m,@potansiyelinsongunu2) = 'August' then 'Ağustos'
when datename(m,@potansiyelinsongunu2) = 'September' then 'Eylül'
when datename(m,@potansiyelinsongunu2) = 'October' then 'Ekim'
when datename(m,@potansiyelinsongunu2) = 'December' then 'Aralık'
when datename(m,@potansiyelinsongunu2) = 'November' then 'Kasım'
end

select @TRsonrakiAy  =case 
when datename(m,dateadd(m,2,@potansiyelinsongunu)) = 'February' then 'Şubat'
when datename(m,dateadd(m,2,@potansiyelinsongunu)) = 'January' then 'Ocak'
when datename(m,dateadd(m,2,@potansiyelinsongunu)) = 'March' then 'Mart'
when datename(m,dateadd(m,2,@potansiyelinsongunu)) = 'April' then 'Nisan'
when datename(m,dateadd(m,2,@potansiyelinsongunu)) = 'May' then 'Mayıs'
when datename(m,dateadd(m,2,@potansiyelinsongunu)) = 'June' then 'Haziran'
when datename(m,dateadd(m,2,@potansiyelinsongunu)) = 'July' then 'Temmuz'
when datename(m,dateadd(m,2,@potansiyelinsongunu)) =  'August' then 'Ağustos'
when datename(m,dateadd(m,2,@potansiyelinsongunu)) =  'September' then 'Eylül'
when datename(m,dateadd(m,2,@potansiyelinsongunu)) =  'October' then 'Ekim'
when datename(m,dateadd(m,2,@potansiyelinsongunu)) =  'December' then 'Aralık'
when datename(m,dateadd(m,2,@potansiyelinsongunu)) =  'November' then 'Kasım'
end

  select @TRoburAy  =case 
when datename(m,@potansiyelinsongunu3) = 'February' then 'Şubat'
when datename(m,@potansiyelinsongunu3) = 'January' then 'Ocak'
when datename(m,@potansiyelinsongunu3) = 'March' then 'Mart'
when datename(m,@potansiyelinsongunu3) = 'April' then 'Nisan'
when datename(m,@potansiyelinsongunu3) = 'May' then 'Mayıs'
when datename(m,@potansiyelinsongunu3) = 'June' then 'Haziran'
when datename(m,@potansiyelinsongunu3) = 'July' then 'Temmuz'
when datename(m,@potansiyelinsongunu3) = 'August' then 'Ağustos'
when datename(m,@potansiyelinsongunu3) = 'September' then 'Eylül'
when datename(m,@potansiyelinsongunu3) = 'October' then 'Ekim'
when datename(m,@potansiyelinsongunu3) = 'December' then 'Aralık'
when datename(m,@potansiyelinsongunu3) = 'November' then 'Kasım'

end


select @pFlag= case 
when @statu='D4' then  @TRbuAy
when @statu='D3' and @potansiyelinsongunu >= @sot then  @TRbuAy --+'D3  @potansiyelinsongunu >= @sot için bu ayın potansiyelinde'
when @statu='D3' and @potansiyelinsongunu < @sot then @TRgelecekAy --+'D3  @potansiyelinsongunu < @sot için bu ayın potansiyelinde değil'


when @statu='D2' and datediff(month,getdate(),dateadd(m,1,@sot))=0 and @potansiyelinsongunu >= dateadd(d,10,dateadd(m,1,@ekt)) then  @TRbuAy --+'D2  @potansiyelinsongunu >= @sot için gelecek ayın potansiyelinde'
when @statu='D2' and datediff(month,getdate(),dateadd(m,1,@sot))=0 and @potansiyelinsongunu < dateadd(d,10,dateadd(m,1,@ekt)) then  @TRgelecekAy --+'D2  @potansiyelinsongunu >= @sot için gelecek ayın potansiyelinde'
 
 when @statu='D2' and datediff(month,getdate(),dateadd(m,1,@sot))<>0 and @potansiyelinsongunu2 >= dateadd(d,10,dateadd(m,1,@ekt))then  @TRgelecekAy --+'D2  @potansiyelinsongunu >= @sot için gelecek ayın potansiyelinde'
 when @statu='D2' and datediff(month,getdate(),dateadd(m,1,@sot))<>0 and @potansiyelinsongunu2 < dateadd(d,10,dateadd(m,1,@ekt))then  @TRsonrakiAy --+'D2  @potansiyelinsongunu >= @sot için gelecek ayın potansiyelinde'

  --when @statu='D1' and datediff(month,getdate(),dateadd(m,1,@sot))<>0 and @potansiyelinsongunu3 >= dateadd(d,10,dateadd(m,1,@ekt))then  @TRgelecekAy --+'D2  @potansiyelinsongunu >= @sot için gelecek ayın potansiyelinde'
-- when @statu='D1' and datediff(month,getdate(),dateadd(m,1,@sot))<>0 and @potansiyelinsongunu3 < dateadd(d,10,dateadd(m,1,@ekt))then  @TRsonrakiAy --+'D2  @potansiyelinsongunu >= @sot için gelecek ayın potansiyelinde'

when @statu='D1' and @potansiyelinsongunu2 >= dateadd(d,10,dateadd(m,2,@ekt)) then   @TRgelecekAy --+'D3  @potansiyelinsongunu >= @sot için bu ayın potansiyelinde'
when @statu='D1' and @potansiyelinsongunu2 < dateadd(d,10,dateadd(m,2,@ekt)) then @TRsonrakiAy --+'D3  @potansiyelinsongunu < @sot için bu ayın potansiyelinde değil'

--select dbo.Col_Fn_Potential('D1', convert(datetime,'20/08/2013',103), convert(datetime,'21/08/2013',103))

else 'değil'
end

if (@pFlag ='değil') 
begin
 select @pFlag =  case
when datename(m,dateadd(m,2,getdate())) = 'February' then 'Şubat'
when datename(m,dateadd(m,2,getdate())) = 'January' then 'Ocak'
when datename(m,dateadd(m,2,getdate())) = 'March' then 'Mart'
when datename(m,dateadd(m,2,getdate())) = 'April' then 'Nisan'
when datename(m,dateadd(m,2,getdate())) = 'May' then 'Mayıs'
when datename(m,dateadd(m,2,getdate())) = 'June' then 'Haziran'
when datename(m,dateadd(m,2,getdate())) = 'July' then 'Temmuz'
when datename(m,dateadd(m,2,getdate())) = 'August' then 'Ağustos'
when datename(m,dateadd(m,2,getdate())) = 'September' then 'Eylül'
when datename(m,dateadd(m,2,getdate())) = 'October' then 'Ekim'
when datename(m,dateadd(m,2,getdate())) = 'December' then 'Aralık' 
when datename(m,dateadd(m,2,getdate())) = 'November' then 'Kasım' end
end

 return @pFlag 


END






GO


