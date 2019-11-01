INSERT INTO [Staging].[Candidato]
 (         [Municipio]
           ,[ID_Candidato]
           ,[NombreCandidato]
           ,[ApellidoCandidato]
           ,[Genero]
           ,[FechaNacimiento]
           ,[Edad]
           ,[NombreColegio]
           ,[NombreDiversificado]
           ,[FechaInicioValidez]
           ,[FechaFinValidez]
           ,[FechaCreacion]
           ,[UsuarioCreacion]
           ,[FechaModificacion]
           ,[UsuarioModificacion]
           ,[ID_Batch]
           ,[ID_SourceSystem])
Select 
	muni.Nombre,
	Can.ID_Candidato,
	CAN.Nombre as NombreCandidato,
	CAN.Apellido  as ApellidoCandidato,
	CAN.Genero as Genero,
	CAN.FechaNacimiento as FechaNacimiento,
	can.Edad as edad,
	COL.Nombre as NombreColegio,
	DIV.Nombre as NombreDiversificado,
	--Columnas SCD tipo 2 
	'2013-01-01' as FechaInicioValidez,
	null as FechaFinValidez,
	GETDATE() AS FechaCreacion,
	CAST(SUSER_NAME() AS nvarchar(100)) AS UsuarioCreacion,
	GETDATE() AS FechaModificacion,
	CAST(SUSER_NAME() AS nvarchar(100)) AS UsuarioModificacion,
	--Columnas linaje
	'1-ETL' as ID_Batch,
	'Admisiones' as ID_SourceSystem
FROM [AdmisionesProyecto].[dbo].[Candidato] CAN INNER JOIN	
	 [AdmisionesProyecto].[dbo].[ColegioCandidato] COL ON (CAN.ID_Colegio = COL.ID_Colegio) INNER JOIN
	 [AdmisionesProyecto].[dbo].[Diversificado] DIV ON (CAN.ID_Diversificado = DIV.ID_Diversificado) INNER JOIN
	 [AdmisionesProyecto].[dbo].Municipio MUNI ON (CAN.ID_Municipio = muni.ID_Municipio)
GO

INSERT INTO [Staging].[Carrera]
(           [ID_Carrera]
           ,[NombreCarrera]
           ,[NombreFacultad]
           ,[FechaInicioValidez]
           ,[FechaFinValidez]
           ,[FechaCreacion]
           ,[UsuarioCreacion]
           ,[FechaModificacion]
           ,[UsuarioModificacion]
           ,[ID_Batch]
           ,[ID_SourceSystem])
    Select 
	car.ID_Carrera,
	car.Nombre,
	fac.Nombre,
	--Columnas SCD tipo 2 
	'2013-01-01' as FechaInicioValidez,
	null as FechaFinValidez,
	GETDATE() AS FechaCreacion,
	CAST(SUSER_NAME() AS nvarchar(100)) AS UsuarioCreacion,
	GETDATE() AS FechaModificacion,
	CAST(SUSER_NAME() AS nvarchar(100)) AS UsuarioModificacion,
	--Columnas linaje
	'1-ETL' as ID_Batch,
	'Admisiones' as ID_SourceSystem
FROM [AdmisionesProyecto].[dbo].Carrera car inner join 
	 [AdmisionesProyecto].dbo.Facultad fac on (car.ID_Facultad = fac.ID_Facultad)
Go

INSERT INTO [Staging].[ColegioCandidato]
Select 
	col.ID_Colegio,
	col.Nombre,
	--Columnas SCD tipo 2 
	'2013-01-01' as FechaInicioValidez,
	null as FechaFinValidez,
	GETDATE() AS FechaCreacion,
	CAST(SUSER_NAME() AS nvarchar(100)) AS UsuarioCreacion,
	GETDATE() AS FechaModificacion,
	CAST(SUSER_NAME() AS nvarchar(100)) AS UsuarioModificacion,
	--Columnas linaje
	'1-ETL' as ID_Batch,
	'Admisiones' as ID_SourceSystem
FROM [AdmisionesProyecto].[dbo].ColegioCandidato COL
Go

INSERT INTO [Staging].Diversificado
Select 
	div.ID_Diversificado,
	div.Nombre,
	--Columnas SCD tipo 2 
	'2013-01-01' as FechaInicioValidez,
	null as FechaFinValidez,
	GETDATE() AS FechaCreacion,
	CAST(SUSER_NAME() AS nvarchar(100)) AS UsuarioCreacion,
	GETDATE() AS FechaModificacion,
	CAST(SUSER_NAME() AS nvarchar(100)) AS UsuarioModificacion,
	--Columnas linaje
	'1-ETL' as ID_Batch,
	'Admisiones' as ID_SourceSystem
FROM [AdmisionesProyecto].[dbo].Diversificado div
Go

INSERT INTO [Staging].ExamenArea
Select 
	EXA.ID_ExamenArea,
	Exa.NombreArea,
	EXA.Especial
FROM [AdmisionesProyecto].[dbo].ExamenArea EXA

Go


INSERT INTO [Staging].[Geografia]
           ([ID_Municipio],
		   [Municipio]
           ,[Departamento]
           ,[Pais])
Select 
	MUNI.ID_Municipio,
	muni.Nombre,
	depa.Nombre,
	pais.Nombre
from [AdmisionesProyecto].[dbo].Municipio muni inner join
	 [AdmisionesProyecto].[dbo].Departamento depa on (muni.ID_Departamento = depa.ID_Departamento) inner join
	 [AdmisionesProyecto].[dbo].Pais pais on (depa.ID_Pais=pais.ID_Pais)
          
Go

USE Admisiones_DWHProyecto
Go

DROP FUNCTION IF EXISTS [dbo].GetClasificacion;
GO
CREATE FUNCTION [dbo].GetClasificacion
(
	@aciertos as INT,
	@preguntas as INT
)
RETURNS INT
BEGIN
	DECLARE @answer INT;
	SET @answer = 1;
	DECLARE @clasificacion DECIMAL(8,2);
	SET @clasificacion = CAST(@aciertos AS DECIMAL(8,2))/CAST(@preguntas AS DECIMAL(8,2))*100;
	IF (@clasificacion >= 70)
	BEGIN
		SET @answer = 1
	END
	ELSE 
	BEGIN
		IF (@clasificacion >= 55)
		BEGIN
			SET @answer = 2
		END
		ELSE
		BEGIN
			SET @answer = 3
		END
	END
	RETURN (select SK_Clasificacion from [Admisiones_DWHProyecto].Dimension.Clasificacion WHERE ID_Clasificacion = @answer);
END;
go



--------- DIMENSIÓN DE FECHA
Use AdmisionesProyecto
Go

USe Admisiones_DWHProyecto
Go

Select * from  Dimension.Carrera
Select * from  Dimension.Clasificacion
Select * from  Dimension.ColegioCandidato
Select * from  Dimension.Diversificado --x
Select * from  Dimension.ExamenArea
Select * from  Dimension.Fecha
Select * from  Dimension.Geografia
Select * from Dimension.Candidato where ID_Candidato =1062
Select * from Fact.ResultadoAdmision

Select * from Staging.Candidato
Select * from Staging.ExamenArea
Select * from Staging.Diversificado



DELETE FROM Dimension.Geografia
DELETE FROM Dimension.Carrera
DELETE FROM Dimension.Clasificacion
DELETE FROM Dimension.ColegioCandidato
DELETE FROM  Dimension.Diversificado
DELETE FROM Dimension.ExamenArea
DELETE FROM  Dimension.Geografia
DELETE FROM Dimension.Candidato
DELETE FROM Fact.ResultadoAdmision

USE [Admisiones_DWHProyecto]
GO

INSERT INTO [Dimension].[Clasificacion]
           ([ID_Clasificacion]
           ,[Nombre])
     VALUES
           (1,'A'),(2,'B'),(3,'C')
GO

DELETE FROM Fact.ResultadoAdmision
Select * from Fact.ResultadoAdmision
Select * from Dimension.Candidato where ID_Candidato =1064
Select * from Staging.Candidato


----FIN---
INSERT INTO [Fact].[ResultadoAdmision]
           ([SK_Candidato]
           ,[SK_Carrera]
           ,[DateKey]
           ,[ID_Resultado]
           ,[ID_Descuento]
           ,[DescripcionDescuento]
           ,[PorcentajeDescuento]
           ,[Precio]
           ,[NotaTotal]
           ,[NotaArea]
           ,[NombreArea]
           ,[SK_ColegioCandidato]
           ,[SK_Geografia]
           ,[SK_Diversificado]
           ,[SK_ExamenArea],
		    [SK_Clasificacion],
		    [NotaVerbal], 
			[NotaCuantitativa],
			[NotaMatematicaCalculo],
			[NotaFisica],
			[NotaQuimica],
			[NotaEspanol],
			[NotaMatematica],
			[NotaNaturales],
			[NotaSociales] )
Select
	can.SK_Candidato,
	Dcar.SK_Carrera,
	YEAR(ra.FechaPrueba)*10000 + MONTH(ra.FechaPrueba)*100 + DAY(ra.FechaPrueba),
	RA.ID_Resultado,
	null,--ra.ID_Descuento,
	null,--ade.Descripcion,
	null,--ade.PorcentajeDescuento,
	ra.Precio,
	CAST(ra.TotalAciertos AS DECIMAL(8,2))/CAST(ra.TotalPreguntas AS DECIMAL(8,2))*100,
	null,
	null,
	dcc.SK_ColegioCandidato,
	Dg.SK_Geografia, -- FALTA Geograf�a
	Dd.SK_Diversificado,
	null, -- EXAMEN AREA NO VA
	(SELECT [dbo].GetClasificacion(ra1.TotalAciertos, ra1.TotalPreguntas) as test FROM [AdmisionesProyecto].dbo.ResultadoAdmision ra1  WHERE ra1.ID_Resultado = ra.ID_Resultado),
	(
		SELECT rad.NotaArea FROM [AdmisionesProyecto].dbo.ExamenArea ea JOIN
		[AdmisionesProyecto].dbo.ResultadoAdmision_detalle rad ON (ea.ID_ExamenArea = rad.ID_ExamenArea)
		WHERE rad.ID_Resultado = ra.ID_Resultado AND ea.NombreArea = 'HABILIDADES VERBALES'),
	(
		SELECT rad.NotaArea FROM [AdmisionesProyecto].dbo.ExamenArea ea JOIN
		[AdmisionesProyecto].dbo.ResultadoAdmision_detalle rad ON (ea.ID_ExamenArea = rad.ID_ExamenArea)
		WHERE rad.ID_Resultado = ra.ID_Resultado AND ea.NombreArea = 'HABILIDADES CUANTITATIVAS'),
	(
		SELECT rad.NotaArea FROM [AdmisionesProyecto].dbo.ExamenArea ea JOIN
		[AdmisionesProyecto].dbo.ResultadoAdmision_detalle rad ON (ea.ID_ExamenArea = rad.ID_ExamenArea)
		WHERE rad.ID_Resultado = ra.ID_Resultado AND ea.NombreArea = 'MATEMÁTICA PARA EL CÁLCULO'),
	(
		SELECT rad.NotaArea FROM [AdmisionesProyecto].dbo.ExamenArea ea JOIN
		[AdmisionesProyecto].dbo.ResultadoAdmision_detalle rad ON (ea.ID_ExamenArea = rad.ID_ExamenArea)
		WHERE rad.ID_Resultado = ra.ID_Resultado AND ea.NombreArea = 'FÍSICA'),
	(
		SELECT rad.NotaArea FROM [AdmisionesProyecto].dbo.ExamenArea ea JOIN
		[AdmisionesProyecto].dbo.ResultadoAdmision_detalle rad ON (ea.ID_ExamenArea = rad.ID_ExamenArea)
		WHERE rad.ID_Resultado = ra.ID_Resultado AND ea.NombreArea = 'QUÍMICA'),
	(
		SELECT rad.NotaArea FROM [AdmisionesProyecto].dbo.ExamenArea ea JOIN
		[AdmisionesProyecto].dbo.ResultadoAdmision_detalle rad ON (ea.ID_ExamenArea = rad.ID_ExamenArea)
		WHERE rad.ID_Resultado = ra.ID_Resultado AND ea.NombreArea = 'ESPAÑOL'),
	(
		SELECT rad.NotaArea FROM [AdmisionesProyecto].dbo.ExamenArea ea JOIN
		[AdmisionesProyecto].dbo.ResultadoAdmision_detalle rad ON (ea.ID_ExamenArea = rad.ID_ExamenArea)
		WHERE rad.ID_Resultado = ra.ID_Resultado AND ea.NombreArea = 'MATEMÁTICAS'),
	(
		SELECT rad.NotaArea FROM [AdmisionesProyecto].dbo.ExamenArea ea JOIN
		[AdmisionesProyecto].dbo.ResultadoAdmision_detalle rad ON (ea.ID_ExamenArea = rad.ID_ExamenArea)
		WHERE rad.ID_Resultado = ra.ID_Resultado AND ea.NombreArea = 'CIENCIAS NATURALES'),
	(
		SELECT rad.NotaArea FROM [AdmisionesProyecto].dbo.ExamenArea ea JOIN
		[AdmisionesProyecto].dbo.ResultadoAdmision_detalle rad ON (ea.ID_ExamenArea = rad.ID_ExamenArea)
		WHERE rad.ID_Resultado = ra.ID_Resultado AND ea.NombreArea = 'CIENCIAS SOCIALES')
From
	[AdmisionesProyecto].dbo.ResultadoAdmision RA inner join 
	[Admisiones_DWHProyecto].Dimension.Candidato CAN on (ra.ID_Candidato = can.ID_Candidato) inner join 
	[AdmisionesProyecto].dbo.Carrera CAR on (ra.ID_Carrera = car.ID_Carrera) inner join 
	[Admisiones_DWHProyecto].Dimension.Carrera Dcar on (car.ID_Carrera =Dcar.ID_Carrera) inner join
	--[AdmisionesProyecto].dbo.DescuentoExamen ADE On (ra.ID_Descuento = ade.ID_Descuento) inner join
	[AdmisionesProyecto].dbo.Candidato Ac ON (ra.ID_Candidato = AC.ID_Candidato) INNER JOIN 
	[AdmisionesProyecto].dbo.ColegioCandidato Acc ON (Ac.ID_Colegio = Acc.ID_Colegio) INNER JOIN 
	[Admisiones_DWHProyecto].Dimension.ColegioCandidato dcc ON (dcc.ID_Colegio = Ac.ID_Colegio) INNER JOIN 
	[AdmisionesProyecto].dbo.Diversificado Ad  ON (Ac.ID_Diversificado =  Ad.ID_Diversificado) INNER JOIN 
	[Admisiones_DWHProyecto].Dimension.Diversificado Dd ON (Ad.ID_Diversificado = Dd.ID_Diversificado) INNER JOIN 
	[AdmisionesProyecto].dbo.Municipio Am ON (Ac.ID_Municipio = Am.ID_Municipio) INNER JOIN 
	[Admisiones_DWHProyecto].Dimension.Geografia Dg ON (Dg.ID_Municipio = Am.ID_Municipio)
	
GO