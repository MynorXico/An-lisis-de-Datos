--DATABASE
/*CREATE DATABASE [Admisiones_DWHProyecto]
GO;*/

USE [Admisiones_DWHProyecto]
EXEC sp_changedbowner 'sa'
GO

--SCHEMAS
/*CREATE SCHEMA Fact
GO

CREATE SCHEMA Dimension
GO*/
DROP SCHEMA IF EXISTS Staging
Go
CREATE SCHEMA Staging
GO

--DIMENSION CANDIDATO----------------------------------------------------------
/*DROP TABLE IF EXISTS Dimension.Candidato
CREATE TABLE Dimension.Candidato
(
	[ID_Candidato] [dbo].[UDT_PK] NULL,
	[ID_Colegio] [dbo].[UDT_PK] NULL,
	[ID_Diversificado] [dbo].[UDT_PK] NULL,
	[NombreCandidato] [dbo].[UDT_VarcharCorto] NULL,
	[ApellidoCandidato] [dbo].[UDT_VarcharCorto] NULL,
	[Genero] [dbo].[UDT_UnCaracter] NULL,
	[FechaNacimiento] [dbo].[UDT_DateTime] NULL,
	[NombreColegio] [dbo].[UDT_VarcharLargo] NULL,
	[NombreDiversificado] [dbo].[UDT_VarcharLargo] NULL
)
GO*/
ALTER TABLE Dimension.Candidato
ADD --[SK_Candidato] [dbo].[UDT_SK] IDENTITY(1,1) NOT NULL,
	[Municipio] [UDT_VarcharMediano] NULL,--NUEVO
    [FechaInicioValidez] [UDT_DateTime] NULL,
	[FechaFinValidez] [UDT_DateTime] NULL,
	[FechaCreacion] [UDT_DateTime] NULL,
	[UsuarioCreacion] [nvarchar](100) NULL,
	[FechaModificacion] [UDT_DateTime] NULL,
	[UsuarioModificacion] [nvarchar](100) NULL,
	[ID_Batch] [UDT_VarcharCorto] NULL,
	[ID_SourceSystem] [UDT_VarcharCorto] NULL,
	[Edad] int null--NUEVO

--CAMBIO
ALTER TABLE Dimension.Candidato
DROP COLUMN [ID_Colegio],--NUEVO
			[ID_Diversificado]--NUEVO

DROP TABLE IF EXISTS Staging.Candidato
CREATE TABLE Staging.Candidato
(
	[Municipio] [UDT_VarcharMediano] NULL,--NUEVO
	[SK_Candidato] [dbo].[UDT_SK] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[ID_Candidato] [dbo].[UDT_PK] NULL,
	[NombreCandidato] [dbo].[UDT_VarcharCorto] NULL,
	[ApellidoCandidato] [dbo].[UDT_VarcharCorto] NULL,
	[Genero] [dbo].[UDT_UnCaracter] NULL,
	[FechaNacimiento] [dbo].[UDT_DateTime] NULL,
	[Edad] int NULL,--NUEVO
	[NombreColegio] [dbo].[UDT_VarcharLargo] NULL,--NUEVO
	[NombreDiversificado] [dbo].[UDT_VarcharLargo] NULL,--NUEVO
    [FechaInicioValidez] [UDT_DateTime] NOT NULL,
	[FechaFinValidez] [UDT_DateTime] NULL,
	[FechaCreacion] [UDT_DateTime] NOT NULL,
	[UsuarioCreacion] [nvarchar](100) NOT NULL,
	[FechaModificacion] [UDT_DateTime] NULL,
	[UsuarioModificacion] [nvarchar](100) NULL,
	[ID_Batch] [UDT_VarcharCorto] NULL,
	[ID_SourceSystem] [UDT_VarcharCorto] NULL
)
GO


--DIMENSION CARRERA------------------------------------------------------------
/*DROP TABLE IF EXISTS Dimension.Carrera
CREATE TABLE Dimension.Carrera
(
	[ID_Carrera] [dbo].[UDT_PK] NULL,
	[ID_Facultad] [dbo].[UDT_PK] NULL,
	[NombreCarrera] [dbo].[UDT_VarcharMediano] NULL,
	[NombreFacultad] [dbo].[UDT_VarcharMediano] NULL
)
GO*/
ALTER TABLE Dimension.Carrera
ADD --[SK_Carrera] [dbo].[UDT_SK] IDENTITY(1,1) NOT NULL,
    [FechaInicioValidez] [UDT_DateTime] NULL,
	[FechaFinValidez] [UDT_DateTime] NULL,
	[FechaCreacion] [UDT_DateTime] NULL,
	[UsuarioCreacion] [nvarchar](100) NULL,
	[FechaModificacion] [UDT_DateTime] NULL,
	[UsuarioModificacion] [nvarchar](100) NULL,
	[ID_Batch] [UDT_VarcharCorto] NULL,
	[ID_SourceSystem] [UDT_VarcharCorto] NULL

--CAMBIO
ALTER TABLE Dimension.Carrera
DROP COLUMN [ID_Facultad]

DROP TABLE IF EXISTS Staging.Carrera
CREATE TABLE Staging.Carrera
(
	[SK_Carrera] [dbo].[UDT_SK] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[ID_Carrera] [dbo].[UDT_PK] NULL,
	--CAMBIO	[ID_Facultad] [dbo].[UDT_PK] NULL,
	[NombreCarrera] [dbo].[UDT_VarcharMediano] NULL,
	[NombreFacultad] [dbo].[UDT_VarcharMediano] NULL,
    [FechaInicioValidez] [UDT_DateTime] NOT NULL,
	[FechaFinValidez] [UDT_DateTime] NULL,
	[FechaCreacion] [UDT_DateTime] NOT NULL,
	[UsuarioCreacion] [nvarchar](100) NOT NULL,
	[FechaModificacion] [UDT_DateTime] NULL,
	[UsuarioModificacion] [nvarchar](100) NULL,
	[ID_Batch] [UDT_VarcharCorto] NULL,
	[ID_SourceSystem] [UDT_VarcharCorto] NULL
)
GO

--DIMENSION COLEGIO------------------------------------------------------------
DROP TABLE IF EXISTS Dimension.ColegioCandidato
CREATE TABLE Dimension.ColegioCandidato
(
	[SK_ColegioCandidato] [dbo].[UDT_SK] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[ID_Colegio] [dbo].[UDT_PK]  NOT NULL,
	[Nombre] [UDT_VarcharLargo] NOT NULL,
	[FechaInicioValidez] [UDT_DateTime] NOT NULL,
	[FechaFinValidez] [UDT_DateTime] NULL,
	[FechaCreacion] [UDT_DateTime] NOT NULL,
	[UsuarioCreacion] [nvarchar](100) NOT NULL,
	[FechaModificacion] [UDT_DateTime] NULL,
	[UsuarioModificacion] [nvarchar](100) NULL,
	[ID_Batch] [UDT_VarcharCorto] NULL,
	[ID_SourceSystem] [UDT_VarcharCorto] NULL
)
GO

DROP TABLE IF EXISTS Staging.ColegioCandidato
CREATE TABLE Staging.ColegioCandidato
(	[SK_ColegioCandidato] [dbo].[UDT_SK] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[ID_Colegio] [dbo].[UDT_PK] NOT NULL,
	[Nombre] [UDT_VarcharLargo] NOT NULL,
	[FechaInicioValidez] [UDT_DateTime] NOT NULL,
	[FechaFinValidez] [UDT_DateTime] NULL,
	[FechaCreacion] [UDT_DateTime] NOT NULL,
	[UsuarioCreacion] [nvarchar](100) NOT NULL,
	[FechaModificacion] [UDT_DateTime] NULL,
	[UsuarioModificacion] [nvarchar](100) NULL,
	[ID_Batch] [UDT_VarcharCorto] NULL,
	[ID_SourceSystem] [UDT_VarcharCorto] NULL
)
GO

--JERARQUÍA GEOGRÁFICA------------------------------------------------------------------
DROP TABLE IF EXISTS Dimension.Geografia
CREATE TABLE Dimension.Geografia
(
	[SK_Geografia] [dbo].[UDT_SK] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[ID_Municipio][dbo].[UDT_PK] null,
	[Municipio] [UDT_VarcharMediano] NULL,
	[Departamento] [UDT_VarcharMediano] NULL,
	[Pais] [UDT_VarcharMediano] NULL
)
GO
DROP TABLE IF EXISTS Staging.Geografia
CREATE TABLE Staging.Geografia
(
	[SK_Geografia] [dbo].[UDT_SK] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[ID_Municipio][dbo].[UDT_PK] null,
	[Municipio] [UDT_VarcharMediano] NULL,
	[Departamento] [UDT_VarcharMediano] NULL,
	[Pais] [UDT_VarcharMediano] NULL
)
GO


--DIMENSION CARRERA DIVERSIFICADO-----------------------------------------------------
DROP TABLE IF EXISTS Dimension.Diversificado
CREATE TABLE Dimension.Diversificado(
	[SK_Diversificado] [dbo].[UDT_SK] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[ID_Diversificado] [dbo].[UDT_PK] NOT NULL,
	[Nombre] [UDT_VarcharLargo] NOT NULL,
	[FechaInicioValidez] [UDT_DateTime] NOT NULL,
	[FechaFinValidez] [UDT_DateTime] NULL,
	[FechaCreacion] [UDT_DateTime] NOT NULL,
	[UsuarioCreacion] [nvarchar](100) NOT NULL,
	[FechaModificacion] [UDT_DateTime] NULL,
	[UsuarioModificacion] [nvarchar](100) NULL,
	[ID_Batch] [UDT_VarcharCorto] NULL,
	[ID_SourceSystem] [UDT_VarcharCorto] NULL
)
GO

DROP TABLE IF EXISTS Staging.Diversificado
CREATE TABLE Staging.Diversificado(
	[SK_Diversificado] [dbo].[UDT_SK] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[ID_Diversificado] [dbo].[UDT_PK] NOT NULL,
	[Nombre] [UDT_VarcharLargo] NOT NULL,
	[FechaInicioValidez] [UDT_DateTime] NOT NULL,
	[FechaFinValidez] [UDT_DateTime] NULL,
	[FechaCreacion] [UDT_DateTime] NOT NULL,
	[UsuarioCreacion] [nvarchar](100) NOT NULL,
	[FechaModificacion] [UDT_DateTime] NULL,
	[UsuarioModificacion] [nvarchar](100) NULL,
	[ID_Batch] [UDT_VarcharCorto] NULL,
	[ID_SourceSystem] [UDT_VarcharCorto] NULL
)
GO

--DIMENSION CLASIFICACION CANDIDATO-----------------------------------------------------
DROP TABLE IF EXISTS Dimension.Status
DROP TABLE IF EXISTS Dimension.Clasificacion
CREATE TABLE Dimension.Clasificacion(
	[SK_Clasificacion] [dbo].[UDT_SK] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[ID_Clasificacion] [dbo].[UDT_PK] NOT NULL,
	[Nombre] [UDT_VarcharMediano] NULL
)
GO
DROP TABLE IF EXISTS Staging.Status
DROP TABLE IF EXISTS Staging.Clasificacion
CREATE TABLE Staging.Clasificacion(
	[SK_Clasificacion] [dbo].[UDT_SK] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[ID_Clasificacion] [dbo].[UDT_PK] NOT NULL,
	[Nombre] [UDT_VarcharMediano] NULL
)
GO

--DIMENSION AREA------------------------------------------------------------------------
DROP TABLE IF EXISTS Dimension.ExamenArea
CREATE TABLE Dimension.ExamenArea(
    [SK_ExamenArea] [dbo].[UDT_SK] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[ID_ExamenArea] [dbo].[UDT_PK] NOT NULL,
	[NombreArea] [UDT_VarcharMediano] NOT NULL,
	[Especial] [bit] NULL
)
GO
DROP TABLE IF EXISTS Staging.ExamenArea
CREATE TABLE Staging.ExamenArea(
	[SK_ExamenArea] [dbo].[UDT_SK] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[ID_ExamenArea] [dbo].[UDT_PK] NOT NULL,
	[NombreArea] [UDT_VarcharMediano] NOT NULL,
	[Especial] [bit] NULL
)
GO

--HECHOS RESULTADO ADMISION--------------------------------------------------------------
ALTER TABLE [Fact].[ResultadoAdmision]
ADD [SK_ColegioCandidato] [dbo].[UDT_SK] NULL,
	[SK_Geografia] [dbo].[UDT_SK] NULL,
	[SK_Diversificado] [dbo].[UDT_SK] NULL,
	[SK_Clasificacion] [dbo].[UDT_SK] NULL,
	[SK_ExamenArea] [dbo].[UDT_SK] NULL,
	[NotaVerbal] decimal(5,2) null, 
	[NotaCuantitativa] decimal (5,2) null,
	[NotaMatematicaCalculo] decimal (5,2) null,
	[NotaFisica] decimal (5,2) null,
	[NotaQuimica] decimal (5,2) null,
	[NotaEspanol] decimal (5,2) null,
	[NotaMatematica] decimal (5,2) null,
	[NotaNaturales] decimal (5,2) null,
	[NotaSociales] decimal (5,2) null


	



--FOREIGNS--------------------------------------------------------------------------------
ALTER TABLE [Fact].[ResultadoAdmision] WITH NOCHECK
ADD CONSTRAINT FK_ResultadoAdmision_Colegio
FOREIGN KEY (SK_ColegioCandidato) REFERENCES [Dimension].[ColegioCandidato](SK_ColegioCandidato);

ALTER TABLE [Fact].[ResultadoAdmision] WITH NOCHECK
ADD CONSTRAINT FK_ResultadoAdmision_Geografia
FOREIGN KEY (SK_Geografia) REFERENCES [Dimension].[Geografia](SK_Geografia);

ALTER TABLE [Fact].[ResultadoAdmision] WITH NOCHECK
ADD CONSTRAINT FK_ResultadoAdmision_Diversificado
FOREIGN KEY (SK_Diversificado) REFERENCES [Dimension].[Diversificado](SK_Diversificado);

ALTER TABLE [Fact].[ResultadoAdmision] WITH NOCHECK
ADD CONSTRAINT FK_ResultadoAdmision_Clasificacion
FOREIGN KEY (SK_Clasificacion) REFERENCES [Dimension].Clasificacion(SK_Clasificacion);

ALTER TABLE [Fact].[ResultadoAdmision] WITH NOCHECK
ADD CONSTRAINT FK_ResultadoAdmision_ExamenArea
FOREIGN KEY (SK_ExamenArea) REFERENCES [Dimension].[ExamenArea](SK_ExamenArea);