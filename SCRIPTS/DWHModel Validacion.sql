
/****** Object:  Schema [Dimension]    Script Date: 2/11/2019 23:12:02 ******/
CREATE SCHEMA [Dimension]
Go
/****** Object:  Schema [Fact]    Script Date: 2/11/2019 23:12:02 ******/
CREATE SCHEMA [Fact]
GO
/****** Object:  Schema [Staging]    Script Date: 2/11/2019 23:12:02 ******/
CREATE SCHEMA [Staging]
GO
/****** Object:  UserDefinedDataType [dbo].[UDT_DateTime]    Script Date: 2/11/2019 23:12:02 ******/
IF (OBJECT_ID('dbo.UDT_DateTime') IS NOT NULL)
BEGIN
CREATE TYPE [dbo].[UDT_DateTime] FROM [datetime] NULL
END
GO
/****** Object:  UserDefinedDataType [dbo].[UDT_Decimal5.2]    Script Date: 2/11/2019 23:12:02 ******/
IF (OBJECT_ID('UDT_Decimal5.2') IS Not NULL)
BEGIN
CREATE TYPE [dbo].[UDT_Decimal5.2] FROM [decimal](5, 2) NULL
END
GO
/****** Object:  UserDefinedDataType [dbo].[UDT_Decimal6.2]    Script Date: 2/11/2019 23:12:02 ******/
IF (OBJECT_ID('UDT_Decimal6.2') IS Not NULL)
BEGIN
CREATE TYPE [dbo].[UDT_Decimal6.2] FROM [decimal](6, 2) NULL
END 
GO
/****** Object:  UserDefinedDataType [dbo].[UDT_PK]    Script Date: 2/11/2019 23:12:02 ******/
IF (OBJECT_ID('UDT_SK') IS Not NULL)
BEGIN
CREATE TYPE [dbo].[UDT_SK] FROM [int] NULL
END
GO
/****** Object:  UserDefinedDataType [dbo].[UDT_SK]    Script Date: 2/11/2019 23:12:02 ******/
IF (OBJECT_ID('UDT_SK') IS Not NULL)
BEGIN
CREATE TYPE [dbo].[UDT_SK] FROM [int] NULL
END
GO
/****** Object:  UserDefinedDataType [dbo].[UDT_UnCaracter]    Script Date: 2/11/2019 23:12:02 ******/
IF (OBJECT_ID('UDT_UnCaracter') IS Not NULL)
BEGIN
CREATE TYPE [dbo].[UDT_UnCaracter] FROM [char](1) NULL
END
GO
/****** Object:  UserDefinedDataType [dbo].[UDT_VarcharCorto]    Script Date: 2/11/2019 23:12:02 ******/
IF (OBJECT_ID('UDT_VarcharCorto') IS Not NULL)
BEGIN
CREATE TYPE [dbo].[UDT_VarcharCorto] FROM [varchar](100) NULL
END
GO
/****** Object:  UserDefinedDataType [dbo].[UDT_VarcharLargo]    Script Date: 2/11/2019 23:12:02 ******/
IF (OBJECT_ID('UDT_VarcharLargo') IS Not NULL)
BEGIN
CREATE TYPE [dbo].[UDT_VarcharLargo] FROM [varchar](600) NULL
END
GO
/****** Object:  UserDefinedDataType [dbo].[UDT_VarcharMediano]    Script Date: 2/11/2019 23:12:02 ******/
IF (OBJECT_ID('UDT_VarcharMediano') IS NOT NULL)
BEGIN
CREATE TYPE [dbo].[UDT_VarcharMediano] FROM [varchar](300) NULL
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetClasificacion]    Script Date: 2/11/2019 23:12:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[GetClasificacion]
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

GO
/****** Object:  Table [Dimension].[Candidato]    Script Date: 2/11/2019 23:12:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

if EXISTS (SELECT 1 FROM SYS.TABLES WHERE NAME = 'Dimension.Candidato')
BEGIN
CREATE TABLE [Dimension].[Candidato](
	[SK_Candidato] [dbo].[UDT_SK] IDENTITY(1,1) NOT NULL,
	[ID_Candidato] [dbo].[UDT_PK] NULL,
	[NombreCandidato] [dbo].[UDT_VarcharCorto] NULL,
	[ApellidoCandidato] [dbo].[UDT_VarcharCorto] NULL,
	[Genero] [dbo].[UDT_UnCaracter] NULL,
	[FechaNacimiento] [dbo].[UDT_DateTime] NULL,
	[NombreColegio] [dbo].[UDT_VarcharLargo] NULL,
	[NombreDiversificado] [dbo].[UDT_VarcharLargo] NULL,
	[Municipio] [dbo].[UDT_VarcharMediano] NULL,
	[FechaInicioValidez] [dbo].[UDT_DateTime] NULL,
	[FechaFinValidez] [dbo].[UDT_DateTime] NULL,
	[FechaCreacion] [dbo].[UDT_DateTime] NULL,
	[UsuarioCreacion] [nvarchar](100) NULL,
	[FechaModificacion] [dbo].[UDT_DateTime] NULL,
	[UsuarioModificacion] [nvarchar](100) NULL,
	[ID_Batch] [dbo].[UDT_VarcharCorto] NULL,
	[ID_SourceSystem] [dbo].[UDT_VarcharCorto] NULL,
	[Edad] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[SK_Candidato] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [Dimension].[Carrera]    Script Date: 2/11/2019 23:12:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

if EXISTS (SELECT 1 FROM SYS.TABLES WHERE NAME = 'Dimension.Carrera')
BEGIN
CREATE TABLE [Dimension].[Carrera](
	[SK_Carrera] [dbo].[UDT_SK] IDENTITY(1,1) NOT NULL,
	[ID_Carrera] [dbo].[UDT_PK] NULL,
	[NombreCarrera] [dbo].[UDT_VarcharMediano] NULL,
	[NombreFacultad] [dbo].[UDT_VarcharMediano] NULL,
	[FechaInicioValidez] [dbo].[UDT_DateTime] NULL,
	[FechaFinValidez] [dbo].[UDT_DateTime] NULL,
	[FechaCreacion] [dbo].[UDT_DateTime] NULL,
	[UsuarioCreacion] [nvarchar](100) NULL,
	[FechaModificacion] [dbo].[UDT_DateTime] NULL,
	[UsuarioModificacion] [nvarchar](100) NULL,
	[ID_Batch] [dbo].[UDT_VarcharCorto] NULL,
	[ID_SourceSystem] [dbo].[UDT_VarcharCorto] NULL,
PRIMARY KEY CLUSTERED 
(
	[SK_Carrera] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [Dimension].[Clasificacion]    Script Date: 2/11/2019 23:12:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

if EXISTS (SELECT 1 FROM SYS.TABLES WHERE NAME = 'Dimension.Clasificacion')
BEGIN
CREATE TABLE [Dimension].[Clasificacion](
	[SK_Clasificacion] [dbo].[UDT_SK] IDENTITY(1,1) NOT NULL,
	[ID_Clasificacion] [dbo].[UDT_PK] NOT NULL,
	[Nombre] [dbo].[UDT_VarcharMediano] NULL,
PRIMARY KEY CLUSTERED 
(
	[SK_Clasificacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [Dimension].[ColegioCandidato]    Script Date: 2/11/2019 23:12:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
if EXISTS (SELECT 1 FROM SYS.TABLES WHERE NAME = 'Dimension.ColegioCandidato')
BEGIN
CREATE TABLE [Dimension].[ColegioCandidato](
	[SK_ColegioCandidato] [dbo].[UDT_SK] IDENTITY(1,1) NOT NULL,
	[ID_Colegio] [dbo].[UDT_PK] NOT NULL,
	[Nombre] [dbo].[UDT_VarcharLargo] NOT NULL,
	[FechaInicioValidez] [dbo].[UDT_DateTime] NOT NULL,
	[FechaFinValidez] [dbo].[UDT_DateTime] NULL,
	[FechaCreacion] [dbo].[UDT_DateTime] NOT NULL,
	[UsuarioCreacion] [nvarchar](100) NOT NULL,
	[FechaModificacion] [dbo].[UDT_DateTime] NULL,
	[UsuarioModificacion] [nvarchar](100) NULL,
	[ID_Batch] [dbo].[UDT_VarcharCorto] NULL,
	[ID_SourceSystem] [dbo].[UDT_VarcharCorto] NULL,
PRIMARY KEY CLUSTERED 
(
	[SK_ColegioCandidato] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END 
GO
/****** Object:  Table [Dimension].[Diversificado]    Script Date: 2/11/2019 23:12:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
if EXISTS (SELECT 1 FROM SYS.TABLES WHERE NAME = 'Dimension.Diversificado')
BEGIN
CREATE TABLE [Dimension].[Diversificado](
	[SK_Diversificado] [dbo].[UDT_SK] IDENTITY(1,1) NOT NULL,
	[ID_Diversificado] [dbo].[UDT_PK] NOT NULL,
	[Nombre] [dbo].[UDT_VarcharLargo] NOT NULL,
	[FechaInicioValidez] [dbo].[UDT_DateTime] NOT NULL,
	[FechaFinValidez] [dbo].[UDT_DateTime] NULL,
	[FechaCreacion] [dbo].[UDT_DateTime] NOT NULL,
	[UsuarioCreacion] [nvarchar](100) NOT NULL,
	[FechaModificacion] [dbo].[UDT_DateTime] NULL,
	[UsuarioModificacion] [nvarchar](100) NULL,
	[ID_Batch] [dbo].[UDT_VarcharCorto] NULL,
	[ID_SourceSystem] [dbo].[UDT_VarcharCorto] NULL,
PRIMARY KEY CLUSTERED 
(
	[SK_Diversificado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [Dimension].[ExamenArea]    Script Date: 2/11/2019 23:12:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
if EXISTS (SELECT 1 FROM SYS.TABLES WHERE NAME = 'Dimension.ExamenArea')
BEGIN
CREATE TABLE [Dimension].[ExamenArea](
	[SK_ExamenArea] [dbo].[UDT_SK] IDENTITY(1,1) NOT NULL,
	[ID_ExamenArea] [dbo].[UDT_PK] NOT NULL,
	[NombreArea] [dbo].[UDT_VarcharMediano] NOT NULL,
	[Especial] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[SK_ExamenArea] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [Dimension].[Fecha]    Script Date: 2/11/2019 23:12:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

if EXISTS (SELECT 1 FROM SYS.TABLES WHERE NAME = 'Dimension.Fecha')
BEGIN 
CREATE TABLE [Dimension].[Fecha](
	[DateKey] [int] NOT NULL,
	[Date] [date] NOT NULL,
	[Day] [tinyint] NOT NULL,
	[DaySuffix] [char](2) NOT NULL,
	[Weekday] [tinyint] NOT NULL,
	[WeekDayName] [varchar](10) NOT NULL,
	[WeekDayName_Short] [char](3) NOT NULL,
	[WeekDayName_FirstLetter] [char](1) NOT NULL,
	[DOWInMonth] [tinyint] NOT NULL,
	[DayOfYear] [smallint] NOT NULL,
	[WeekOfMonth] [tinyint] NOT NULL,
	[WeekOfYear] [tinyint] NOT NULL,
	[Month] [tinyint] NOT NULL,
	[MonthName] [varchar](10) NOT NULL,
	[MonthName_Short] [char](3) NOT NULL,
	[MonthName_FirstLetter] [char](1) NOT NULL,
	[Quarter] [tinyint] NOT NULL,
	[QuarterName] [varchar](6) NOT NULL,
	[Year] [int] NOT NULL,
	[MMYYYY] [char](6) NOT NULL,
	[MonthYear] [char](7) NOT NULL,
	[IsWeekend] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DateKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [Dimension].[Geografia]    Script Date: 2/11/2019 23:12:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
if EXISTS (SELECT 1 FROM SYS.TABLES WHERE NAME = 'Dimension.Geografia')
BEGIN
CREATE TABLE [Dimension].[Geografia](
	[SK_Geografia] [dbo].[UDT_SK] IDENTITY(1,1) NOT NULL,
	[ID_Municipio] [dbo].[UDT_PK] NULL,
	[Municipio] [dbo].[UDT_VarcharMediano] NULL,
	[Departamento] [dbo].[UDT_VarcharMediano] NULL,
	[Pais] [dbo].[UDT_VarcharMediano] NULL,
PRIMARY KEY CLUSTERED 
(
	[SK_Geografia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END 
GO
/****** Object:  Table [Fact].[ResultadoAdmision]    Script Date: 2/11/2019 23:12:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
if EXISTS (SELECT 1 FROM SYS.TABLES WHERE NAME = 'Fact.ResultadoAdmision')
BEGIN
CREATE TABLE [Fact].[ResultadoAdmision](
	[SK_Resultado] [dbo].[UDT_SK] IDENTITY(1,1) NOT NULL,
	[SK_Candidato] [dbo].[UDT_SK] NULL,
	[SK_Carrera] [dbo].[UDT_SK] NULL,
	[DateKey] [int] NULL,
	[ID_Resultado] [dbo].[UDT_PK] NULL,
	[ID_Descuento] [dbo].[UDT_PK] NULL,
	[DescripcionDescuento] [dbo].[UDT_VarcharMediano] NULL,
	[PorcentajeDescuento] [dbo].[UDT_Decimal6.2] NULL,
	[Precio] [dbo].[UDT_Decimal6.2] NULL,
	[NotaTotal] [dbo].[UDT_Decimal5.2] NULL,
	[NotaArea] [dbo].[UDT_Decimal5.2] NULL,
	[NombreArea] [dbo].[UDT_VarcharMediano] NULL,
	[SK_ColegioCandidato] [dbo].[UDT_SK] NULL,
	[SK_Geografia] [dbo].[UDT_SK] NULL,
	[SK_Diversificado] [dbo].[UDT_SK] NULL,
	[SK_ExamenArea] [dbo].[UDT_SK] NULL,
	[SK_Clasificacion] [dbo].[UDT_SK] NULL,
	[NotaVerbal] [decimal](5, 2) NULL,
	[NotaCuantitativa] [decimal](5, 2) NULL,
	[NotaMatematicaCalculo] [decimal](5, 2) NULL,
	[NotaFisica] [decimal](5, 2) NULL,
	[NotaQuimica] [decimal](5, 2) NULL,
	[NotaEspanol] [decimal](5, 2) NULL,
	[NotaMatematica] [decimal](5, 2) NULL,
	[NotaNaturales] [decimal](5, 2) NULL,
	[NotaSociales] [decimal](5, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[SK_Resultado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END 
GO
/****** Object:  Table [Staging].[Candidato]    Script Date: 2/11/2019 23:12:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
if EXISTS (SELECT 1 FROM SYS.TABLES WHERE NAME = 'Staging.Candidato')
BEGIN 
CREATE TABLE [Staging].[Candidato](
	[Municipio] [dbo].[UDT_VarcharMediano] NULL,
	[SK_Candidato] [dbo].[UDT_SK] IDENTITY(1,1) NOT NULL,
	[ID_Candidato] [dbo].[UDT_PK] NULL,
	[NombreCandidato] [dbo].[UDT_VarcharCorto] NULL,
	[ApellidoCandidato] [dbo].[UDT_VarcharCorto] NULL,
	[Genero] [dbo].[UDT_UnCaracter] NULL,
	[FechaNacimiento] [dbo].[UDT_DateTime] NULL,
	[Edad] [int] NULL,
	[NombreColegio] [dbo].[UDT_VarcharLargo] NULL,
	[NombreDiversificado] [dbo].[UDT_VarcharLargo] NULL,
	[FechaInicioValidez] [dbo].[UDT_DateTime] NOT NULL,
	[FechaFinValidez] [dbo].[UDT_DateTime] NULL,
	[FechaCreacion] [dbo].[UDT_DateTime] NOT NULL,
	[UsuarioCreacion] [nvarchar](100) NOT NULL,
	[FechaModificacion] [dbo].[UDT_DateTime] NULL,
	[UsuarioModificacion] [nvarchar](100) NULL,
	[ID_Batch] [dbo].[UDT_VarcharCorto] NULL,
	[ID_SourceSystem] [dbo].[UDT_VarcharCorto] NULL,
PRIMARY KEY CLUSTERED 
(
	[SK_Candidato] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [Staging].[Carrera]    Script Date: 2/11/2019 23:12:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

if EXISTS (SELECT 1 FROM SYS.TABLES WHERE NAME = 'Staging.Carrera')
BEGIN
CREATE TABLE [Staging].[Carrera](
	[SK_Carrera] [dbo].[UDT_SK] IDENTITY(1,1) NOT NULL,
	[ID_Carrera] [dbo].[UDT_PK] NULL,
	[NombreCarrera] [dbo].[UDT_VarcharMediano] NULL,
	[NombreFacultad] [dbo].[UDT_VarcharMediano] NULL,
	[FechaInicioValidez] [dbo].[UDT_DateTime] NOT NULL,
	[FechaFinValidez] [dbo].[UDT_DateTime] NULL,
	[FechaCreacion] [dbo].[UDT_DateTime] NOT NULL,
	[UsuarioCreacion] [nvarchar](100) NOT NULL,
	[FechaModificacion] [dbo].[UDT_DateTime] NULL,
	[UsuarioModificacion] [nvarchar](100) NULL,
	[ID_Batch] [dbo].[UDT_VarcharCorto] NULL,
	[ID_SourceSystem] [dbo].[UDT_VarcharCorto] NULL,
PRIMARY KEY CLUSTERED 
(
	[SK_Carrera] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [Staging].[Clasificacion]    Script Date: 2/11/2019 23:12:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

if EXISTS (SELECT 1 FROM SYS.TABLES WHERE NAME = 'Staging.Clasificacion')
BEGIN 
CREATE TABLE [Staging].[Clasificacion](
	[SK_Clasificacion] [dbo].[UDT_SK] IDENTITY(1,1) NOT NULL,
	[ID_Clasificacion] [dbo].[UDT_PK] NOT NULL,
	[Nombre] [dbo].[UDT_VarcharMediano] NULL,
PRIMARY KEY CLUSTERED 
(
	[SK_Clasificacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END 
GO
/****** Object:  Table [Staging].[ColegioCandidato]    Script Date: 2/11/2019 23:12:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
if EXISTS (SELECT 1 FROM SYS.TABLES WHERE NAME = 'Staging.ColegioCandidato')
BEGIN 
CREATE TABLE [Staging].[ColegioCandidato](
	[SK_ColegioCandidato] [dbo].[UDT_SK] IDENTITY(1,1) NOT NULL,
	[ID_Colegio] [dbo].[UDT_PK] NOT NULL,
	[Nombre] [dbo].[UDT_VarcharLargo] NOT NULL,
	[FechaInicioValidez] [dbo].[UDT_DateTime] NOT NULL,
	[FechaFinValidez] [dbo].[UDT_DateTime] NULL,
	[FechaCreacion] [dbo].[UDT_DateTime] NOT NULL,
	[UsuarioCreacion] [nvarchar](100) NOT NULL,
	[FechaModificacion] [dbo].[UDT_DateTime] NULL,
	[UsuarioModificacion] [nvarchar](100) NULL,
	[ID_Batch] [dbo].[UDT_VarcharCorto] NULL,
	[ID_SourceSystem] [dbo].[UDT_VarcharCorto] NULL,
PRIMARY KEY CLUSTERED 
(
	[SK_ColegioCandidato] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END 
GO
/****** Object:  Table [Staging].[Diversificado]    Script Date: 2/11/2019 23:12:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

if EXISTS (SELECT 1 FROM SYS.TABLES WHERE NAME = 'Staging.Diversificado')
BEGIN
CREATE TABLE [Staging].[Diversificado](
	[SK_Diversificado] [dbo].[UDT_SK] IDENTITY(1,1) NOT NULL,
	[ID_Diversificado] [dbo].[UDT_PK] NOT NULL,
	[Nombre] [dbo].[UDT_VarcharLargo] NOT NULL,
	[FechaInicioValidez] [dbo].[UDT_DateTime] NOT NULL,
	[FechaFinValidez] [dbo].[UDT_DateTime] NULL,
	[FechaCreacion] [dbo].[UDT_DateTime] NOT NULL,
	[UsuarioCreacion] [nvarchar](100) NOT NULL,
	[FechaModificacion] [dbo].[UDT_DateTime] NULL,
	[UsuarioModificacion] [nvarchar](100) NULL,
	[ID_Batch] [dbo].[UDT_VarcharCorto] NULL,
	[ID_SourceSystem] [dbo].[UDT_VarcharCorto] NULL,
PRIMARY KEY CLUSTERED 
(
	[SK_Diversificado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END 
GO
/****** Object:  Table [Staging].[ExamenArea]    Script Date: 2/11/2019 23:12:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
if EXISTS (SELECT 1 FROM SYS.TABLES WHERE NAME = 'Staging.ExamenArea')
BEGIN
CREATE TABLE [Staging].[ExamenArea](
	[SK_ExamenArea] [dbo].[UDT_SK] IDENTITY(1,1) NOT NULL,
	[ID_ExamenArea] [dbo].[UDT_PK] NOT NULL,
	[NombreArea] [dbo].[UDT_VarcharMediano] NOT NULL,
	[Especial] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[SK_ExamenArea] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [Staging].[Geografia]    Script Date: 2/11/2019 23:12:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

if EXISTS (SELECT 1 FROM SYS.TABLES WHERE NAME = 'Staging.Geografia')
BEGIN
CREATE TABLE [Staging].[Geografia](
	[SK_Geografia] [dbo].[UDT_SK] IDENTITY(1,1) NOT NULL,
	[ID_Municipio] [dbo].[UDT_PK] NULL,
	[Municipio] [dbo].[UDT_VarcharMediano] NULL,
	[Departamento] [dbo].[UDT_VarcharMediano] NULL,
	[Pais] [dbo].[UDT_VarcharMediano] NULL,
PRIMARY KEY CLUSTERED 
(
	[SK_Geografia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
----ALTER TABLE 
ALTER TABLE [Fact].[ResultadoAdmision]  WITH CHECK ADD FOREIGN KEY([DateKey])
REFERENCES [Dimension].[Fecha] ([DateKey])
GO
ALTER TABLE [Fact].[ResultadoAdmision]  WITH CHECK ADD FOREIGN KEY([SK_Candidato])
REFERENCES [Dimension].[Candidato] ([SK_Candidato])
GO
ALTER TABLE [Fact].[ResultadoAdmision]  WITH CHECK ADD FOREIGN KEY([SK_Carrera])
REFERENCES [Dimension].[Carrera] ([SK_Carrera])
GO
ALTER TABLE [Fact].[ResultadoAdmision]  WITH NOCHECK ADD  CONSTRAINT [FK_ResultadoAdmision_Clasificacion] FOREIGN KEY([SK_Clasificacion])
REFERENCES [Dimension].[Clasificacion] ([SK_Clasificacion])
GO
ALTER TABLE [Fact].[ResultadoAdmision] CHECK CONSTRAINT [FK_ResultadoAdmision_Clasificacion]
GO
ALTER TABLE [Fact].[ResultadoAdmision]  WITH NOCHECK ADD  CONSTRAINT [FK_ResultadoAdmision_Colegio] FOREIGN KEY([SK_ColegioCandidato])
REFERENCES [Dimension].[ColegioCandidato] ([SK_ColegioCandidato])
GO
ALTER TABLE [Fact].[ResultadoAdmision] CHECK CONSTRAINT [FK_ResultadoAdmision_Colegio]
GO
ALTER TABLE [Fact].[ResultadoAdmision]  WITH NOCHECK ADD  CONSTRAINT [FK_ResultadoAdmision_Diversificado] FOREIGN KEY([SK_Diversificado])
REFERENCES [Dimension].[Diversificado] ([SK_Diversificado])
GO
ALTER TABLE [Fact].[ResultadoAdmision] CHECK CONSTRAINT [FK_ResultadoAdmision_Diversificado]
GO
ALTER TABLE [Fact].[ResultadoAdmision]  WITH NOCHECK ADD  CONSTRAINT [FK_ResultadoAdmision_Geografia] FOREIGN KEY([SK_Geografia])
REFERENCES [Dimension].[Geografia] ([SK_Geografia])
GO
ALTER TABLE [Fact].[ResultadoAdmision] CHECK CONSTRAINT [FK_ResultadoAdmision_Geografia]
GO
/****** Object:  StoredProcedure [dbo].[USP_FillDimDate]    Script Date: 2/11/2019 23:12:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[USP_FillDimDate]
@CurrentDate DATE = '2016-01-01', 
@EndDate DATE = '2020-12-31'
AS
    BEGIN
        SET NOCOUNT ON;
        DELETE FROM Dimension.Fecha;

        WHILE @CurrentDate < @EndDate
            BEGIN
                INSERT INTO Dimension.Fecha
                ([DateKey], 
                 [Date], 
                 [Day], 
                 [DaySuffix], 
                 [Weekday], 
                 [WeekDayName], 
                 [WeekDayName_Short], 
                 [WeekDayName_FirstLetter], 
                 [DOWInMonth], 
                 [DayOfYear], 
                 [WeekOfMonth], 
                 [WeekOfYear], 
                 [Month], 
                 [MonthName], 
                 [MonthName_Short], 
                 [MonthName_FirstLetter], 
                 [Quarter], 
                 [QuarterName], 
                 [Year], 
                 [MMYYYY], 
                 [MonthYear], 
                 [IsWeekend]
                )
                       SELECT DateKey = YEAR(@CurrentDate) * 10000 + MONTH(@CurrentDate) * 100 + DAY(@CurrentDate), 
                              DATE = @CurrentDate, 
                              Day = DAY(@CurrentDate), 
                              [DaySuffix] = CASE
                                                WHEN DAY(@CurrentDate) = 1
                                                     OR DAY(@CurrentDate) = 21
                                                     OR DAY(@CurrentDate) = 31
                                                THEN 'st'
                                                WHEN DAY(@CurrentDate) = 2
                                                     OR DAY(@CurrentDate) = 22
                                                THEN 'nd'
                                                WHEN DAY(@CurrentDate) = 3
                                                     OR DAY(@CurrentDate) = 23
                                                THEN 'rd'
                                                ELSE 'th'
                                            END, 
                              WEEKDAY = DATEPART(dw, @CurrentDate), 
                              WeekDayName = DATENAME(dw, @CurrentDate), 
                              WeekDayName_Short = UPPER(LEFT(DATENAME(dw, @CurrentDate), 3)), 
                              WeekDayName_FirstLetter = LEFT(DATENAME(dw, @CurrentDate), 1), 
                              [DOWInMonth] = DAY(@CurrentDate), 
                              [DayOfYear] = DATENAME(dy, @CurrentDate), 
                              [WeekOfMonth] = DATEPART(WEEK, @CurrentDate) - DATEPART(WEEK, DATEADD(MM, DATEDIFF(MM, 0, @CurrentDate), 0)) + 1, 
                              [WeekOfYear] = DATEPART(wk, @CurrentDate), 
                              [Month] = MONTH(@CurrentDate), 
                              [MonthName] = DATENAME(mm, @CurrentDate), 
                              [MonthName_Short] = UPPER(LEFT(DATENAME(mm, @CurrentDate), 3)), 
                              [MonthName_FirstLetter] = LEFT(DATENAME(mm, @CurrentDate), 1), 
                              [Quarter] = DATEPART(q, @CurrentDate), 
                              [QuarterName] = CASE
                                                  WHEN DATENAME(qq, @CurrentDate) = 1
                                                  THEN 'First'
                                                  WHEN DATENAME(qq, @CurrentDate) = 2
                                                  THEN 'second'
                                                  WHEN DATENAME(qq, @CurrentDate) = 3
                                                  THEN 'third'
                                                  WHEN DATENAME(qq, @CurrentDate) = 4
                                                  THEN 'fourth'
                                              END, 
                              [Year] = YEAR(@CurrentDate), 
                              [MMYYYY] = RIGHT('0' + CAST(MONTH(@CurrentDate) AS VARCHAR(2)), 2) + CAST(YEAR(@CurrentDate) AS VARCHAR(4)), 
                              [MonthYear] = CAST(YEAR(@CurrentDate) AS VARCHAR(4)) + UPPER(LEFT(DATENAME(mm, @CurrentDate), 3)), 
                              [IsWeekend] = CASE
                                                WHEN DATENAME(dw, @CurrentDate) = 'Sunday'
                                                     OR DATENAME(dw, @CurrentDate) = 'Saturday'
                                                THEN 1
                                                ELSE 0
                                            END     ;
                SET @CurrentDate = DATEADD(DD, 1, @CurrentDate);
            END;
    END;

--SELECT * FROM Dimension.Fecha;
END
GO


EXEC sys.sp_addextendedproperty @name=N'Desnormalizacion', @value=N'La dimension candidato provee una vista desnormalizada de las tablas origen Candidato, Diversificado y Colegio, dejando todo en una única dimensión para un modelo estrella' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Candidato'
GO
EXEC sys.sp_addextendedproperty @name=N'Desnormalizacion', @value=N'La dimension carrera provee una vista desnormalizada de las tablas origen Facultad y Carrera en una sola dimensión para un modelo estrella' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Carrera'
GO
EXEC sys.sp_addextendedproperty @name=N'Desnormalizacion', @value=N'La dimension fecha es generada de forma automatica y no tiene datos origen, se puede regenerar enviando un rango de fechas al stored procedure USP_FillDimDate' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Fecha'
GO
