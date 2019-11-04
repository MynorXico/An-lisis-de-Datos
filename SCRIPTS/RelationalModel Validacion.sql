
/****** Object:  UserDefinedFunction [dbo].[GetClasificacion]    Script Date: 2/11/2019 23:05:27 ******/

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('dbo.GetClasificacion') IS NULL
BEGIN
EXEC ('CREATE FUNCTION [dbo].[GetClasificacion]
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
	RETURN (select SK_Clasificacion from [Admisiones_DWHProyecto].Staging.Clasificacion WHERE ID_Clasificacion = @answer);
END;
')
END
GO
/****** Object:  Table [dbo].[Candidato]    Script Date: 2/11/2019 23:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

if NOT EXISTS (SELECT * FROM sys.objects WHERE object_id=OBJECT_ID(N'dbo.Candidato') )
BEGIN
CREATE TABLE [dbo].[Candidato](
	[ID_Candidato] [int] NOT NULL,
	[ID_Colegio] [int] NULL,
	[ID_Diversificado] [int] NULL,
	[Nombre] [varchar](300) NOT NULL,
	[Apellido] [varchar](300) NULL,
	[Genero] [char](1) NULL,
	[FechaNacimiento] [datetime] NULL,
	[ID_Municipio] [int] NULL,
	[ID_Carrera] [int] NULL,
	[Edad] [int] NULL,
 CONSTRAINT [PK__Candidat__9CD2D68BBE65DFC7] PRIMARY KEY CLUSTERED 
(
	[ID_Candidato] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Carrera]    Script Date: 2/11/2019 23:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

if NOT EXISTS (SELECT * FROM sys.objects WHERE object_id=OBJECT_ID(N'dbo.Carrera') )
BEGIN
CREATE TABLE [dbo].[Carrera](
	[ID_Carrera] [int] IDENTITY(1,1) NOT NULL,
	[ID_Facultad] [int] NULL,
	[Nombre] [varchar](300) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_Carrera] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ColegioCandidato]    Script Date: 2/11/2019 23:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
if NOT EXISTS (SELECT * FROM sys.objects WHERE object_id=OBJECT_ID(N'dbo.ColegioCandidato') )
BEGIN
CREATE TABLE [dbo].[ColegioCandidato](
	[ID_Colegio] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](600) NOT NULL,
 CONSTRAINT [PK__ColegioC__3D2473A710CFB8F0] PRIMARY KEY CLUSTERED 
(
	[ID_Colegio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Departamento]    Script Date: 2/11/2019 23:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

if NOT EXISTS (SELECT * FROM sys.objects WHERE object_id=OBJECT_ID(N'dbo.Departamento') )
BEGIN
CREATE TABLE [dbo].[Departamento](
	[ID_Departamento] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](300) NULL,
	[ID_Pais] [int] NULL,
 CONSTRAINT [PK__Departam__32FFD1C7F41AA609] PRIMARY KEY CLUSTERED 
(
	[ID_Departamento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[DescuentoExamen]    Script Date: 2/11/2019 23:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

if NOT EXISTS (SELECT * FROM sys.objects WHERE object_id=OBJECT_ID(N'dbo.DescuentoExamen') )
BEGIN
CREATE TABLE [dbo].[DescuentoExamen](
	[ID_Descuento] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](300) NOT NULL,
	[PorcentajeDescuento] [decimal](6, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_Descuento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Diversificado]    Script Date: 2/11/2019 23:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

if NOT EXISTS (SELECT * FROM sys.objects WHERE object_id=OBJECT_ID(N'dbo.Diversificado') )
BEGIN
CREATE TABLE [dbo].[Diversificado](
	[ID_Diversificado] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](600) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_Diversificado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ExamenArea]    Script Date: 2/11/2019 23:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
if NOT EXISTS (SELECT * FROM sys.objects WHERE object_id=OBJECT_ID(N'dbo.ExamenArea') )
BEGIN
CREATE TABLE [dbo].[ExamenArea](
	[ID_ExamenArea] [int] IDENTITY(1,1) NOT NULL,
	[NombreArea] [varchar](300) NOT NULL,
	[Especial] [bit] NULL DEFAULT ((0)),
PRIMARY KEY CLUSTERED 
(
	[ID_ExamenArea] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Facultad]    Script Date: 2/11/2019 23:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
if NOT EXISTS (SELECT * FROM sys.objects WHERE object_id=OBJECT_ID(N'dbo.Facultad') )
BEGIN
CREATE TABLE [dbo].[Facultad](
	[ID_Facultad] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](300) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_Facultad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Municipio]    Script Date: 2/11/2019 23:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

if NOT EXISTS (SELECT * FROM sys.objects WHERE object_id=OBJECT_ID(N'dbo.Municipio') )
BEGIN
CREATE TABLE [dbo].[Municipio](
	[ID_Municipio] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](300) NULL,
	[ID_Departamento] [int] NULL,
 CONSTRAINT [PK__Municipi__ED00F5B580CF03F3] PRIMARY KEY CLUSTERED 
(
	[ID_Municipio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Pais]    Script Date: 2/11/2019 23:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

if NOT EXISTS (SELECT * FROM sys.objects WHERE object_id=OBJECT_ID(N'dbo.Pais') )
BEGIN
CREATE TABLE [dbo].[Pais](
	[ID_Pais] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](300) NULL,
 CONSTRAINT [PK__Pais__AE88C4EFDA160E73] PRIMARY KEY CLUSTERED 
(
	[ID_Pais] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ResultadoAdmision]    Script Date: 2/11/2019 23:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

if NOT EXISTS (SELECT * FROM sys.objects WHERE object_id=OBJECT_ID(N'dbo.ResultadoAdmision') )
BEGIN
CREATE TABLE [dbo].[ResultadoAdmision](
	[ID_Resultado] [int] IDENTITY(1,1) NOT NULL,
	[ID_Candidato] [int] NULL,
	[ID_Carrera] [int] NULL,
	[ID_Descuento] [int] NULL,
	[FechaPrueba] [datetime] NULL DEFAULT (getdate()),
	[Precio] [decimal](6, 2) NULL,
	[Nota] [decimal](5, 2) NULL,
	[TotalAciertos] [int] NULL,
	[TotalPreguntas] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_Resultado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ResultadoAdmision_detalle]    Script Date: 2/11/2019 23:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

if NOT EXISTS (SELECT * FROM sys.objects WHERE object_id=OBJECT_ID(N'dbo.ResultadoAdmision_detalle') )
BEGIN
CREATE TABLE [dbo].[ResultadoAdmision_detalle](
	[ID_ResultadoDetalle] [int] IDENTITY(1,1) NOT NULL,
	[ID_Resultado] [int] NULL,
	[ID_ExamenArea] [int] NULL,
	[NotaArea] [decimal](5, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_ResultadoDetalle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Status]    Script Date: 2/11/2019 23:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

if NOT EXISTS (SELECT * FROM sys.objects WHERE object_id=OBJECT_ID(N'dbo.Status') )
BEGIN
CREATE TABLE [dbo].[Status](
	[ID_Status] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](300) NULL,
 CONSTRAINT [PK_Status] PRIMARY KEY CLUSTERED 
(
	[ID_Status] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[StatusAdmision]    Script Date: 2/11/2019 23:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

if NOT EXISTS (SELECT * FROM sys.objects WHERE object_id=OBJECT_ID(N'dbo.StatusAdmision') )
BEGIN
CREATE TABLE [dbo].[StatusAdmision](
	[ID_ResultadoAdmision] [int] NULL,
	[ID_Status] [int] NULL
) ON [PRIMARY]
END
GO

--xx
ALTER TABLE [dbo].[Candidato] WITH NOCHECK ADD  FOREIGN KEY ([ID_Carrera])
REFERENCES [dbo].[Carrera] ([ID_Carrera])
GO

ALTER TABLE [dbo].[Candidato]  WITH NOCHECK ADD  FOREIGN KEY([ID_Diversificado])
REFERENCES [dbo].[Diversificado] ([ID_Diversificado])
GO

ALTER TABLE [dbo].[Candidato]  WITH NOCHECK ADD  FOREIGN KEY([ID_Carrera])
REFERENCES [dbo].[Carrera] ([ID_Carrera])
GO


ALTER TABLE [dbo].[Carrera]  WITH NOCHECK ADD  FOREIGN KEY([ID_Facultad])
REFERENCES [dbo].[Facultad] ([ID_Facultad])
GO

ALTER TABLE [dbo].[Departamento]  WITH NOCHECK ADD  FOREIGN KEY([ID_Pais])
REFERENCES [dbo].[Pais] ([ID_Pais])
GO


ALTER TABLE [dbo].[Municipio]  WITH NOCHECK ADD  FOREIGN KEY([ID_Departamento])
REFERENCES [dbo].[Departamento] ([ID_Departamento])
GO


ALTER TABLE [dbo].[ResultadoAdmision] WITH NOCHECK ADD  FOREIGN KEY([ID_Candidato])
REFERENCES [dbo].[Candidato] ([ID_Candidato])
GO


ALTER TABLE [dbo].[ResultadoAdmision]  WITH NOCHECK ADD  FOREIGN KEY([ID_Carrera])
REFERENCES [dbo].[Carrera] ([ID_Carrera])
GO

ALTER TABLE [dbo].[ResultadoAdmision] WITH NOCHECK ADD  FOREIGN KEY([ID_Descuento])
REFERENCES [dbo].[DescuentoExamen] ([ID_Descuento])
GO

ALTER TABLE [dbo].[ResultadoAdmision_detalle] WITH NOCHECK ADD  FOREIGN KEY([ID_ExamenArea])
REFERENCES [dbo].[ExamenArea] ([ID_ExamenArea])
GO

ALTER TABLE [dbo].[ResultadoAdmision_detalle]  WITH NOCHECK ADD  FOREIGN KEY([ID_Resultado])
REFERENCES [dbo].[ResultadoAdmision] ([ID_Resultado])
GO
